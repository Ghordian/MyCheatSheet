# Guía Completa: Crear y Mantener un Addon en CurseForge

## 1. Preparación Inicial

### Requisitos Previos
- Cuenta en CurseForge (https://www.curseforge.com)
- Addon funci**📝 Important Notes:**
- Data is based on community guides and may not reflect the absolute latest theorycrafting
- Recommendations are guidelines - your personal playstyle and gear may vary
- Updates are primarily made at the beginning of major patches when significant changes occur y testeado
- Archivos del addon organizados correctamente
- Iconos y screenshots preparados

### Estructura del Addon Requerida
```
MyCheatSheet/
├── MyCheatSheet.toc          # Archivo TOC actualizado
├── core.lua                  # Archivos principales
├── embeds.xml
├── data/
│   ├── data.lua
├── locale/
│   ├── enUS.lua
│   └── esES.lua
├── modules/
│   ├── config.lua
│   ├── validdata.lua
│   ├── export.lua
│   └── edit.lua
├── Libs/                     # Librerías incluidas
├── README.md                 # Documentación
└── CHANGELOG.md              # Historial de cambios
```

## 2. Creación del Proyecto en CurseForge

### Paso 1: Acceso a CurseForge
1. Ve a https://www.curseforge.com
2. Inicia sesión con tu cuenta
3. Haz clic en "Create a Project" o "Start a Project"!
4. Selecciona "World of Warcraft" como juego

### Paso 2: Información Básica del Proyecto
- **Project Name**: MyCheatSheet
- **Summary**: Character Cheat Sheet from wowhead class guides
- **Category**: Interface Enhancements > Character Advancement
- **License**: Elegir licencia apropiada (All Rights Reserved, MIT, etc.)

### Paso 3: Configuración Detallada
```yaml
Title: MyCheatSheet
Slug: mycheatsheet
Game Versions: 11.0.7, 11.1.0 (versiones soportadas)
Categories: 
  - Interface Enhancements
  - Character Advancement
```

## 3. Preparación de Archivos

### Archivo TOC (.toc)
Asegúrate de que tu `.toc` tenga toda la información necesaria:
```toc
## Interface: 110107, 110200
## Title: MyCheatSheet
## Notes: A character cheat sheet for World of Warcraft
## Author: TuNombre
## Version: 1.0.0
## SavedVariables: MyCheatSheetDB
## X-Category: Interface Enhancements
## X-Website: https://www.curseforge.com/wow/addons/mycheatsheet
## X-Curse-Project-ID: [ID que te asignará CurseForge]
## X-WoWI-ID: [Opcional - para WoWInterface]
## X-Wago-ID: [Opcional - para Wago.io]
```

### README.md
```markdown
# MyCheatSheet

## Description
A comprehensive character cheat sheet addon for World of Warcraft.

## Features
- Character build optimization
- Stat priority tracking
- Best-in-slot item recommendations
- Import/Export functionality

## Installation
1. Download from CurseForge
2. Extract to your AddOns folder
3. Restart World of Warcraft

## Usage
Type `/mcs` to open the interface.

## Support
For issues and feature requests, visit our CurseForge page.
```

### CHANGELOG.md
```markdown
# Changelog

## Version 1.0.0 (2025-01-XX)
### Added
- Initial release
- Basic cheat sheet functionality
- Import/export system

### Fixed
- N/A

### Changed
- N/A
```

## 4. Subida del Addon

### Paso 1: Crear Release
1. Ve a tu proyecto en CurseForge
2. Haz clic en "Files" -> "Upload File"
3. Sube un archivo ZIP con tu addon

### Estructura del ZIP
```
mycheatsheet-1.0.0.zip
└── MyCheatSheet/
    ├── MyCheatSheet.toc
    ├── core.lua
    ├── [resto de archivos]
    └── [carpetas]
```

### Paso 2: Configuración del Release
- **Display Name**: MyCheatSheet v1.0.0
- **Game Versions**: Seleccionar versiones compatibles
- **Release Type**: Release, Beta, o Alpha
- **Changelog**: Describir cambios de esta versión

## 5. Optimización del Proyecto

### Descripción Detallada
Escribe una descripción completa que incluya:
- ¿Qué hace el addon?
- Características principales
- Capturas de pantalla
- Instrucciones de uso
- Comandos disponibles

### Ejemplo de Descripción Atractiva para CurseForge (Inglés)

**📋 MyCheatSheet - Your In-Game Character Reference**

Tired of alt-tabbing to check stat priorities or gear recommendations? **MyCheatSheet** provides a convenient in-game reference for character optimization based on popular Wowhead class guides.

**✨ What MyCheatSheet Offers:**
- **Convenient Reference**: Based on established Wowhead class guides and community recommendations
- **Class Coverage**: Support for multiple classes and specializations
- **Content Organization**: Separate recommendations for Raid, Mythic+, Delves, and Open World
- **Visual Clarity**: Color-coded stat priorities with icons for easy reading
- **Clear Priorities**: Stat priority rankings (>, =, ≥) to help guide your gearing decisions

**� Key Features:**
- **Stat Priorities**: Reference for which stats to focus on for your spec and content
- **Gear Recommendations**: BiS suggestions for weapons, trinkets, and tier pieces
- **Consumables Reference**: Quick lookup for food, flasks, and enchants
- **Multiple Content Types**: Different recommendations for various game modes
- **Import/Export**: Share custom builds with friends or guildmates
- **Localization**: Available in English and Spanish
- **Lightweight**: Designed to be simple and efficient

**🎮 Useful For:**
- **Players** who want quick access to optimization guides without leaving the game
- **Alt Characters** when you need a reminder of stat priorities
- **Guild Members** sharing recommended builds
- **Anyone** looking for a convenient reference tool

**💡 How It Works:**
Type `/mcs` in-game to open your reference sheet. Browse by content type to see the appropriate recommendations for your current activity. The interface is straightforward and designed to give you the information you need quickly.

**� Important Notes:**
- Data is based on community guides and may not reflect the absolute latest theorycrafting
- Recommendations are guidelines - your personal playstyle and gear may vary

**🚀 Getting Started:**
1. Download and install MyCheatSheet
2. Type `/mcs` in-game to open the interface
3. Select your class and specialization
4. Use as a reference for your character optimization

*A simple, helpful tool for keeping character optimization information at your fingertips while playing.*

### Screenshots e Imágenes
- **Logo/Icon**: 64x64 px mínimo
- **Screenshots**: Mostrando la interfaz en acción
- **Banner**: Imagen promocional (opcional)

### Tags y Categorías
```
Tags recomendados:
- character
- build
- optimization
- data
- interface
- cheat sheet
- stats
```

## 6. Mantenimiento Continuo

### Actualizaciones Regulares
1. **Compatibilidad**: Actualizar para nuevos parches
2. **Bug Fixes**: Resolver problemas reportados
3. **Nuevas Features**: Añadir funcionalidades solicitadas

### Gestión de Versiones
```
Esquema de versionado: MAJOR.MINOR.PATCH
- MAJOR: Cambios incompatibles
- MINOR: Nueva funcionalidad compatible
- PATCH: Bug fixes compatibles

Ejemplos:
1.0.0 - Release inicial
1.1.0 - Nueva feature
1.1.1 - Bug fix
```

### Comunicación con Usuarios
- **Comentarios**: Responder preguntas y problemas
- **Issues**: Gestionar bugs reportados
- **Feature Requests**: Evaluar sugerencias

## 7. Herramientas Útiles

### CurseForge API
Para automatizar releases:
```bash
# Usando cf-cli (herramienta oficial)
cf upload -f mycheatsheet-1.0.0.zip
```

### Integración con Git
```yaml
# .github/workflows/release.yml
name: CurseForge Release
on:
  push:
    tags: ['v*']
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Package and Upload
      uses: itsmeow/curseforge-upload@v3
```

## 8. Mejores Prácticas

### Desarrollo
- **Testing**: Testear en múltiples versiones de WoW
- **Compatibilidad**: Mantener compatibilidad hacia atrás
- **Performance**: Optimizar para no afectar el rendimiento

### Documentación
- **Changelog**: Mantener historial detallado
- **Wiki**: Crear documentación extensa si es necesario
- **FAQ**: Responder preguntas frecuentes

### Marketing
- **Descripción SEO**: Usar keywords relevantes
- **Screenshots**: Mantener imágenes actualizadas
- **Videos**: Considerar tutoriales en video

## 9. Métricas y Analytics

### KPIs Importantes
- **Downloads**: Número total de descargas
- **Monthly Downloads**: Tendencia de popularidad
- **Ratings**: Calificación de usuarios
- **Comments**: Engagement de la comunidad

### Herramientas de Seguimiento
- Panel de CurseForge Analytics
- GitHub Insights (si usas repositorio público)
- Feedback de usuarios en comentarios

## 10. Recursos Adicionales

### Enlaces Útiles
- **CurseForge Docs**: https://support.curseforge.com/
- **WoW API Docs**: https://warcraft.wiki.gg/wiki/World_of_Warcraft_API
- **Addon Development**: https://warcraft.wiki.gg/wiki/Addon_development

### Comunidades
- **CurseForge Discord**: Para soporte técnico
- **WoW UI Forums**: Para discusiones de desarrollo
- **Reddit /r/WowAddons**: Para feedback de comunidad

## 11. Checklist de Publicación

### Pre-Release
- [ ] Addon funciona en versión actual de WoW
- [ ] Archivo TOC actualizado
- [ ] README.md completo
- [ ] CHANGELOG.md actualizado
- [ ] Screenshots actualizados
- [ ] Testing completo

### Release
- [ ] ZIP empaquetado correctamente
- [ ] Versión subida a CurseForge
- [ ] Game versions seleccionadas
- [ ] Release notes escritas
- [ ] Tags y categorías configuradas

### Post-Release
- [ ] Verificar que la descarga funciona
- [ ] Monitorear comentarios iniciales
- [ ] Responder a feedback temprano
- [ ] Promocionar en redes sociales (opcional)

---

*Esta guía cubre los aspectos esenciales para publicar y mantener un addon en CurseForge. Para preguntas específicas, consulta la documentación oficial de CurseForge.*
