local function_under_test = require("gp")._H.create_function_system_prompt

describe("Function _H.create_function_system_prompt", function()
    it("should generate system prompt for agent with functions", function()
        local agent = {
            functions = {
                {llm_instruction = "Function1 description"},
                {llm_instruction = "Function2 description"}
            }
        }

        local expected = [[You have the following functions at your disposal.
Function1 description
Function2 description
To call one of the functions provide the name and arguments in a json format.
All parameters are named.
For example if you want to call the function myFunction and supply param1 with the string "value1", respond with the following json:
```json
   '{"function_name": "myFunction", "args": {"param1": "value1"}}'
```
The User will respond with the result of the function as well as the function name and the used arguments.
]]

        assert.are.equal(expected, function_under_test(agent))
    end)

    it("should return an empty string for agent without functions", function()
        local agent = {}

        local expected = ""

        assert.are.equal(expected, function_under_test(agent))
    end)

    it("should handle agent with empty functions table", function()
        local agent = {functions = {}}

        local expected = ""

        assert.are.equal(expected, function_under_test(agent))
    end)
end)

