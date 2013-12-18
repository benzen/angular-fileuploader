var fileuploader, fu;

fu = angular.module('ng-fileuploader', []);

fileuploader = function($parse, $compile) {
  return {
    restrict: 'E',
    replace: true,
    template: "\n<div class=\"input-group\" ng-cloak>\n  <input type=\"file\" style=\"display:none\">\n  <div class=\"form-control\">\n    <div data-ng-show></div>\n    <div data-ng-hide></div>\n  </div>\n  <div class=\"input-group-addon\">\n    <div ></div>\n  </div>\n</div>",
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
      element.find('div[data-ng-show]').attr('data-ng-show', attr.ngModel);
      element.find('div[data-ng-hide]').attr('data-ng-hide', attr.ngModel);
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
          $parse(model).assign($scope, file);
          element.find('div[data-ng-show]').text(file ? file.name : "");
          return $compile(element)($scope);
        });
      });
    }
  };
};

fu.directive('fileuploader', fileuploader);
