# 🎮 Digital Arena Challenge - Pokédex App

Aplicación Flutter profesional que consume la PokeAPI, desarrollada siguiendo **Clean Architecture** y mejores prácticas de desarrollo.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 🌟 Características Principales

- ✅ **Clean Architecture** con separación en 3 capas
- ✅ **Cubit Pattern** para gestión de estado
- ✅ **Dependency Injection** con GetIt
- ✅ **Principios SOLID** aplicados
- ✅ **REST API** (PokeAPI) con manejo robusto de errores
- ✅ **GoRouter** para navegación declarativa
- ✅ **Internacionalización (i18n)** en inglés y español
- ✅ **Responsive Design** adaptable a todos los tamaños de pantalla
- ✅ **Bootstrap Pattern** con inicialización centralizada
- ✅ **BlocObserver** para monitoreo de estado
- ✅ **Múltiples Entornos** (Development, Staging, Production)
- ✅ **Testing completo: 47 tests** (Unit, Widget, Cubit)

## 🏗️ Arquitectura

El proyecto sigue **Clean Architecture** con tres capas principales:

### 📁 Estructura de Carpetas

```
lib/
├── core/                          # Código compartido
│   ├── app/                       # Configuración de la app
│   ├── constants/                 # Constantes (URLs de API)
│   ├── error/                     # Manejo de errores
│   ├── navigation/                # GoRouter configuración
│   ├── observers/                 # BlocObserver
│   ├── presentation/              # Páginas compartidas (error)
│   ├── network/                   # Utilidades de red
│   └── utils/                     # Utilidades responsive
├── features/pokemon/
│   ├── data/                      # Capa de Datos
│   │   ├── datasources/           # Fuentes de datos remotas
│   │   ├── models/                # Modelos de datos (JSON)
│   │   └── repositories/          # Implementación de repositorios
│   ├── domain/                    # Capa de Dominio (lógica de negocio)
│   │   ├── entities/              # Entidades puras
│   │   ├── repositories/          # Contratos de repositorios
│   │   └── usecases/              # Casos de uso
│   └── presentation/              # Capa de Presentación
│       ├── cubit/                 # Gestión de estado (Cubit)
│       ├── pages/                 # Pantallas de la app
│       └── widgets/               # Widgets reutilizables
├── l10n/                          # Archivos de traducción (ARB)
├── bootstrap.dart                 # Inicialización centralizada
├── injection_container.dart       # Inyección de dependencias
├── main_development.dart          # Entry point desarrollo
├── main_production.dart           # Entry point producción
└── main_staging.dart              # Entry point staging
```

## 🎯 Características

### 🌍 Múltiples Entornos
- **Development**: Entorno de desarrollo con tema azul
- **Staging**: Entorno de pruebas con tema verde
- **Production**: Entorno de producción con tema rojo

### 🧭 Navegación
- **GoRouter**: Navegación declarativa y type-safe
- Rutas definidas: `/` (lista), `/pokemon/:id` (detalle)
- Página de error 404 personalizada

### 🌐 Internacionalización
- Soporte para inglés y español
- Archivos ARB para traducciones
- Cambio automático según idioma del dispositivo

### 📱 Diseño Responsive
- Adaptable a móvil, tablet, desktop y large desktop
- Grid adaptativo (2-6 columnas según tamaño de pantalla)
- Breakpoints: 600px, 900px, 1200px, 1800px
- Padding, fuentes e imágenes escalables

### 🎮 Funcionalidades Pokémon
- **Lista de Pokémon**: Grid responsive con scroll infinito
- **Detalle de Pokémon**: Información completa con hero animations
- **Cache de imágenes**: Mejora el rendimiento
- **Manejo de estados**: Loading, error, success

### ⚙️ Características Técnicas
- **Bootstrap**: Inicialización centralizada con manejo de errores
- **BlocObserver**: Monitoreo de todos los cambios de estado
- **Error Handling**: Manejo robusto con Either (dartz)
- **Dependency Injection**: GetIt configurado en bootstrap

## 📦 Dependencias Principales

