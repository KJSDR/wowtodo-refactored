local Data = require("core.data")

local function test_add_item()
    print("Running: test_add_item")
    local items = {}
    
    Data.addItem(items, "Buy milk")
    
    assert(#items == 1, "Should have 1 item")
    assert(items[1].text == "Buy milk", "Text should match")
    assert(items[1].checked == false, "Should be unchecked by default")
    
    print("✓ test_add_item passed")
end

local function test_remove_item()
    print("Running: test_remove_item")
    local items = {}
    
    Data.addItem(items, "Task 1")
    Data.addItem(items, "Task 2")
    Data.addItem(items, "Task 3")
    
    Data.removeItem(items, 2)
    
    assert(#items == 2, "Should have 2 items")
    assert(items[1].text == "Task 1", "First should be Task 1")
    assert(items[2].text == "Task 3", "Second should be Task 3")
    
    print("✓ test_remove_item passed")
end

local function test_set_checked()
    print("Running: test_set_checked")
    local items = {}
    
    Data.addItem(items, "Task 1")
    Data.setChecked(items, 1, true)
    
    assert(items[1].checked == true, "Should be checked")
    
    Data.setChecked(items, 1, false)
    assert(items[1].checked == false, "Should be unchecked")
    
    print("✓ test_set_checked passed")
end

local function run_all_tests()
    print("\n=== Running Data Tests ===\n")
    
    local tests = {
        test_add_item,
        test_remove_item,
        test_set_checked
    }
    
    local passed = 0
    local failed = 0
    
    for _, test in ipairs(tests) do
        local success, err = pcall(test)
        if success then
            passed = passed + 1
        else
            failed = failed + 1
            print("✗ Test failed: " .. err)
        end
    end
    
    print("\n=== Results ===")
    print(string.format("Passed: %d/%d", passed, passed + failed))
    
    return failed == 0
end

local success = run_all_tests()
os.exit(success and 0 or 1)
