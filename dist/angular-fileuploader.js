var fileuploader, fu;

fu = angular.module('ng-fileuploader', []);

fileuploader = function() {
  return {
    restrict: 'A',
    transclude: true,
    template: "<input type=\"file\" style=\"display:none\">\n<div data-ng-transclude></div>",
    link: function($scope, element, attr) {
      element.find("div:first").on("click", function(e) {
        return element.find("input").click();
      });
      return element.find("input").on("change", function(e) {
        return $scope.$emit("fileChange", e.currentTarget.files[0]);
      });
    }
  };
};

fu.directive('fileuploader', fileuploader);
