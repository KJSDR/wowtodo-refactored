local Data = require("core.data")

-- Basic functionality tests
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

-- Edge case tests
local function test_remove_from_empty_list()
    print("Running: test_remove_from_empty_list")
    local items = {}
    
    Data.removeItem(items, 1)
    
    assert(#items == 0, "Should still be empty")
    
    print("✓ test_remove_from_empty_list passed")
end

local function test_remove_invalid_index()
    print("Running: test_remove_invalid_index")
    local items = {}
    
    Data.addItem(items, "Task 1")
    Data.removeItem(items, 99)
    
    assert(#items == 1, "Should still have 1 item")
    assert(items[1].text == "Task 1", "Item should be unchanged")
    
    print("✓ test_remove_invalid_index passed")
end

local function test_set_checked_invalid_index()
    print("Running: test_set_checked_invalid_index")
    local items = {}
    
    Data.addItem(items, "Task 1")
    Data.setChecked(items, 99, true)
    
    assert(items[1].checked == false, "First item should be unchanged")
    
    print("✓ test_set_checked_invalid_index passed")
end

local function test_add_multiple_items()
    print("Running: test_add_multiple_items")
    local items = {}
    
    for i = 1, 10 do
        Data.addItem(items, "Task " .. i)
    end
    
    assert(#items == 10, "Should have 10 items")
    assert(items[5].text == "Task 5", "Fifth item should be correct")
    
    print("✓ test_add_multiple_items passed")
end

-- Integration tests
local function test_full_workflow()
    print("Running: test_full_workflow")
    local items = {}
    
    Data.addItem(items, "Buy groceries")
    Data.addItem(items, "Walk dog")
    Data.addItem(items, "Write code")
    
    assert(#items == 3, "Should have 3 items")
    
    Data.setChecked(items, 2, true)
    assert(items[2].checked == true, "Second item should be checked")
    
    Data.removeItem(items, 2)
    assert(#items == 2, "Should have 2 items left")
    assert(items[1].text == "Buy groceries", "First should be unchanged")
    assert(items[2].text == "Write code", "Second should now be 'Write code'")
    
    print("✓ test_full_workflow passed")
end

local function test_toggle_multiple_times()
    print("Running: test_toggle_multiple_times")
    local items = {}
    
    Data.addItem(items, "Task 1")
    
    Data.setChecked(items, 1, true)
    assert(items[1].checked == true, "Should be checked")
    
    Data.setChecked(items, 1, false)
    assert(items[1].checked == false, "Should be unchecked")
    
    Data.setChecked(items, 1, true)
    assert(items[1].checked == true, "Should be checked again")
    
    print("✓ test_toggle_multiple_times passed")
end

local function test_remove_first_and_last()
    print("Running: test_remove_first_and_last")
    local items = {}
    
    Data.addItem(items, "First")
    Data.addItem(items, "Middle")
    Data.addItem(items, "Last")
    
    Data.removeItem(items, 1)
    assert(#items == 2, "Should have 2 items")
    assert(items[1].text == "Middle", "Middle should now be first")
    
    Data.removeItem(items, 2)
    assert(#items == 1, "Should have 1 item")
    assert(items[1].text == "Middle", "Only Middle should remain")
    
    print("✓ test_remove_first_and_last passed")
end

local function test_add_after_remove_all()
    print("Running: test_add_after_remove_all")
    local items = {}
    
    Data.addItem(items, "Task 1")
    Data.addItem(items, "Task 2")
    
    Data.removeItem(items, 1)
    Data.removeItem(items, 1)
    
    assert(#items == 0, "Should be empty")
    
    Data.addItem(items, "New Task")
    
    assert(#items == 1, "Should have 1 item")
    assert(items[1].text == "New Task", "New item should be added correctly")
    
    print("✓ test_add_after_remove_all passed")
end

-- Run all tests
local function run_all_tests()
    print("\n=== Running Data Tests ===\n")
    
    local tests = {
        test_add_item,
        test_remove_item,
        test_set_checked,
        test_remove_from_empty_list,
        test_remove_invalid_index,
        test_set_checked_invalid_index,
        test_add_multiple_items,
        test_full_workflow,
        test_toggle_multiple_times,
        test_remove_first_and_last,
        test_add_after_remove_all
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