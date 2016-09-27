#Data Scientist 
#Part 1 - Root Cause Analysis..
[<img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/media/DSE2E1.png">](https://github.com/ibmdataworks/datafirst/tree/master/datascientist/interactive-analytics/)

This lab exercise uses an IPython Notebook in Data Science Experience to connect with dashDB, explores sales, product data and analyze sales performance for a specific product line. Pixiedust, a Python based visualization package is used to visualize the results.

![overview](https://github.com/gfilla/testing/raw/master/media/overview.gif)

Lab Video: https://youtu.be/sHm4IHHZq2w
 > [<img src="https://github.com/ibmdataworks/datafirst/blob/master/datascientist/media/DS Video.png" width="382">](https://youtu.be/sHm4IHHZq2w "Data Science")

#Step 1. Provision dashDB

1.	Login to IBM Bluemix

  a.	For existing accounts use  https://new-console.ng.bluemix.net/login

  b.	Sign-up for a free trial account at https://console.ng.bluemix.net/registration/

2.	Provision dashDB

  a.	From the Bluemix catalog menu search for “dashdb”

  b.	Click on the dashDB Icon

  c.	Accept the default values and rename “Service name:” to ‘DS_Sales_DataStore’

  d.	Select “Entry Pricing Plan” (default) and click “Create” on the right hand panel.

The dashDB service is provisioned along with sample database and lab exercise will use the sample database.

---
#Step 2. Provision Spark Service in Data Science Experience

1.	Login to IBM Data Science Experience @ http://datascience.ibm.com/

2.	Create a new Notebook

  a.	Click on ‘Start a Notebook”

    ![start notebook](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/dsxIntro.gif)

    b.	If this is your first Notebook, you will see a message that you need Spark service. Click on ‘Create a Spark Service here’ link in the message to provision Spark Service.

    c. 	Type ‘IA_Lab_Spark’ as the Spark service name and accept defaults (Personal plan for Spark service, New Object Storage with free plan).

    d.	Click ‘Create Instance’ to create Spark Service.

---
#Step 3. Load Notebook and Perform Analysis

1. At the top of the screen click the plus-sign icon to create a notebook.

<img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/createnew.png" width="250"> 
 
2. Type ‘IA_Lab_Notebook’ as Notebook name, click on ‘from URL’ link and specify:  https://raw.githubusercontent.com/ibmdataworks/datafirst/master/datascientist/interactive-analytics/DSX_IA_Lab.ipynb

 ![start notebook](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/createNotebook.gif)

  a.	 Select ‘Trust this Notebook to run with your Privileges’ and click on ‘Create Notebook’
  
 ![trust notebook](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/sparkService.gif)
1. Once notebook is created, add dashDB as a data asset for the project

<img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/adddataassets.png" width="250"> 

  a.	Now click on the '1001' icon then Connections -> New Connection
  

<img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/newaddconnection.png" width="250"> 

  b.	Key in ‘dashDB’ as connection name

  c.	From drop down list of ‘Target Service Instance’ select ‘DS_Sales_DataStore’, the dashDb service you provisioned in Bluemix.

  d.	Select ‘Database’ as ‘BLUDB’.

  e.	Click ‘Create’.

1.	Go back to your default project (using the menu on the top left) to open your Notebook and add the data source

  a.	Open your notebook in the project in 'Edit' mode using the pencil icon
 
  <img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/editnotebook.png" width="250"> 

  b. 	Click on the '1001' icon to add a data source and click Connections to insert your DashDB connection

  <img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/addconnectionNotebook.png" width="250"> 

1.	From the Notebook, connect to the sample sales database in dashDB

  a.	Place the cursor in the first cell. This should be empty, if not clear the contents.

  b.	Click on ‘Insert Code’  to insert credentials for the data source ‘dashDB’

    ![insert to code](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/addSource.gif)

  c.	Rename the inserted array variable ‘credentials_1’  to ‘credentials’

    ![credentials](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/credentials.gif)

  d.	To execute code in any notebook cell, place cursor in cell and click the arrow icon in toolbar

  ![execute in notebook](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/notebookNav.gif)

  e.	Place cursor in cell1, execute code to capture dashDB database credentials

  f.	Place cursor in cell2, execute code to connect, load tables from dashDB
3.	Query, join and group data using SparkSQL Data frame API to build aggregated sales for the product line ‘Outdoor Protection’.

  a.	Place cursor in cell3 and execute code to build aggregated sales data frame

  b.	Place cursor in cell4 and execute code to install or update Pixiedust package

  c.	Place cursor in cell5 and execute code to  visualize SparkSQL Data frame

  ![execute in notebook](https://github.com/ibmdataworks/datafirst/raw/master/datascientist/interactive-analytics/media/finalViz.gif)

7.	You can move the mouse over the visual to see data points on each bar. The chart shows a steady decline in sales for ‘Outdoor Protection’ product line.
8.	Pixiedust is an open source visualization package developed by IBM labs. You can visualize SparkSQL data frames with a single API call and interactively access raw data, pick visual options and stow data away to files or IBM Cloudant or Object Storage.

--- 
#### End of Lab

##### [Next Steps: Build your next Spark Analytics project using IBM Data Science Experience.](https://github.com/ibmdataworks/datafirst/tree/master/datascientist/machinelearning)
