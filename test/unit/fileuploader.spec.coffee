describe "fileuploader",()->

  beforeEach module 'ng-fileuploader'


  beforeEach inject (_$rootScope_, _$compile_)->
    @scope = _$rootScope_
    @compile = _$compile_
    @elm = angular.element """
      <fileuploader ng-model="myFile" message="Choose a file"/>
    """
    @compile(@elm) @scope
    @scope.$digest()

    @createFakeFile = ->
      file = null
      # see https://code.google.com/p/phantomjs/issues/detail?id=1013
      if WebKitBlobBuilder?
        bb = new WebKitBlobBuilder()
        bb.append("a simple string that fake the file")
        file = bb.getBlob()
      else
        file = new Blob(["a simple string that fake the file"])
      file.name = "My file name"
      file




  it 'contains a file element', ->
    expect(@elm.find("input").length).toBe 1

  it 'contains a hidden file element', ->
    expect(@elm.find("input").attr("style")).toBe "display:none"

  it 'should fire a click on the input when the div is clicked ', ->
    spy = spyOnEvent @elm.find("input")[0], "click"
    @elm.find("div:first").click()
    expect(spy).toHaveBeenTriggered()

  it 'when changing the file, the model is updated', ->

    file = @createFakeFile()

    @elm.find("input")[0].files[0] = file
    @elm.find("input:first").triggerHandler 'change'

    expect(@scope.myFile).toEqual file

  it 'should display the message given in attribute when no file is seleted',->
    expect(@elm.find("div[data-ng-hide]").val(),"Choose a file")

  it 'should show the file name when it\'s selected', ->
    file = @createFakeFile()
    @elm.find("input")[0].files[0] = file
    @elm.find("input:first").triggerHandler 'change'
    expect(@elm.find("div[data-ng-show]").val(),"Choose a file")



