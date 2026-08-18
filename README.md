# Filosofía compartida de desarrollo de software

Este repositorio es la fuente canónica de un marco de desarrollo portable. Los proyectos consumidores conservan un snapshot completo en `docs/filosofia-desarrollo-software.md` para seguir siendo autónomos, pero no lo editan localmente.

## Topología

- `docs/filosofia-desarrollo-software.md`: fuente normativa compartida.
- `CHANGELOG.md`: versiones publicadas y aprendizajes incorporados.
- `proposals/`: propuestas portables que todavía requieren evaluación.
- `scripts/sync.ps1`: verificación y sincronización segura de consumidores locales.
- `consumers.example.json`: formato del registro local de consumidores.

Las reglas específicas de un producto no entran en este repositorio. Permanecen en su `AGENTS.md`, documentación de dominio, fichas de feature, ADRs, UI u operación.

## Circuito de aprendizaje

1. El proyecto de origen documenta el hallazgo y su evidencia en la fuente local responsable.
2. Si el aprendizaje parece portable, se crea una propuesta desde `proposals/_template.md`.
3. Se generaliza la regla sin nombres, stack ni restricciones exclusivas del producto.
4. Se actualiza la sección responsable de la filosofía, su versión y el changelog.
5. Se ejecutan la verificación y la sincronización de consumidores.
6. Cada proyecto valida el impacto de la nueva versión en proporción al cambio.

Una propuesta puede quedar local o ser rechazada. Compartir aprendizaje no obliga a universalizar cada solución.

## Configuración local

Copiar `consumers.example.json` como `consumers.local.json` y completar rutas absolutas a los repositorios consumidores. El archivo local está ignorado porque la ubicación de los clones depende de cada máquina.

```powershell
./scripts/sync.ps1 -Mode check
./scripts/sync.ps1 -Mode sync
```

Durante la incorporación inicial de copias previamente auditadas puede usarse:

```powershell
./scripts/sync.ps1 -Mode sync -Bootstrap
```

`sync` se niega a sobrescribir una copia que cambió desde su último hash registrado. Ese conflicto debe resolverse promoviendo el aprendizaje, descartando la modificación local o adoptando conscientemente otra versión.

## Versionado

Se usa versionado semántico:

- Patch para aclaraciones no normativas.
- Minor para reglas o protocolos nuevos compatibles.
- Major para cambios incompatibles o garantías eliminadas.

Cada consumidor recibe un `docs/filosofia-desarrollo-software.lock.json` con versión y hash. La publicación en un remoto puede agregarse sin cambiar este contrato de consumo.
