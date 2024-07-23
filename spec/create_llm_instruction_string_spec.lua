local function_under_test = require("gp")._H.create_llm_instruction_string

describe("Function _H.create_llm_instruction_string", function()
    it("should generate JSON-like string for a simple function specification",
       function()
        local function_spec = {
            func = "my_function",
            name = "My Function",
            description = "A function that prints Hello, World!",
            use_cases = "Demo, Example",
            arguments = {arg1 = "First argument", arg2 = "Second argument"},
            doc = "This function prints a greeting message."
        }

        local expected = [[{
  arguments = {
    arg1 = "First argument",
    arg2 = "Second argument"
  },
  description = "A function that prints Hello, World!",
  doc = "This function prints a greeting message.",
  name = "My Function",
  use_cases = "Demo, Example"
}]]

        assert.are.equal(expected, function_under_test(function_spec))
    end)

    it("should handle functions without any arguments", function()
        local function_spec = {
            func = "noop_function",
            name = "No Operation Function",
            description = "A function that does nothing.",
            use_cases = "Examples where a function is required but does nothing",
            arguments = {},
            doc = "A function that serves as a no-op."
        }

        local expected = [[{
  arguments = {},
  description = "A function that does nothing.",
  doc = "A function that serves as a no-op.",
  name = "No Operation Function",
  use_cases = "Examples where a function is required but does nothing"
}]]

        assert.are.equal(expected, function_under_test(function_spec))
    end)

    it("should handle empty strings in the function specification", function()
        local function_spec = {
            func = "",
            name = "",
            description = "",
            use_cases = "",
            arguments = {arg1 = "", arg2 = ""},
            doc = ""
        }

        local expected = [[{
  arguments = {
    arg1 = "",
    arg2 = ""
  },
  description = "",
  doc = "",
  name = "",
  use_cases = ""
}]]

        assert.are.equal(expected, function_under_test(function_spec))
    end)
end)
