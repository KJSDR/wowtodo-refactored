-- tests/run_all_tests.lua
-- Run all tests

print("=========================================")
print("Running TodoList Test Suite")
print("=========================================\n")

local function runTest(filepath)
    local exitCode = os.execute("lua " .. filepath)
    return exitCode == 0 or exitCode == true
end

local allPassed = true

if not runTest("tests/data_test.lua") then
    allPassed = false
end

if not runTest("tests/storage_test.lua") then
    allPassed = false
end

print("\n=========================================")
if allPassed then
    print("✓ ALL TESTS PASSED")
else
    print("✗ SOME TESTS FAILED")
end
print("=========================================")

os.exit(allPassed and 0 or 1)
