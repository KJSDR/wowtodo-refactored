-- tests/storage_test.lua
-- Tests for core/storage.lua

local Storage = require("core.storage")

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

local function run_all_tests()
    print("\n=== Running Storage Tests ===\n")
    
    local tests = {
        test_initialize_empty,
        test_initialize_existing,
        test_save
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
