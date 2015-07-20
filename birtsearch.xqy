xquery version "1.0-ml";

(: Namespace pattern must be:  
 : "http://marklogic.com/rest-api/resource/{$rname}" 
 : and prefix must match resource name :)
module namespace birtsearch =
  "http://marklogic.com/rest-api/resource/birtsearch";

(: Conventions: 
 : Module prefix must match resource name, 
 : and function signatures must conform to examples below.
 : The $context map carries state between the extension
 : framework and the extension.
 : The $params map contains parameters set by the caller,
 : for access by the extension.
 :)

(: Function responding to GET method - must use local name 'get':)
declare function birtsearch:get(
    $context as map:map,
    $params  as map:map
) as document-node()*
{
    (: set 'output-types', used to generate content-type header :)
    let $output-types :=
        map:put($context,"output-types","application/xml") 
    let $q := map:get($params,"q")
    let $expression := xdmp:unpath(map:get($params, "expression"))
   let $l := xdmp:log(fn:concat("The $var is: ", xdmp:describe($params)))
   let $t := xdmp:log(fn:concat("The $expression is: ", xdmp:describe(doc($expression))))
    let $content := <searchresult>
                       { cts:search(//SPEECH,  cts:word-query($q)) }
                     </searchresult>
      
 (:
      let $content := cts:search($expression,  cts:word-query("Sweet flower, with flowers thy bridal bed I strew"))
                        { cts:search(//SPEECH,  cts:word-query("Sweet flower, with flowers thy bridal bed I strew")) }
  
        <args>
            {for $arg in $arg1
             return <arg1>{$arg1}</arg1>
            }
        </args>
:)
   return 
   
   document { $content }
   
    (: must return document node(s) :)
};

(: Function responding to PUT method - must use local name 'put'. :)
declare function birtsearch:put(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()?
{
    (: get 'input-types' to use in content negotiation :)
    let $input-types := map:get($context,"input-types")
    let $negotiate := 
        if ($input-types = "application/xml")
        then () (: process, insert/update :) 
        else error((),"ACK",
          "Invalid type, accepts application/xml only") 
    return document { "Done"}  (: may return a document node :)
};

(: Function responding to POST method - must use local name 'post'. :)
declare function birtsearch:post(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()*
{
    xdmp:log("BIRT Search post!")
};

(: Func responding to DELETE method - must use local name 'delete'. :)
declare function birtsearch:delete(
    $context as map:map,
    $params  as map:map
) as document-node()?
{
    xdmp:log("BIRT Search delete!")
};