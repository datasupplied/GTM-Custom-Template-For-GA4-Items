___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GA4 items 電子商務訊號格式轉換",
  "categories": ["TAG_MANAGEMENT", "UTILITY"],
  "description": "不需任何額外設定，將通用版 GA (Universal Analytics) 進階型電子商務訊號資料層 (Data Layer) products 參數值，轉換成新版 GA4 電子商務 items 格式。\n備註：只有在資料層架構符合官方建議的格式，才會進行格式的轉換。",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const math = require('Math');
const copyFromDataLayer = require('copyFromDataLayer');

let ecommerce = copyFromDataLayer('ecommerce', 1), 
    items = [];

if(ecommerce === undefined){
  return undefined;
}else if(ecommerce.hasOwnProperty('items')){
  return ecommerce.items;
}else if(ecommerce.hasOwnProperty('purchase') && ecommerce.purchase.hasOwnProperty('items')){
  return ecommerce.purchase.items;
}

function getItem(i){
 let itemObj = {
    item_id: i.id ? i.id:undefined,
    item_name: i.name ? i.name:undefined,
    quantity: i.quantity ? math.round(i.quantity*100/100):undefined,
    item_brand: i.brand ? i.brand:undefined,
    price: i.price ? math.round(i.price*100/100):undefined,
    item_category: i.category ? i.category.split('/')[0]:undefined,
    item_category2: i.category ? i.category.split('/')[1]:undefined,
    item_category3: i.category ? i.category.split('/')[2]:undefined,
    item_category4: i.category ? i.category.split('/')[3]:undefined,
    item_category5: i.category ? i.category.split('/')[4]:undefined,
    item_variant: i.variant ? i.variant:undefined,
    item_list_id: i.list ? i.list:undefined,
    index: i.position ? i.position:undefined,
    currency: i.currency ? i.currency:undefined,
    coupon: i.coupon ? i.coupon:undefined,
  };
 return itemObj;
}

const getPromo = function(i){
 const itemObj = {
    promotion_id: i.id ? i.id:undefined,
    promotion_name: i.name ? i.name:undefined,
    creative_slot: i.creative ? i.creative:undefined,
    location_id: i.position ? i.position:undefined,
  };
 return itemObj;
};

if (ecommerce.impressions) {
  for (var i = 0; i < ecommerce.impressions.length; i++) {
      let item = getItem(ecommerce.impressions[i]);
      items.push(item);
    }
}

if(ecommerce.click){
  for (var i = 0; i < ecommerce.click.products.length; i++) {
      let item = getItem(ecommerce.click.products[i]);
      items.push(item);
    }  
}

if(ecommerce.detail){
  for (var i = 0; i < ecommerce.detail.products.length; i++) {
      let item = getItem(ecommerce.detail.products[i]);
      items.push(item);
    }
}

if(ecommerce.add){
  for (var i = 0; i < ecommerce.add.products.length; i++) {
      let item = getItem(ecommerce.add.products[i]);
      items.push(item);
    }}

if(ecommerce.remove){
  for (var i = 0; i < ecommerce.remove.products.length; i++) {
      let item = getItem(ecommerce.remove.products[i]);
      items.push(item);
    }}

if(ecommerce.promoView){
  for (var i = 0; i < ecommerce.promoView.promotions.length; i++) {
      let item = getPromo(ecommerce.promoView.promotions[i]);
      items.push(item);
    }
}

if(ecommerce.promoClick){
  for (var i = 0; i < ecommerce.promoClick.promotions.length; i++) {
      let item = getPromo(ecommerce.promoClick.promotions[i]);
      items.push(item);
    }
}

if(ecommerce.checkout){
  for (var i = 0; i < ecommerce.checkout.products.length; i++) {
      let item = getItem(ecommerce.checkout.products[i]);
      items.push(item);
    }}

if(ecommerce.purchase){
  for (var i = 0; i < ecommerce.purchase.products.length; i++) {
      let item = getItem(ecommerce.purchase.products[i]);
      items.push(item);
    }}

if(ecommerce.refund){
  for (var i = 0; i < ecommerce.refund.products.length; i++) {
      let item = getItem(ecommerce.refund.products[i]);
      items.push(item);
    }
}

return items;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ecommerce"
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
setup: ''


___NOTES___

Created on 23/12/2020, 00:05:58


