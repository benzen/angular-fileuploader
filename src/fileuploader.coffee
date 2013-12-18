fu = angular.module('ng-fileuploader', [])

# this directive only include a "hidden" file input
# it can include some markup
# it will add send an event 'fileChange' when a new file is selected
# it must be used as an attribute

fileuploader = ($parse, $compile)->
  restrict: 'E'
  replace:true
  template: """

    <div class="input-group" ng-cloak>
      <input type="file" style="display:none">
      <div class="form-control">
        <div data-ng-show="myFile">{{myFile.name}}</div>
        <div data-ng-hide="myFile"></div>
      </div>
      <div class="input-group-addon">
        <div ></div>
      </div>
    </div>
  """
  link: ($scope, element, attr)->

    message = ''
    buttonClass = ''

    attributes = element.prop "attributes"

    angular.forEach( attributes, (e)->
      if e.name is 'message'
        message = e.value
      if e.name is 'button-class'
        buttonClass = e.value
    )

    element.find("div[data-ng-hide]").text message
    element.find("div.input-group-addon > div").addClass buttonClass

    element.find("div.input-group-addon").on "click", (e)->
      element.find("input").click()

    element.find("div:first").on "click", (e)->
      element.find("input").click()

    element.find("input:first").on "change", (e)->
      $scope.$apply ->
        model = attr.ngModel
        file = e.currentTarget.files[0]

        $parse(model).assign $scope, file

fu.directive 'fileuploader', fileuploader