local gp = require("gp")
local agent = "test_agent"
describe('_H._detect_and_execute_function', function()

    -- Mocking dependencies
    before_each(function()
        local func_name = "myFunction"
        local func_impl = function(...) return "Function Executed", ... end

        -- Ensure the agent exists
        gp.agents[agent] = {functions = {}}

        -- Register the function
        gp.register_function_for_agent(agent, func_name, func_impl)
    end)

    it('should successfully detect and execute the function', function()
        local chunk =
            '{"function_name": "myFunction", "args": {"param1": "value1"}}'
        local result = gp._H._detect_and_execute_function(chunk, agent)

        assert.are.same(result.function_name, "myFunction")
        assert.are.same(result.arguments, {param1 = "value1"})
        assert.are.same(result.result, "Function Executed")
    end)

end)

