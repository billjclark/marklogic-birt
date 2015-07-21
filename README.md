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

The example reports in this project use the Shakespeare XML Source for the Plays MarkLogic Database. See the Bill Gethub project at https://github.com/marklogic/bill for details.

## Configuration Steps

To generate MarkLogic BIRT reports from any web server, you must: 

1) Install MarkLogic Server.
2) Install the "bill" database on the MarkLogic server.
3) Install a webserver such as tomcat, JBOSS, or BIRT iHub.  Tomcat is optimal for the open source version of BIRT.  iHub allows you to take full advantage of the comercial features of BIRT.  Some of the features include best of breed excel export, third party HTML5 charting, and dashboards.
4) Add the project files to your web application from this github project.  
5) Install curl.
6) Installs the BIRT search REST extension by executing the Curl command that  that is found in birtsearch.bat.

## How to create a New BIRT report

## Important Files

birtsearch.xqy - xQuery file that creates the BIRT Search REST Extension\
birtsearch.bat - Windows batch file that contains the curl statement that inserts the REST extension into the database.
move.bat - Moves *rptdesign files and *.jsp files from project directory to web app directory
document.rptdesign - A report example that uses the document endppoint
search.rptdesign - A report expample that uses the BIRT search REST extension endpoint

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
