# MyCheatSheet

A comprehensive character cheat sheet addon for World of Warcraft that provides in-game access to character optimization data based on popular community guides.

## Features

- **Character Optimization**: Stat priorities, Best-in-Slot gear, and consumables for all classes and specs
- **Content-Specific Builds**: Different recommendations for Raid, Mythic+, Delves, and Open World content
- **Visual Interface**: Color-coded stat priorities with intuitive icons
- **Import/Export System**: Share custom builds with friends and guild members
- **Localization**: Full support for English and Spanish
- **Customization**: Edit and override default recommendations with personal preferences

## Installation

### For Users
1. Download the latest release from [CurseForge](https://www.curseforge.com/wow/addons/mycheatsheet)
2. Extract to your `World of Warcraft/_retail_/Interface/AddOns/` folder
3. Restart World of Warcraft
4. Type `/mcs` in-game to open the interface

### For Developers
```bash
git clone https://github.com/yourusername/MyCheatSheet.git
cd MyCheatSheet
# Copy to your WoW AddOns folder
cp -r . "C:/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/MyCheatSheet/"
```

## Development Setup

### Prerequisites
- World of Warcraft (Retail)
- Text editor with Lua support (VS Code recommended)
- Basic knowledge of WoW API and Lua

### Project Structure
```
MyCheatSheet/
├── MyCheatSheet.toc          # TOC file with addon metadata
├── core.lua                  # Main addon logic and UI
├── data.lua                  # Character optimization data
├── config.lua                # Configuration and settings
├── validdata.lua             # Item/class validation logic
├── edit.lua                  # Editors for custom data
├── export.lua                # Import/export functionality
├── bindings.lua              # Keybinding definitions
├── embeds.xml                # XML for embedded libraries
├── locale/                   # Localization files
│   ├── enUS.lua             # English localization
│   └── esES.lua             # Spanish localization
├── Libs/                     # Third-party libraries
│   ├── AceAddon-3.0/        # Ace3 addon framework
│   ├── AceGUI-3.0/          # GUI framework
│   ├── AceLocale-3.0/       # Localization framework
│   └── ...                  # Other Ace3 libraries
└── docs/                     # Documentation
    └── CurseForge_Guide.md   # Publishing guide
```

### Key Components

#### Core Files
- **`core.lua`**: Main addon initialization, UI creation, and event handling
- **`data.lua`**: Contains all character optimization data organized by class/spec/content
- **`config.lua`**: Addon configuration and saved variables management
- **`edit.lua`**: Custom editors for stats priorities and item modifications
- **`export.lua`**: Data serialization and sharing functionality

#### Data Structure
The addon data is organized as follows:
```lua
MyCheatSheet.data = {
    version = 7,
    sheets = {
        [classID] = {
            [specID] = {
                author = "Guide Author",
                updated = "YYYY/MM/DD",
                weapons = { bestInSlot = {...}, alternatives = {...} },
                trinkets = { bestInSlot = {...}, alternatives = {...} },
                consumables = { itemIDs = {...} },
                tier = { bestInSlot = {...} },
                statsByContent = {
                    ["RAID"] = { statsPriority = {...} },
                    ["MYTHIC_PLUS"] = { statsPriority = {...} },
                    -- ...
                }
            }
        }
    }
}
```

### Development Workflow

#### Adding New Class/Spec Data
1. Open `data.lua`
2. Find the appropriate `[classID][specID]` section
3. Add or update the data following the existing structure
4. Increment the version number if making significant changes
5. Test in-game to ensure data displays correctly

#### Adding New Localization
1. Create/edit files in `locale/` folder
2. Follow the pattern in `enUS.lua`
3. Add all required keys (see existing files for reference)
4. Test with different locale settings

#### Modifying UI
1. Main UI logic is in `core.lua`
2. Editor interfaces are in `edit.lua`
3. Follow existing patterns for AceGUI usage
4. Test responsiveness with different window sizes

### Code Standards

#### Lua Conventions
- Use 4 spaces for indentation
- Follow existing naming conventions (camelCase for functions, UPPER_CASE for constants)
- Add type annotations where helpful: `---@param name type`
- Comment complex logic and data structures

#### WoW API Usage
- Always check for API availability before use
- Handle cases where data might not be loaded yet
- Use appropriate event handlers for game state changes
- Follow Blizzard's UI guidelines for addon behavior

### Testing

#### Basic Testing Checklist
- [ ] Addon loads without errors
- [ ] UI opens with `/mcs` command
- [ ] All dropdowns populate correctly
- [ ] Data displays for multiple classes/specs
- [ ] Custom edits save and load properly
- [ ] Import/export functionality works
- [ ] Localization displays correctly

#### Test Cases
1. **Fresh Install**: Test with no saved variables
2. **Data Migration**: Test upgrading from previous versions
3. **Edge Cases**: Test with invalid or missing data
4. **Performance**: Test with large amounts of custom data
5. **Localization**: Test in different language settings

### Debugging

#### Common Issues
- **UI not showing**: Check for Lua errors in `/console scriptErrors 1`
- **Data not loading**: Verify SavedVariables and data structure
- **Performance issues**: Profile with DevTools or similar

#### Debug Commands
```lua
-- Enable debug output
/script MyCheatSheet:EnableDebugging()

-- Check current data
/script DevTools_Dump(MyCheatSheet.data)

-- Validate specific item
/script print(MyCheatSheet.validData:ValidateItem(itemID, "weapons", classID))
```

### Contributing

#### Pull Request Process
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes following the code standards
4. Test thoroughly (see Testing section)
5. Update documentation if needed
6. Submit a pull request with detailed description

#### Issue Reporting
When reporting bugs, please include:
- WoW version and build number
- Addon version
- Steps to reproduce
- Error messages (if any)
- Screenshots (if UI-related)

### Release Process

#### Version Management
- Use semantic versioning: `MAJOR.MINOR.PATCH`
- Update version in `MyCheatSheet.toc`
- Update `data.lua` version if data structure changes
- Tag releases in git: `git tag v1.0.0`

#### Publishing Checklist
- [ ] All tests pass
- [ ] Version numbers updated
- [ ] CHANGELOG.md updated
- [ ] Documentation updated
- [ ] Package created for CurseForge
- [ ] Release notes prepared

### Data Sources

The addon's optimization data is primarily sourced from:
- [Wowhead Class Guides](https://www.wowhead.com/guides)
- Community theorycrafting resources
- Popular guide authors and content creators

#### Updating Data
- Data updates are typically done at the beginning of major patches
- Follow established guides and community consensus
- Always attribute data sources in commit messages
- Verify data accuracy before publishing

### License

This project is licensed under [LICENSE TYPE] - see the LICENSE file for details.

### Acknowledgments

- **Ace3 Framework**: For providing excellent addon development libraries
- **Guide Authors**: For creating the optimization content this addon displays
- **Community**: For feedback, testing, and contributions
- **Blizzard Entertainment**: For World of Warcraft and the addon API

### Support

- **Issues**: Report bugs on GitHub Issues
- **CurseForge**: Leave comments on the project page
- **Discord**: Join our development Discord (if applicable)

### Changelog

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.