```yaml
dependencies:
  # Estado
  flutter_bloc: ^8.1.3           # Gestión de estado con Cubit
  
  # Navegación
  go_router: ^14.0.0             # Routing declarativo
  
  # Internacionalización
  flutter_localizations: sdk
  intl: ^0.20.2                  # i18n support
  
  # Dependency Injection
  get_it: ^7.6.4                 # Service locator
  
  # Network
  http: ^1.1.0                   # HTTP client
  cached_network_image: ^3.3.0   # Image caching
  
  # Utilidades
  dartz: ^0.10.1                 # Functional programming (Either)
  equatable: ^2.0.5              # Value equality

dev_dependencies:
  mockito: ^5.4.4                # Mocking para tests
  bloc_test: ^9.1.5              # Testing de Cubits
  build_runner: ^2.4.7           # Code generation
```

## 🚀 Instalación y Ejecución

1. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

2. **Ejecutar la aplicación**
   
   **Development** (tema azul):
   ```bash
   flutter run --flavor development -t lib/main_development.dart
   ```
   
   **Production** (tema rojo):
   ```bash
   flutter run --flavor production -t lib/main_production.dart
   ```
   
   **Staging** (tema verde):
   ```bash
   flutter run --flavor staging -t lib/main_staging.dart
   ```
   
   **Por defecto** (sin flavor):
   ```bash
   flutter run
   ```
   
   > **Nota**: Los flavors requieren configuración específica en Android/iOS. Si prefieres ejecutar sin flavors, usa solo `-t`:
   > ```bash
   > flutter run -t lib/main_development.dart
   > ```

3. **Ejecutar tests**
   ```bash
   flutter test                # Todos los tests (47)
   flutter test --coverage     # Con cobertura
   ```

4. **Análisis de código**
   ```bash
   flutter analyze
   ```

## 🧪 Testing

El proyecto incluye **47 tests** que cubren todas las capas:

### Cobertura de Tests
- ✅ **Data Layer** (23 tests)
  - Remote DataSource (8 tests)
  - Models (6 tests)
  - Repository Implementation (9 tests)

- ✅ **Domain Layer** (2 tests)
  - Use Cases (2 tests)

- ✅ **Presentation Layer** (22 tests)
  - Cubits (14 tests)
  - Widgets (8 tests)

**Ejecutar tests:**
```bash
flutter test                    # Todos los tests
flutter test --coverage         # Con cobertura
flutter test --reporter expanded # Ver detalles
```

## 🎨 Funcionalidades de la UI

### Lista de Pokémon
- Grid responsive (2-6 columnas según pantalla)
- Scroll infinito con carga paginada
- Imágenes con cache automático
- Estados: loading, error, success
- Hero animations

### Detalle de Pokémon
- Hero animation desde la lista
- Imagen destacada
- Tipos con badges coloridos
- Atributos físicos (altura y peso)
- Lista de habilidades
- Estadísticas base con barras de progreso
- Layout optimizado para desktop (max-width)

### Diseño Responsive
| Pantalla | Columnas | Padding | Tamaño Fuente |
|----------|----------|---------|---------------|
| Mobile (<600px) | 2 | 16px | 12-24px |
| Tablet (600-899px) | 3 | 24px | 13-28px |
| Desktop (900-1199px) | 4 | 32px | 14-32px |
| Large Desktop (≥1200px) | 6 | 48px | 15-36px |

## � Principios SOLID Aplicados

- **S**ingle Responsibility: Cada clase tiene una única responsabilidad
- **O**pen/Closed: Abierto para extensión, cerrado para modificación
- **L**iskov Substitution: Los repositorios siguen contratos definidos
- **I**nterface Segregation: Interfaces específicas y segregadas
- **D**ependency Inversion: Dependencias inyectadas, no acoplamiento directo

## 🔧 Tecnologías y Patrones

- **Flutter 3.x**: Framework de UI multiplataforma
- **Dart**: Lenguaje de programación
- **PokeAPI v2**: API REST para datos de Pokémon
- **Clean Architecture**: Separación en capas
- **Cubit Pattern**: Gestión de estado simplificada
- **Repository Pattern**: Abstracción de fuentes de datos
- **Use Case Pattern**: Lógica de negocio encapsulada
- **Observer Pattern**: BlocObserver para monitoreo
- **Bootstrap Pattern**: Inicialización centralizada

---

**Desarrollado con ❤️ usando Flutter y Clean Architecture**
