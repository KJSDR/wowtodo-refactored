### Refactored version of the original todolist.lua addon, split into organized modules for better maintainability and testing.

### Project Structure

### Before
```
TodoList/
├── main.lua               # Entry point, wires everything together
└── TodoList.toc           # WoW addon config
```

### After
```
TodoList/
├── core/
│   ├── data.lua           # Data operations (add, remove, setChecked)
│   └── storage.lua        # SavedVariables persistence
├── ui/
│   ├── frame.lua          # Main frame setup
│   ├── list.lua           # List rendering and scrolling
│   └── input.lua          # Input box for adding items
├── tests/
│   ├── data_test.lua      # Tests for data.lua
│   ├── storage_test.lua   # Tests for storage.lua
│   └── run_all_tests.lua  # Test runner
├── main.lua               # Entry point, wires everything together
└── TodoList.toc           # WoW addon config
```



Run all tests:
```bash
lua tests/run_all_tests.lua
```

Run individual tests:
```bash
lua tests/data_test.lua
lua tests/storage_test.lua
```