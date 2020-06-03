___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "JavaScript Object",
  "description": "Creates a key:value JavaScript object that can be used in other scripts and variables.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SIMPLE_TABLE",
    "name": "objectProperties",
    "displayName": "Property Values",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Property Name",
        "name": "propName",
        "type": "TEXT",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "isUnique": true
      },
      {
        "defaultValue": "",
        "displayName": "Property Value",
        "name": "propValue",
        "type": "TEXT",
        "isUnique": false,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
const makeTableMap = require('makeTableMap');
log('data =', data);

var tmap = makeTableMap(data.objectProperties,'propName','propValue');

// Variables must return a value.
return tmap;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 3/24/2020, 1:48:08 PM


