angular-fileuploader
====================

A file upload directive for [Angularjs](http://angularjs.org/)


Aims
-------------------

Create a simple file upload that simplly works.


How to get it
-------------------

    bower instal angular-fileuploader


How to use it
-------------------

```html
<div class="form-group">
   <label>File</label>
   <div class="form-group">
     <div fileuploader="fileuploader" class="input-group">
       <div data-ng-show="rmyFile" class="form-control">{{myFile.name}}</div>
       <div data-ng-hide="myFile" class="form-control">Choose a file</div>
       <div class="input-group-addon">
         <div class="fa fa-lg fa-paperclip"></div>
       </div>
     </div>
   </div>
 </div>
```

How to clean /build / unit test /system test it
------------------------

    npm install
    grunt clean
    grunt build
    grunt test-unit
