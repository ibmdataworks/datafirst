[<img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/media/EventHeader.png">](https://github.com/ibmdataworks/datafirst/)
#Hands on Lab - Application Developer.
[<img src="https://github.com/ibmdataworks/datafirst/raw/master/datascientist/media/ADE2E.png">](https://github.com/ibmdataworks/datafirst/tree/master/appdeveloper)

As an Application Developer, you need multiple application and data services that facilitate a modern architecture and delivery practices around mobile, microservices, DevOps and continuous delivery. Perform hands-on exercises to quickly build and deploy a live dashboard with Node.js connceted to a document data service, IBM Cloudant based on CouchDB.


##Lab Components: IBM Bluemix Cloud Offering Used

1.  **Source Data Repository**: **Cloudant NoSQL DB**

2.  **Software Development Tools**: **DevOps Services and Git **

3.  **Runtime Environment**: **SDK for Node.js**

 <img src="./media/image1.png" width="487" height="175" />

Watch Full Lab Video (Optional): https://youtu.be/jhFo47juTFI
 > [<img src="https://github.com/ibmdataworks/datafirst/blob/master/datascientist/media/AD Video.png" width="382">](https://youtu.be/jhFo47juTFI "Business Analyst")


#Step 1. Get on BlueMix...

> NOTE: If you already have a Bluemix account then skip this steps:

1.  Go to [www.bluemix.net](http://www.bluemix.net)

2.  Click the signup button on the top right

 > <img src="./media/image2.png" width="624" height="171" />

3.  On the next page fill in the corresponding fields and click “Create Account”

 > <img src="./media/image3.png" width="624" height="300" />

4.  You will see a page asking you to check your email for next steps. Check your email that you used to sign up for Bluemix

 > <img src="./media/image4.png" width="237" height="219" />

5.  Click on the “confirm your account” link

 > <img src="./media/image5.png" width="396" height="330" />

#Step 2. Dowload Data Files

1.  Download Lab-NodejsDashboard.zip archive from the github.com location below and save to your laptop:

2.  https://github.com/ibmdataworks/datafirst/tree/master/appdeveloper/nodejsDashboard.zip

Step 3. Create Data Source - Cloudant NoSQL DB Service
============================================================

1.  From the Bluemix dashboard catalog menu search for “Cloudant”

2.  Click on the Cloudant Icon <img src="./media/image6.png" width="31" height="27" /> under the Data & Analytics section.

3.  Choose the default pre-filled values in the fields (optionally rename the “Service name:” to AD-Greatoutdoors-DB), select the “Lite Pricing Plan” and click “Create” at the bottom of the page.

4.  In the top, right corner of the page click **Launch**

5.  The Cloudant page will open in a new tab. Select the new tab.

6.  Select the **Databases** tab on the left-hand navigation bar

7.  In the top navigation bar select “**Create Database**”

8.  Create a new database named “**greatoutdoors**” (*Note: database names are case sensitive*). Click **create** to finalize the creation.

9.  In the following steps we will create two indices to allow queries against the data set. Note: Any parameter which is used in a query must be indexed.

10.  Click the + symbol on **Design Documents**.

11.  Select **Query Indexes**

12.  Click in the **Index** text box and select all the text

13.  Replace the text with the following text:

 > {
 >
 > "index": {
 >
 > "fields": \[{"evictTS" : "asc"}, "storeID", "zoneID"\]
 >
 > },
 >
 > "name" : "evictTS-index",
 >
 > "type" : "json"
 >
 > }

14.  Click “**Create Index**”

15.  Click on the **greatoutdoors** database to return to the database page.

16.  Create another index by selecting all the text in the existing index box and replacing it with the following text:

 > {
 >
 > "type": "text",
 >
 > "name": "text-index",
 >
 > "index": {}
 >
 > }

17.  Click “**Create Index**”

 > *Note: If the creation of either index fails, check to be sure that the double quotes have not been mangled by the cut-and-paste process. They should be standard double quotes and not inverted.*

18.  You are now ready to move to the next service – SDK for Node.js Runtime. Return to the previous browser tab and click on the **catalog** button in the top navigation bar.

Step 4. Create Application - SDK for Node.js Runtime Service
==================================================================

1.  From the Bluemix catalog menu search for “**foundry**”.

2.  Click on the **Cloud Foundry Applications** icon <img src="./media/image7.png" width="41" height="33" />

3.  Click on the **SDK for Node.js** icon <img src="./media/image8.png" width="37" height="37" />

4.  Create a name the service and the host. *Note: The host name needs to be unique. If you receive an error message it is likely that the host name you created is already in use.*

5.  Choose the default pricing plan and click “**Create**” at the bottom of the page.

 > *Note: Allow your new SDK for Node.js runtime service to stage. This could take 30-40 seconds.*

6.  Click on the “**Connections**” tab in the top navigation bar when staging is complete.

    a.  Click on the blue “**Connect Existing**” button on the top, right side of the page.

    b.  Click on the **NoSQL Cloudant DB** service you created in section 4 and click **Connect**

    c.  You will be prompted to restage your application. Click **Restage**.

    d.  *Note: Allow 30-40 seconds for your application to restage.*

    e.  Binding services allows the Node.js service to authenticate to Cloudant without hard coding credentials in the JavaScript code. It uses environment variables on the server-side to share the credentials between services.

7.  In the top, navigation bar click the “**Overview**” tab.

    a.  In the Continuous Delivery panel select “**Add Git Repo and Pipeline**”

    b.  If you already have a jazz.net account bind with that account. Otherwise, enter a n alias (account name) to allow Bluemix to create a Dev Ops account for you.

    c.  Accept the DevOps Services terms by ticking the box.

    d.  Click **Create**

    e.  Once your Git account has been created you will be notified. Click **Continue**

    f.  Once the Git repo has been create you will be prompted:

 > *Populate the repo with the starter app package and enable the Build & Deploy pipeline?*

	g.  **Tick the box** and click **Continue**

	h.  Once the Git repo is created you will be notified. Click **Close**

	i.  In the Continuous Deliver panel select **Configure**

	j.  You should see two stages which have been created for you. One for Build and the other for Deploy.


8.  DevOps Service for Bluemix

    a.  Click on the settings “star” icon for the **Build Stage** and select **Configure Stage**.

    b.  Select **Input** tab

    c.  At the bottom of the screen change “**State Trigger**” from “Run jobs whenever a change is pushed to Git” to “Run jobs only when this stage is run manually”.

    d.  Click “**Save**”

9.  Return to your Git repo

    a.  Select “**Edit Code**” on the top navigation bar

    b.  In the left-hand pane click on the top entry with the twisty icon. We are going to import code and it is important that we import it to the root of the folder.

    c.  In the Application Menu select File -&gt; Import -&gt; File or Zip Archive

    d.  Browse to the zip file you downloaded in the Before You Begin section.

    e.  You will be prompted if it should unzip the .zip file. Click **OK**.

    f.  The import will fail and then ask *“Would you like to retry the import with force overwriting?*”. If you are not prompted the import may have failed.

    g.  Click **Yes**.

    h.  You will need to edit **Manifest.yml** to change the location where the application is hosted. Change both occurrences of NodejsDashboard to the name of your mybluemix.net host route. The host is usually the same name as your project unless there was a conflict. Note: The file will save automatically.

10.  In the left-hand navigation bar click the **Git** icon <img src="./media/image9.png" width="29" height="32" /> just below “**edit code**”

    a.  Allow the page to completely refresh all the code changes. You should see 11 files selected in the right-hand pane.

    b.  Enter a comment into the comment window and click **Commit**.

    c.  In the **Outgoing** source tab on the left side of the page click **Push**. This will deliver (push) the commits to the server.

11.  DevOps Service for Bluemix

    a.  Select **Build and Deploy** on the top navigation bar

    b.  Click the play button on the **Build stage** to build the newly delivered code. If the build is successful the Deploy stage should start automatically and deploy your code to the server.

    c.  Once the Deploy stage has completed and passed, right click on the application URL and **open in a new browser tab** by right clicking on the URL.

12.  Node.js runtime Service

    a.  Browse to your mybluemix.net URL where your web application is hosted. You should see a d3.js graph with 5 bars representing the 5 zones in the store.

    b.  After 30 seconds, the application should read from the Cloudant database and the values for each store should change.

<img src="./media/image10.png" width="625" height="306" />

***End of Lab***
