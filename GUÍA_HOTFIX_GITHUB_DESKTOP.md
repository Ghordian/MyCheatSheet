# Hotfix y Publicación de Nueva Versión desde una Etiqueta con GitHub Desktop

## 1. Guarda tus cambios actuales
- Haz commit de tus cambios en tu rama actual (por ejemplo, `main` o `v0.3.1`).
  - Ve a la pestaña "Changes".
  - Escribe un mensaje de commit y haz clic en "Commit to main" (o la rama en la que estés).

## 2. Cambia a la etiqueta v0.2.4
- Ve a la pestaña "Branches" > "Tags".
- Busca la etiqueta `v0.2.4` y haz clic derecho sobre ella.
- Selecciona "Create branch from tag v0.2.4".
- Nombra la nueva rama, por ejemplo: `hotfix/v0.2.5`.

## 3. Realiza las correcciones necesarias
- Haz los cambios/correcciones que necesites en el código.
- Haz commit de esos cambios en la rama `hotfix/v0.2.5`.

## 4. Sube la rama de hotfix al repositorio remoto
- Haz clic en "Push origin" para subir la rama `hotfix/v0.2.5` a GitHub.

## 5. Crea la nueva etiqueta v0.2.5
- Ve a la pestaña "Repository" > "Create Tag...".
- Escribe `v0.2.5` como nombre de la etiqueta y selecciona el commit más reciente de la rama `hotfix/v0.2.5`.
- Haz clic en "Create Tag".

## 6. Publica la etiqueta en GitHub
- Ve a la pestaña "History".
- Haz clic derecho sobre la etiqueta `v0.2.5` y selecciona "Push Tag v0.2.5 to origin".

## 7. Vuelve a tu rama de trabajo actual
- Ve a la pestaña "Current Branch".
- Selecciona tu rama principal (`main`, `v0.3.1` o la que estabas usando).
- Haz clic en "Switch Branch".

---

¡Listo! Así tendrás la corrección publicada como v0.2.5 y podrás seguir trabajando en tu rama actual sin perder nada.
