local detect_function = require('gp.init')._H._detect_function

describe("Function call detection", function()
    it("should detect a function with valid JSON arguments with text in front",
       function()
        local chunk =
            'random text {"function_name":"myFunction","args":{"param1":1,"param2":2}}'
        local func_name, args_table = detect_function(chunk)
        assert.are.equal("myFunction", func_name)
        assert.are.same({param1 = 1, param2 = 2}, args_table)
    end)
    it("should detect function call with empty arguments with text in front",
       function()
        local chunk = 'random text {"function_name":"my_function","args":{}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)

    it("should detect a function with valid JSON arguments", function()
        local chunk =
            '{"function_name":"myFunction","args":{"param1":1,"param2":2}}'
        local func_name, args_table = detect_function(chunk)
        assert.are.equal("myFunction", func_name)
        assert.are.same({param1 = 1, param2 = 2}, args_table)
    end)
    it("should detect function call with empty arguments", function()
        local chunk = '{"function_name":"my_function","args":{}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)

    it("should return nil for malformed JSON", function()
        local chunk =
            '{"function_name":"myFunction","args":{"param1":1,"param2":2}' -- Missing closing }
        local func_name, args_table = detect_function(chunk)
        assert.is_nil(func_name)
        assert.is_nil(args_table)
    end)

    it("should return nil for a string without function call", function()
        local chunk = 'This is just a random string without function call.'
        local func_name, args_table = detect_function(chunk)
        assert.is_nil(func_name)
        assert.is_nil(args_table)
    end)

    it("should return nil for an empty string", function()
        local chunk = ''
        local func_name, args_table = detect_function(chunk)
        assert.is_nil(func_name)
        assert.is_nil(args_table)
    end)
    it("should detect function with whitespaces", function()
        local chunk = 'random text {"function_name" :"my_function","args" :{}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)

    it("should detect function with whitespaces", function()
        local chunk = 'random text {"function_name" :"my_function","args" :{}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)

    it("should detect function with no spaces", function()
        local chunk = 'random text {"function_name":"my_function","args":{}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)

    it("should detect function with various types of whitespace", function()
        local chunk =
            'random text {"function_name"\t:\t"my_function"\n,\r"args"\t:\t{}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)

    it("should detect function with nested objects", function()
        local chunk =
            'random text {"function_name": "my_function", "args": {"param1": {"subparam1": "value1"}}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({param1 = {subparam1 = "value1"}}, args)
    end)

    it("should detect function with different argument types", function()
        local chunk =
            'random text {"function_name": "my_function", "args": {"param1": "value1", "param2": 2, "param3": true}}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({param1 = "value1", param2 = 2, param3 = true}, args)
    end)

    it("should return nil for malformed JSON", function()
        local chunk = 'random text {"function_name": "my_function", "args": {'
        local function_name, args = detect_function(chunk)
        assert.is_nil(function_name)
        assert.is_nil(args)
    end)

    it("should handle missing function_name key", function()
        local chunk = 'random text {"args": {}}'
        local result = detect_function(chunk)
        assert.is_nil(result)
    end)

    it("should handle missing args key", function()
        local chunk = 'random text {"function_name": "my_function"}'
        local function_name, args = detect_function(chunk)
        assert.are.same("my_function", function_name)
        assert.are.same({}, args)
    end)
end)

