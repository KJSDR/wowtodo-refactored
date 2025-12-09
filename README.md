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

### Tests

Run all tests:
```bash
lua tests/run_all_tests.lua
```

Run individual tests:
```bash
lua tests/data_test.lua
lua tests/storage_test.lua
```

### Future Additions

#### Item Tracking
Track materials and collectibles directly in your todos. Parse item names from todo text and display real-time progress as you collect them.
- **Example**: "Collect 500 Iron Ore" → automatically shows (234/500) and updates as you farm
- **Implementation**: `GetItemCount()` API, `BAG_UPDATE` event listener
- **Use Case**: Track profession materials, mount drops, achievement items

#### Categories & Organization
Organize todos by type for better workflow management across multiple characters.
- **Categories**: Dailies, Weeklies, Farming, Professions, Mounts, Achievements
- **Features**: Filter by category, color-coded tags, character-specific lists
- **Use Case**: Quickly see what dailies are left, track mount farms per character

#### Due Dates & Priorities
Add deadlines and priority levels to stay on top of time-sensitive content.
- **Features**: Daily/weekly reset tracking, priority color coding (High/Med/Low), alert notifications
- **Implementation**: Time-based checks, visual indicators (red = urgent, yellow = soon, green = done)
- **Use Case**: Never miss a weekly quest reset or limited-time event

#### Shared Lists (Multi-Player)
Coordinate group activities with guild members or party members.
- **Features**: Share todo lists with guild/party, real-time sync across clients, group farming coordination
- **Implementation**: Addon communication channel via `C_ChatInfo.SendAddonMessage()`
- **Use Case**: "Everyone needs 20 Herbs for raid consumables" - track team progress

#### Character Sync
Track progress across multiple characters on the same account.
- **Features**: See which alts have completed weekly lockouts, consolidated mount/achievement tracking
- **Use Case**: "Which characters still need to do their weekly dungeon?"

#### CurseForge Publication
Publish addon to reach wider audience and demonstrate real-world deployment.
- **Goals**: 1,000+ downloads, user feedback integration, version management
- **Benefits**: Portfolio piece with social proof, real user testing, maintainable release cycle
- **Platform**: https://www.curseforge.com/wow/addons

---

*Note: These features are planned enhancements. Current version focuses on core todo functionality with clean architecture and comprehensive test coverage.*