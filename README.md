# marklogic-birt

> MarkLogic-BIRT demonstrates how to integrate BIRT into a MarkLogic application.

## README for Version 1.0

This release focuses on the minimal requirements to create a chart and a table report from markLogic documents using the xml datasource.  The files in the github repository need to be included in the web application that is serving the BIRT reports.  
The xml source is the collection of plays of William Shakespeare.

For the instructions, we are going to assume that the user is new to both MarkLogic and BIRT.  We have broken out the instructions to a series of steps where each step has detailed instructions.

## Getting Started


To start, clone this repository and then download the Eclipse BIRT project at http://www.eclipse.org/birt/. For example, run the following command:  

```
git clone https://github.com/marklogic/marklogic-birt


This application is designed to run on MarkLogic Server 8.0 and later.  We also recommend using the latest version of BIRT.

The example reports in this project use the Shakespeare XML Source for the Plays MarkLogic Database. See the Bill Github project at https://github.com/marklogic/bill for details.

## Configuration Steps

To generate MarkLogic BIRT reports from any web server, you must: 

1) Install MarkLogic Server.
2) If you want to see working sample reports, install the "bill" database on the MarkLogic server.  Otherwise, create and populate the database that you want to report on.
3) Create a MarkLogic HTTP server for the database that you want to report on.
4) Set the HTTP server authentication level to "application-level."  (The open source BIRT xml data source has no way of asking for a username/password.)
5) Install a webserver such as tomcat, JBOSS, or BIRT iHub.  Tomcat is optimal for the open source version of BIRT.  iHub allows you to take full advantage of the comercial features of BIRT.  Some of the iHub features include best of breed excel export, third party HTML5 charting, interactive report viewer, and dashboards.
6) Add the marklogic-birt project files to your web application from this github project.  For Tomcat, simply place a copy of the marklogic-birt directory in the Tomcat webapps directory.  Typically, the path is C:\Program Files\Apache Software Foundation\Tomcat 8.0\webapps.
7) Install curl.
8) Create the BIRT search REST extension by executing the Curl command that is found in birtsearch.bat.
9) Download and install the Eclipse BIRT Report Designer found at http://www.eclipse.org/birt/.
					--OR--
   Alternatively, you can install the commercial OpenText BIRT Designer if you want to use the BIRT iHub Server.

## How to create a New BIRT report

Before you start creating your own reports, I suggest that you study how document.rptdesign and search.rptdesign are built.  These files are xml files so you can look at them in a xml editor and the Eclipse report designer.  The MarkLogic specific parts of the report to focus on are:

* The parameters
* The XML URL in the xml data source
* The beforeopen script method of the data source. Click on the data source object in the Data Explorer pane and then click on the script tab in the main pane.

1) Decide if you want to use the document end point or the BIRT Search REST extension endpoint.
2) Open the Report Design view in Eclipse.
3) Add the parameters that you are going to use in constructing the REST URL string.  For the document endpoint, the parameters will be URI(s).  For the BIRT search REST extension, the parameters will be the query string and the node expression that you want to return.
4) Select File->New->Report from the menu or by right mouse clicking in the navigator pane.
5) Create an new xml datasource.  In the Data Explorer Pane, right mouse click on Data Source and select new Data Source
6) Build the REST call with the parameters.  While your XML Data Source is selected, click on the Script pane in the work area.  Cut and paste either the document endpoint or the BIRT search extension endpoint code into the beforeopen event and then modify it as needed.

The example document REST end point code is:

fileName = this.getExtensionProperty("FILELIST");
if (params["docURI"].value != "z"){
	newFileName = "http://localhost:8003/v1/documents?uri=/shakespeare/plays/" + params["docURI"].value;
}
else{
	newFileName = fileName;
}
this.setExtensionProperty("FILELIST",newFileName);

The example BIRT search extension endpoint code is:

fileName = this.getExtensionProperty("FILELIST");
if (params["q"].value != "z"){
	newFileName = "http://localhost:8003/v1/resources/birtsearch?rs:" + params["q"].value;
}
else{
	newFileName = fileName;
}
this.setExtensionProperty("FILELIST",newFileName);

7) Create a new dataset that uses the new xml data source.  Follow the wizard.  The first step in creating a data set is to define the "row."  Generally chose the element that is the in the deepest layer of the hierarchy the then use xpath to get the parent elements and attributes.  After defining the "row," define the "columns."  
8) Once the dataset(s) are created, use BIRT as if you are writing a SQL report.
9) After you have finished laying out the elements of your report, copy it over to the web application where you are going to launch the report.

## Important Files

birtsearch.xqy - xQuery file that creates the BIRT Search REST Extension\
birtsearch.bat - Windows batch file that contains the curl statement that inserts the REST extension into the database.
move.bat - Moves *rptdesign files and *.jsp files from project directory to web app directory
document.rptdesign - A report example that uses the document endppoint
search.rptdesign - A report expample that uses the BIRT search REST extension endpoint
index.jsp - Simple jsp page that you can launch reports from.  THe html is really basic and just meant to  show how to add BIRT reporting to your application.
BIRT_xpath.doc - A whitepaper on how the xml data source workd.
Everything else - THese are the minimum set of files needed to add BIRT reports to your web application.

## Why do we really need a BIRT Search REST Extension?

We only really need to create a search REST extension because the current Search endpoint returns a content type that is unrecognized by BIRT and we get a HTTP Error Bad Request.  The main purpose of the BIRT Search rest extension is to set the output type to "application/xml."

We could avoid needing to use a REST extension by creating a MarkLogic specific XML data source.  This data source would be a simple extension of the open source XML data source.  As well as changing the acceptable output types, we could handle security.  Currently, there is no way to "login" with BIRT but this would be relatively simple to add in a MarkLogic BIRT data source.


 
To download the Shakespeare XML Source for the Plays, download
the zip file containing the source:

   The shakespeare XML source is available via the following URL:

     http://www.oasis-open.org/cover/bosakShakespeare200.html

   This points to a zip file at the following location:

     http://metalab.unc.edu/bosak/xml/eg/shaks200.zip

  The XML source is subject to the copyright stated in the XML files.

To set up the MarkLogic Server Configuration:

1) Create a forest (for example, named bill).

2) Create a database (for example, named bill).

3) Attach the forest to the database.

4) (optional) In addition to the default options, add 'word positions' to the 
   indexing options for the database.  This will improve the performance of
   phrase searches.

5) (optional) Add SCENE as a fragment root for the database.  This will 
   improve the performance of the application.


Any issues contact me at bill.clark@marklogic.com
