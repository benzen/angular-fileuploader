var fileuploader, fu;

fu = angular.module('ng-fileuploader', []);

fileuploader = function($parse, $compile) {
  return {
    restrict: 'E',
    replace: true,
    template: "\n<div class=\"input-group\" ng-cloak>\n  <input type=\"file\" style=\"display:none\">\n  <div class=\"form-control\">\n    <div data-ng-show=\"myFile\">{{myFile.name}}</div>\n    <div data-ng-hide=\"myFile\"></div>\n  </div>\n  <div class=\"input-group-addon\">\n    <div ></div>\n  </div>\n</div>",
    link: function($scope, element, attr) {
      var attributes, buttonClass, message;
      message = '';
      buttonClass = '';
      attributes = element.prop("attributes");
      angular.forEach(attributes, function(e) {
        if (e.name === 'message') {
          message = e.value;
        }
        if (e.name === 'button-class') {
          return buttonClass = e.value;
        }
      });
      element.find("div[data-ng-hide]").text(message);
      element.find("div.input-group-addon > div").addClass(buttonClass);
      element.find("div.input-group-addon").on("click", function(e) {
        return element.find("input").click();
      });
      element.find("div:first").on("click", function(e) {
        return element.find("input").click();
      });
      return element.find("input:first").on("change", function(e) {
        return $scope.$apply(function() {
          var file, model;
          model = attr.ngModel;
          file = e.currentTarget.files[0];
          return $parse(model).assign($scope, file);
        });
      });
    }
  };
};

fu.directive('fileuploader', fileuploader);
