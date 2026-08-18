# Instrucciones del repositorio

Antes de proponer o implementar cambios sustantivos, leer completamente `docs/filosofia-desarrollo-software.md` y tratarla como marco rector.

## Fuentes canónicas

- Filosofía portable: `docs/filosofia-desarrollo-software.md`.
- Historia de versiones aceptadas: `CHANGELOG.md`.
- Cambios todavía no aceptados: `proposals/`.

## Políticas

- Este repositorio no contiene reglas de un producto, proveedor, framework o mercado particular.
- Un aprendizaje se documenta primero en el proyecto que aporta la evidencia.
- Un cambio normativo requiere versión nueva y entrada de changelog.
- Una aclaración no normativa requiere al menos una versión patch y entrada de changelog.
- No editar copias consumidoras para introducir cambios. Editar la fuente compartida y sincronizarlas después.
- No sobrescribir divergencias locales: rescatarlas, descartarlas conscientemente o convertirlas en propuesta.
- Mantener el documento autocontenido; un consumidor debe poder aplicarlo sin acceso a este repositorio.
- Verificar `scripts/sync.ps1 -Mode check` antes de cerrar una publicación local.
