describe "fileuploader",()->

  beforeEach module 'ng-fileuploader'


  beforeEach inject (_$rootScope_, _$compile_)->
    @scope = _$rootScope_
    @compile = _$compile_
    @elm = angular.element """
      <div class="form-group" fileuploader>
        <div value="un autre balise">
      </div>
    """
    @compile(@elm) @scope
    @scope.$digest()


  it 'contains a file element', ->
    expect(@elm.find("input").length).toBe 1

  it 'contains a hidden file element', ->
    expect(@elm.find("input").attr("style")).toBe "display:none"

  it 'should fire a click on the input when the div is clicked ', ->
    spy = spyOnEvent @elm.find("input")[0], "click"
    @elm.find("div").click()
    expect(spy).toHaveBeenTriggered()

  it 'should fire an event on the scope when a new file is selected', ->

    file = null
    @scope.$on "fileChange", (e, file)->

      # see https://code.google.com/p/phantomjs/issues/detail?id=1013
      if WebKitBlobBuilder?
        bb = new WebKitBlobBuilder()
        bb.append("a simple string that fake the file")
        file = bb.getBlob()
      else
       file = new Blob(["a simple string that fake the file"])

      expect(file).toEqual( file )

    @elm.find("input")[0].files[0] = file


