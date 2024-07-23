local gp = require('gp')
local assert = require('luassert')

describe("GPT.nvim Function Registration", function()
    local agent = "test_agent"
    local function_spec = {
        func = function(...)
            local args = {...}
            return "Function Executed" .. vim.inspect(args)
        end,
        name = "test_function",
        description = "This is a test function.",
        use_cases = "Used for testing.",
        arguments = {"arg1", "arg2"},
        doc = "Detailed documentation for the test function."
    }

    before_each(function()
        -- Ensure the agent exists
        gp.agents[agent] = {functions = {}}
        -- Register the function
        gp.register_function_for_agent(agent, function_spec)
    end)

    -- Test the function registration
    it("can register a function for an agent", function()
        -- Assert that the function has been registered successfully
        assert.is_not_nil(gp.agents[agent].functions[function_spec.name])
        assert.are.same(gp.agents[agent].functions[function_spec.name].func(),
                        "Function Executed{}")
    end)

    -- Test the function execution
    it("can execute a registered function for an agent", function()
        -- Execute the function
        local result = gp.agents[agent].functions[function_spec.name]
                                 .func("arg1", "arg2")

        -- Assert on results
        assert.are.same(result, 'Function Executed{ "arg1", "arg2" }')
    end)

end)

