# Copyright (c) 2016 IBM Corporation and others.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#' Produce a data frame for a decison tree model (C5.0, ctree, simpleparty)
#'
#' This function "flattens" the decision tree: the resulting data frame 
#' contains Predition, Samples (the number of training samples matched to the branch),
#' Error (the percent of training samples misclassified by this branch),
#' Name (a short name for the branch, the same as the last condition),
#' Level1, ..., Leveln (the condition on the i-th level of the branch)
#' 
#' @param node the decision tree model (C5.0, ctree, simpleparty)
#' @export
getRules <- function(node, ...) {
  UseMethod("getRules")
}

getRules.NULL <- function(node, ...) {
  return(NULL)
}

getRules.C5.0 <- function(tree, ...) {
    getRules.simpleparty(as.simpleparty(C50:::as.party.C5.0(classifierModel)))
}


getRules.constparty <- function(tree, ...) {
    getRules.simpleparty(as.simpleparty(tree))
}

getRules.simpleparty <- function(tree, ...) {
  if(is.null(tree$node)) return(NULL)
    if(is.null(tree$node$kids)) {
      rules <- with(
       tree$node,
       list(
          Samples      = as.numeric(info$n), 
          Prediction   = as.character(info$prediction),
          Error        = as.numeric(info$error),
          Name         = "All transactions"
       )
      )
    } else {
          parentLabels = c()
          rules <- getRules(nodes=tree$node$kids, parentNode=tree$node, parentLabels=parentLabels, tree=tree)
    }
    # returning rules data frame
    rbind.fill(lapply(rules, as.data.frame, stringsAsFactors=FALSE))
}

getRules.list <- function(nodes, parentNode, parentLabels, tree, level=0, ...) {
  #Background: we need to push the labels down to the terminal node and return the accumulated result
  #Please note that using just[index] will lead to infinite recursion
  listOfRulesInListForm <- lapply(1:length(nodes), 
         FUN=function(index) {
             getRules(node=nodes[[index]], 
                      parentNode=parentNode, 
                      indexInParent=index, 
                      parentLabels = parentLabels, 
                      tree=tree,
                      level=level
                     )
         })
    # c concatenates lists of lists, but they should be lists of lists!!!
    return (do.call(c,listOfRulesInListForm))
}

getRules.partynode <- function(node, parentNode, indexInParent, parentLabels, tree, level, ...) {
    level <- level+1
    if(is.null(node$kids)) {
       getRules.TerminalNode(node=node, 
                             parentNode=parentNode, 
                             indexInParent=indexInParent, 
                             parentLabels = parentLabels, 
                             tree=tree,
                             level=level
                            )
    } else {
       currentCondition <- getRuleCondition(node=node, 
                                            parentNode=parentNode, 
                                            indexInParent=indexInParent, 
                                            tree=tree)
       levelLabel <- paste("Level", level, sep="")
       parentLabels <- c(parentLabels, setNames(list(currentCondition),levelLabel))
       getRules(nodes=node$kids,parentNode=node, parentLabels = parentLabels, tree=tree, level=level)
    }
}

getRules.TerminalNode <- function(node, parentNode, indexInParent, parentLabels, tree, level, ...) {
    terminalNodeCondition <- getRuleCondition(node=node, 
                                              parentNode=parentNode, 
                                              indexInParent=indexInParent, 
                                              tree=tree)
    levelLabel <- paste("Level", level, sep="")
    conditions <- c(parentLabels, setNames(list(terminalNodeCondition),levelLabel))
    # list of lists is used to be able to concatenate the results!
    with(node, list(c(list(Samples = as.numeric(info$n),
                                  Prediction = as.character(info$prediction),
                                  Error = as.numeric(info$error),
                                  Name = terminalNodeCondition
                                 ),
                             conditions
                            )
                           )
    )
}

getRuleCondition <- function(node, parentNode, indexInParent, tree) {
        # this code may be optimized to avoid repeated calls to build 
        # node labels
        splitConditions <- character_split(split_node(parentNode), tree$data)
        splitConditions <- ifelse(substr(splitConditions$levels, 1, 1) %in% c("<", ">"),
             paste(splitConditions$name, splitConditions$levels), 
             paste(splitConditions$name, "in", splitConditions$levels))
        return (splitConditions[indexInParent])
}
