# 🎮 GlyphRunner

A fast-paced shape-shifting obstacle game built with **Godot Engine 4.3**. Transform your shape to survive through walls with different mechanics!

## 🎯 Game Concept

GlyphRunner is an endless runner where you control a shape-shifting player that must navigate through incoming walls. Each wall has a specific shape cutout and behavior:

- **🔵 PHASE Walls (Blue)**: You must **MATCH** the wall's shape to pass through safely
- **🔴 VOID Walls (Red)**: You must **AVOID** matching the wall's shape or you'll be destroyed

## 🕹️ How to Play

- **SPACE**, **ENTER**, or **CLICK** to cycle through shapes
- **Shapes cycle**: Circle → Square → Triangle → Circle
- **Survive** as long as possible by making the right shape choices
- **Watch the console** for helpful feedback and collision information

## 🛠️ Project Structure

```
GlyphRunner/
├── scenes/
│   ├── Game.tscn          # Main game scene
│   ├── Player.tscn        # Player character scene
│   └── Wall.tscn          # Wall obstacle scene
├── scripts/
│   ├── Game.gd            # Main game logic and wall spawning
│   ├── Player.gd          # Player shape cycling and input
│   └── Wall.gd            # Wall movement and collision detection
├── project.godot          # Godot project configuration
├── icon.svg              # Project icon
└── README.md             # This file
```

## 🎮 Game Features

### Player System
- **Shape Cycling**: Seamlessly switch between 3 shapes
- **Dynamic Collision**: Collision shapes update to match visual shapes
- **Responsive Input**: Multiple input methods (keyboard, mouse, touch)

### Wall System
- **Two Wall Types**: PHASE (must match) and VOID (must avoid)
- **Random Generation**: Walls spawn with random types and shapes
- **Smooth Movement**: Constant horizontal velocity from right to left
- **Auto-cleanup**: Walls are automatically removed when off-screen

### Game Management
- **Timer-based Spawning**: New walls every 2 seconds
- **Collision Detection**: Precise shape-based collision logic
- **Game Over System**: Automatic restart capability
- **Debug Console**: Helpful feedback for development and testing

## 🚀 Getting Started

### Prerequisites
- [Godot Engine 4.3+](https://godotengine.org/download)

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/Ranger10sam/GlyphRunner.git
   ```
2. Open Godot Engine
3. Click "Import" and select the `project.godot` file
4. Press **F5** to run the game

### Controls
- **Space/Enter/Click**: Cycle player shape
- **ESC**: Quit game
- **F5**: Restart game (when game over)

## 🎨 Visual Design

The game features:
- **Programmatically Generated Graphics**: All shapes and textures created via code
- **Color-coded Mechanics**: Blue for PHASE walls, Red for VOID walls
- **Mobile-optimized Layout**: 1080x1920 portrait orientation
- **Clean Minimalist Style**: Focus on gameplay mechanics

## 🔧 Technical Details

### Built With
- **Engine**: Godot 4.3
- **Language**: GDScript
- **Target Platform**: Mobile (Android/iOS ready)
- **Resolution**: 1080x1920 (portrait)

### Key Systems
- **CharacterBody2D** for player physics
- **Area2D** for wall collision detection
- **Timer** nodes for precise spawning control
- **Programmatic texture generation** for all visual assets

## 🎯 Game Mechanics Deep Dive

### Wall Types
1. **PHASE Walls**: 
   - Colored blue with white shape highlights
   - Player must match the shape to pass through
   - Collision occurs if shapes don't match

2. **VOID Walls**:
   - Colored red with transparent cutouts
   - Player must NOT match the shape
   - Collision occurs if shapes match

### Shape System
- **Circle**: Round collision shape, 32px radius
- **Square**: Rectangular collision, 64x64px
- **Triangle**: Simplified rectangular collision (visual triangle)

## 🚧 Future Enhancements

- [ ] Score system with persistent high scores
- [ ] Progressive difficulty (faster spawning, more complex patterns)
- [ ] Power-ups and special abilities
- [ ] Particle effects and visual polish
- [ ] Sound effects and background music
- [ ] Multiple game modes
- [ ] Leaderboards and achievements

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Built with the amazing [Godot Engine](https://godotengine.org/)
- Inspired by classic endless runner games
- Created as a learning project for mobile game development

---

**Happy Gaming! 🎮** 