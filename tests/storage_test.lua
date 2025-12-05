local Storage = require("core.storage")

-- Basic tests
local function test_initialize_empty()
    print("Running: test_initialize_empty")
    
    todolistDB = nil
    local items = Storage.initialize()
    
    assert(type(items) == "table", "Should return a table")
    assert(#items == 0, "Should be empty initially")
    assert(todolistDB ~= nil, "Should create database")
    
    print("✓ test_initialize_empty passed")
end

local function test_initialize_existing()
    print("Running: test_initialize_existing")
    
    todolistDB = { items = { {text = "Existing", checked = false} } }
    local items = Storage.initialize()
    
    assert(#items == 1, "Should preserve existing data")
    assert(items[1].text == "Existing", "Should have correct text")
    
    print("✓ test_initialize_existing passed")
end

local function test_save()
    print("Running: test_save")
    
    todolistDB = { items = {} }
    local items = { {text = "Test", checked = true} }
    
    Storage.save(items)
    
    assert(#todolistDB.items == 1, "Should save to database")
    assert(todolistDB.items[1].text == "Test", "Should save correct data")
    
    print("✓ test_save passed")
end

-- Edge case tests
local function test_save_empty_list()
    print("Running: test_save_empty_list")
    
    todolistDB = { items = { {text = "Old", checked = false} } }
    local items = {}
    
    Storage.save(items)
    
    assert(#todolistDB.items == 0, "Should save empty list")
    
    print("✓ test_save_empty_list passed")
end

local function test_save_large_list()
    print("Running: test_save_large_list")
    
    todolistDB = { items = {} }
    local items = {}
    
    for i = 1, 100 do
        table.insert(items, {text = "Task " .. i, checked = i % 2 == 0})
    end
    
    Storage.save(items)
    
    assert(#todolistDB.items == 100, "Should save 100 items")
    assert(todolistDB.items[50].text == "Task 50", "Should save correct data")
    
    print("✓ test_save_large_list passed")
end

local function test_multiple_save_calls()
    print("Running: test_multiple_save_calls")
    
    todolistDB = { items = {} }
    
    -- First save
    local items1 = { {text = "First", checked = false} }
    Storage.save(items1)
    assert(#todolistDB.items == 1, "Should have 1 item after first save")
    
    -- Second save (overwrite)
    local items2 = { {text = "Second", checked = true}, {text = "Third", checked = false} }
    Storage.save(items2)
    assert(#todolistDB.items == 2, "Should have 2 items after second save")
    assert(todolistDB.items[1].text == "Second", "Should overwrite with new data")
    
    print("✓ test_multiple_save_calls passed")
end

-- Integration tests
local function test_initialize_then_save()
    print("Running: test_initialize_then_save")
    
    todolistDB = nil
    
    local items = Storage.initialize()
    table.insert(items, {text = "New item", checked = false})
    Storage.save(items)
    
    assert(#todolistDB.items == 1, "Should have saved item")
    assert(todolistDB.items[1].text == "New item", "Should have correct data")
    
    print("✓ test_initialize_then_save passed")
end

local function test_save_and_reinitialize()
    print("Running: test_save_and_reinitialize")
    
    todolistDB = nil
    
    -- Initialize and save
    local items = Storage.initialize()
    table.insert(items, {text = "Persistent", checked = true})
    Storage.save(items)
    
    -- Reinitialize (simulating reload)
    local loadedItems = Storage.initialize()
    
    assert(#loadedItems == 1, "Should load saved item")
    assert(loadedItems[1].text == "Persistent", "Should have correct text")
    assert(loadedItems[1].checked == true, "Should have correct checked state")
    
    print("✓ test_save_and_reinitialize passed")
end

local function test_data_structure_integrity()
    print("Running: test_data_structure_integrity")
    
    todolistDB = nil
    local items = Storage.initialize()
    
    -- Add complex data
    table.insert(items, {text = "Task with special chars: @#$%", checked = false})
    table.insert(items, {text = "Very long task name " .. string.rep("x", 100), checked = true})
    
    Storage.save(items)
    
    assert(todolistDB.items[1].text:find("@#$%%"), "Should preserve special characters")
    assert(#todolistDB.items[2].text > 100, "Should preserve long strings")
    
    print("✓ test_data_structure_integrity passed")
end

-- Run all tests
local function run_all_tests()
    print("\n=== Running Storage Tests ===\n")
    
    local tests = {
        test_initialize_empty,
        test_initialize_existing,
        test_save,
        test_save_empty_list,
        test_save_large_list,
        test_multiple_save_calls,
        test_initialize_then_save,
        test_save_and_reinitialize,
        test_data_structure_integrity
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