___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Object Key Mapping",
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "sourceObject",
    "displayName": "Source object variable",
    "simpleValueType": true,
    "help": "Enter a variable in this field that is an object (typically a dataLayer variable)",
    "notSetText": "Select a variable that refers to an object",
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "^{{.+}}$"
        ],
        "errorMessage": "This must be a variable that refers to an object"
      },
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "keyMap",
    "displayName": "Mapping",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Source Key",
        "name": "oldKey",
        "type": "TEXT"
      },
      {
        "defaultValue": "",
        "displayName": "Replacement Key",
        "name": "newKey",
        "type": "TEXT"
      },
      {
        "defaultValue": "",
        "displayName": "Replacement Value",
        "name": "newVal",
        "type": "TEXT",
        "selectItems": [
          {
            "value": "concat",
            "displayValue": "Concatenate"
          },
          {
            "value": "array",
            "displayValue": "Array"
          }
        ]
      },
      {
        "defaultValue": "",
        "displayName": "Multiple Values",
        "name": "mapConcat",
        "type": "SELECT",
        "selectItems": [
          {
            "value": "overwrite",
            "displayValue": "Replace"
          },
          {
            "value": "concat",
            "displayValue": "Append"
          },
          {
            "value": "array",
            "displayValue": "Array"
          }
        ]
      }
    ],
    "help": "If multiple items map to the same new key, they can either be ignored (keeping just one value), concatenated as a single string separated by a delimiter, or created as an array in the destination object. Make sure you set all fields that will be combined to the same value or else they may be overwritten.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "concatDelim",
    "displayName": "Delimiter for Appended Field Values",
    "simpleValueType": true,
    "defaultValue": ",",
    "help": "If any fields are concatenated, use this delimiter to separate items."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
const getType = require('getType');
log('data =', data);

const d = data.concatDelim || ' ';
const keyMap = data.keyMap;
const sourceObj = data.sourceObject;

// if (getType(data.sourceObject != 'object')) return undefined;


var newObj = {};
var i = keyMap.length;
log('length = ' + i);

while(i-- > 0) {
 
  var ok = keyMap[i].oldKey;
  var nk = keyMap[i].newKey;
  var c = keyMap[i].mapConcat;
  
log('ok: ' + ok + ', nk: ' + nk + ', c: ' + c);
  
  if (sourceObj[ok]) {
    
    var val = keyMap[i].newVal || sourceObj[ok];
    
if(c === 'array' && newObj[nk]) { //existing array
  
  newObj[nk].push(val);
  
} else if(c === 'concat' && newObj[nk]) {
    
  newObj[nk] = newObj[nk] + d + val;
    
  } else if(c === 'array') {
 
  newObj[nk] = [];
  newObj[nk].push(val);
  
} else {
  
 newObj[nk] = val;
  
}
  
  } // end has old key

} //end while
  
 
return newObj;


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

Created on 3/24/2020, 1:27:45 PM


