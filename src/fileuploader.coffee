fu = angular.module('ng-fileuploader', [])

# this directive only include a "hidden" file input
# it can include some markup
# it will add send an event 'fileChange' when a new file is selected
# it must be used as an attribute

fileuploader = ()->
  restrict: 'A'
  transclude: true
  template: """
      <input type="file" style="display:none">
      <div data-ng-transclude></div>
  """
  link: ($scope, element, attr)->
    element.find("div:first").on "click", (e)->
      element.find("input").click()

    element.find("input").on "change", (e)->
      $scope.$emit "fileChange", e.currentTarget.files[0]

fu.directive 'fileuploader', fileuploader