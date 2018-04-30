# highlight.js_SQFgen
A tool to generate the highlight.js SQF command list


Get command list from
https://github.com/intercept/intercept/blob/master/src/client/headers/client/sqf_assignments.hpp
using regex (regexr.com) `\("([^"]*)"` and List `$1\n`
and put into commandList.txt

Get case list from view-source:https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3
using regex `" title="([^"]*)"` and List `$1\n`
and put into caseList.txt
