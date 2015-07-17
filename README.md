# marklogic-birt

> MarkLogic-BIRT demonstrates how to integrate BIRT into a MarkLogic application.

## README for Version 1.0

This release focuses on the minimal requirements to create a chart and a table report from markLogic documents using the xml datasource.  The xml source is the collection of plays of William Shakespeare.

For the instructions, we are going to assume that the user is new to both MarkLogic and BIRT.  We have broken out the instructions to a series of steps where each step has detailed instructions.

## Getting Started


To start, clone this repository. For example, run the following command:  

```
git clone https://github.com/marklogic/marklogic-birt


This application is designed to run on MarkLogic Server 8.0 and later.

To generate MarkLogic BIRT reports, you must: 

a) Install MarkLogic Server
b) download the XML source
c) configure MarkLogic server
d) Install tomcat or BIRT iHub
e) create a tomcat application from this github project.
f) Install curl.


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



