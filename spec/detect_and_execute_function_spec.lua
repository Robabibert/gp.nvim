local gp = require("gp")
local agent = "test_agent"
describe('_H._detect_and_execute_function', function()

    -- Mocking dependencies
    before_each(function()
        local agent = "test_agent"
        local function_spec = {
            func = function(...) return "Function Executed", ... end,
            name = "myFunction",
            description = "A test function.",
            use_cases = "Testing purposes.",
            arguments = {},
            doc = "Detailed documentation for myFunction."
        }
    
        -- Ensure the agent exists
        gp.agents[agent] = {functions = {}}
    
        -- Register the function
        gp.register_function_for_agent(agent, function_spec)
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

