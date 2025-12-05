# TodoList - Refactored WoW Addon

Refactored version of the original todolist.lua addon, split into organized modules for better maintainability and testing.

## 📁 Project Structure

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
│   ├── data_test.lua      # Tests for data.lua (3 tests)
│   ├── storage_test.lua   # Tests for storage.lua (3 tests)
│   └── run_all_tests.lua  # Test runner
├── main.lua               # Entry point, wires everything together
└── TodoList.toc           # WoW addon config
```

## 📊 Statistics

- **Original**: 177 lines in 1 file
- **Refactored**: 245 lines in 6 files (1.4x size)
- **Tests**: 185 lines, 6 tests total
- **Functionality**: Identical to original

## 🎯 What Changed

### From Original
- Split one 177-line file into 6 organized modules
- Extracted data operations into testable functions
- Separated UI components from business logic
- Added 6 unit tests to verify functionality

### What Stayed the Same
- All original features work exactly the same
- Same UI appearance and behavior
- Same `/todolist` command
- Same SavedVariables storage

## 🧪 Running Tests

Run all tests:
```bash
cd TodoList
lua tests/run_all_tests.lua
```

Run individual tests:
```bash
lua tests/data_test.lua
lua tests/storage_test.lua
```

All 6 tests should pass:
- 3 data operation tests
- 3 storage tests

## 🎮 Installation (WoW)

1. Copy `TodoList` folder to:
   ```
   World of Warcraft/_retail_/Interface/AddOns/TodoList/
   ```

2. Enable addon in game

3. Use `/todolist` to open

## 📝 Files Explained

### core/data.lua (20 lines)
Simple data operations:
- `addItem(items, text)` - Add a new todo
- `removeItem(items, index)` - Remove by index
- `setChecked(items, index, checked)` - Toggle checkbox

### core/storage.lua (15 lines)
SavedVariables handling:
- `initialize()` - Load or create database
- `save(items)` - Save items to database

### ui/frame.lua (50 lines)
Main frame creation:
- Creates the window frame
- Sets up background, border, title
- Makes it movable

### ui/list.lua (58 lines)
List display:
- Creates scroll frame
- Renders todo items with checkboxes
- Creates remove buttons

### ui/input.lua (38 lines)
Input box:
- Edit box for adding new items
- Handles Enter key to add

### main.lua (64 lines)
Wires everything together:
- Loads data on login
- Creates UI components
- Handles item add/remove/toggle
- Registers `/todolist` command

## 🎓 For Class Assignment

This demonstrates:

**Refactoring**:
- Split monolithic file into modules
- Each module has single responsibility
- Clear separation between UI and logic

**Testing**:
- 6 unit tests covering core functionality
- Tests run in < 1 second
- No WoW client needed to test

**Best Practices**:
- Module pattern for organization
- Functions are small and focused
- Code is maintainable and readable

## 🔧 Modules Overview

```
main.lua
  ├── core/storage.lua (load/save data)
  ├── core/data.lua (add/remove/toggle)
  ├── ui/frame.lua (window)
  ├── ui/list.lua (todo list display)
  └── ui/input.lua (text input)
```

Each module:
- Has a clear purpose
- Returns a table of functions
- Can be tested independently

## ✅ Assignment Checklist

- ✅ Original code refactored into multiple files
- ✅ Clear separation of concerns
- ✅ Unit tests written and passing
- ✅ Same functionality as original
- ✅ Well-organized project structure
- ✅ Code is more maintainable

## 💡 Why This Structure?

**Original Problem**: Everything in one function makes it hard to:
- Find specific code
- Test individual pieces
- Modify without breaking things

**Solution**: Split by responsibility:
- `core/` - What the data does
- `ui/` - How it looks
- `tests/` - Verify it works
- `main.lua` - Connect the pieces

**Result**: Same addon, better organized, actually testable.
