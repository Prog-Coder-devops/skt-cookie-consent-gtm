___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "SKT Cookie Consent",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "Google Consent Mode v2 for the SKT Cookie Consent plugin. Sets default consent state and updates it from the visitor\u0027s choice.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "cookieName",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "sktcoco_consent_mode"
  },
  {
    "type": "TEXT",
    "name": "defaultAdStorage",
    "simpleValueType": true,
    "displayName": "",
    "defaultValue": "denied"
  },
  {
    "type": "TEXT",
    "name": "defaultAnalyticsStorage",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "denied"
  },
  {
    "type": "TEXT",
    "name": "defaultAdUserData",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "denied"
  },
  {
    "type": "TEXT",
    "name": "defaultAdPersonalization",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "denied"
  },
  {
    "type": "TEXT",
    "name": "defaultFunctionalityStorage",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "granted"
  },
  {
    "type": "TEXT",
    "name": "defaultPersonalizationStorage",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "granted"
  },
  {
    "type": "TEXT",
    "name": "defaultSecurityStorage",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": "granted"
  },
  {
    "type": "TEXT",
    "name": "waitForUpdate",
    "displayName": "",
    "simpleValueType": true,
    "defaultValue": 500
  },
  {
    "type": "CHECKBOX",
    "name": "enableRegions",
    "checkboxText": "Checkbox 1",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "regions",
    "displayName": "",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// =============================================================================
// SKT Cookie Consent — Google Consent Mode v2 (GTM Community Template)
// -----------------------------------------------------------------------------
// Paste this into the "Code" tab of the GTM Template Editor.
// It uses the GTM sandbox APIs (setDefaultConsentState / updateConsentState),
// NOT gtag(), because gtag commands are queued and can lose the consent signal.
// =============================================================================

const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState     = require('updateConsentState');
const getCookieValues        = require('getCookieValues');
const copyFromWindow         = require('copyFromWindow');
const setInWindow            = require('setInWindow');
const JSON                   = require('JSON');
const makeNumber             = require('makeNumber');
const log                    = require('logToConsole');

// Cookie written by the SKT Cookie Consent plugin (see plugin bridge in README).
const cookieName = data.cookieName || 'sktcoco_consent_mode';
const initFlag   = 'sktcoco_cm_initialized';

// -----------------------------------------------------------------------------
// 1) DEFAULT STATE
//    Runs ONCE per page load, before any Google tag fires.
//    Fire this tag on the "Consent Initialization - All Pages" trigger.
// -----------------------------------------------------------------------------
if (!copyFromWindow(initFlag)) {
  const defaultState = {
    ad_storage:              data.defaultAdStorage,
    analytics_storage:       data.defaultAnalyticsStorage,
    ad_user_data:            data.defaultAdUserData,
    ad_personalization:      data.defaultAdPersonalization,
    functionality_storage:   data.defaultFunctionalityStorage,
    personalization_storage: data.defaultPersonalizationStorage,
    security_storage:        data.defaultSecurityStorage,
    wait_for_update:         makeNumber(data.waitForUpdate)
  };

  // Optional: apply defaults only to specific regions (e.g. "DE,FR,ES").
  // Enter region codes WITHOUT spaces. Leave region off to apply worldwide.
  if (data.enableRegions && data.regions) {
    defaultState.region = data.regions.split(',');
  }

  setDefaultConsentState(defaultState);
  setInWindow(initFlag, true, true);
}

// -----------------------------------------------------------------------------
// 2) UPDATE STATE
//    Reads the CMP cookie set by SKT Cookie Consent and applies the visitor's
//    real choice. Runs on every fire, so it also handles the later "change
//    consent" case when the plugin re-fires this tag via a dataLayer event.
// -----------------------------------------------------------------------------
const cookieValues = getCookieValues(cookieName);
if (cookieValues && cookieValues.length > 0 && cookieValues[0]) {
  const parsed = JSON.parse(cookieValues[0]);
  if (parsed) {
    updateConsentState({
      ad_storage:              parsed.ad_storage              || 'denied',
      analytics_storage:       parsed.analytics_storage       || 'denied',
      ad_user_data:            parsed.ad_user_data            || 'denied',
      ad_personalization:      parsed.ad_personalization      || 'denied',
      functionality_storage:   parsed.functionality_storage   || 'granted',
      personalization_storage: parsed.personalization_storage || 'granted',
      security_storage:        parsed.security_storage        || 'granted'
    });
  }
}

data.gtmOnSuccess();


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
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "sktcoco_cm_initialized"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "sktcoco_consent_mode"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8/14/2026, 6:37:18 PM


