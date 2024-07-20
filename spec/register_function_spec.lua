local gp = require('gp')
local assert = require('luassert')

describe("GPT.nvim Function Registration", function()
    -- Test the function registration
    it("can register a function for an agent", function()
        local agent = "test_agent"
        local func_name = "test_function"
        local func_impl = function() return "Function Executed" end

        -- Ensure the agent exists
        gp.agents[agent] = {functions = {}}

        -- Register the function
        gp.register_function_for_agent(agent, func_name, func_impl)

        -- Assert that the function has been registered successfully
        assert.is_not_nil(gp.agents[agent].functions[func_name])
        assert.are.same(gp.agents[agent].functions[func_name](),
                        "Function Executed")
    end)

    -- Test the function execution
    it("can execute a registered function for an agent", function()
        local agent = "test_agent"
        local func_name = "test_function"

        -- Register impl again in case state is reset between tests
        local func_impl = function(...)
            local args = {...}
            return "Function Executed", args
        end

        -- Ensure the agent exists
        gp.agents[agent] = {functions = {}}

        gp.register_function_for_agent(agent, func_name, func_impl)

        -- Execute the function
        local result, args = gp.agents[agent].functions[func_name]("arg1",
                                                                   "arg2")

        -- Assert on results
        assert.are.same(result, "Function Executed")
        assert.are.same(args, {"arg1", "arg2"})
    end)
end)

