# Filosofía de desarrollo de software

Estado: documento portable. Se vuelve normativo cuando un proyecto lo adopta explícitamente como marco rector.

Versión: `1.0.0`.

Fuente canónica compartida: repositorio `software-development-philosophy`. Las copias ubicadas dentro de productos son snapshots de consumo y no se editan localmente.

Propósito: ofrecer un criterio general para diseñar, construir, evaluar y evolucionar productos de software operativos con precisión, robustez y bajo control consciente de su complejidad.

Este documento puede incorporarse a un proyecto nuevo o a un repositorio existente. No prescribe un framework, un proveedor ni una arquitectura única. Prescribe una forma de razonar, decidir, implementar y aprender.

## Cómo adoptar este marco

1. Incorporar un snapshot versionado de este archivo sin mezclarle decisiones específicas del producto.
2. Registrar la versión y el hash adoptados para poder detectar divergencias locales.
3. Referenciarlo desde `AGENTS.md`, `CONTRIBUTING.md` o las instrucciones equivalentes del repositorio.
4. Identificar qué documentos locales serán fuente canónica de dominio, arquitectura, UI y operación.
5. Ejecutar primero la auditoría del capítulo 11 y acordar un plan antes de modificar el sistema.

Si el proyecto adopta solo una parte del marco, debe registrar esa selección como una política consciente. Editar silenciosamente los principios para justificar el estado actual elimina el valor de la auditoría.

## Cómo evoluciona este marco entre proyectos

La filosofía tiene una única fuente compartida y puede tener muchos consumidores. Un repositorio de producto conserva una copia completa para que su operación, revisión y continuidad no dependan de una ruta local, una conexión de red ni la disponibilidad de otro repositorio. Esa copia es vendorizada: se actualiza desde la fuente compartida y cualquier política propia vive fuera de ella.

### Aprendizaje federado

Un hallazgo nace en el proyecto que aporta la evidencia, pero no se convierte automáticamente en principio universal. Para promoverlo a este marco se debe:

1. Registrar primero el hecho, consecuencia y corrección en la fuente canónica del proyecto de origen.
2. Separar la regla general de nombres, proveedores, frameworks y restricciones exclusivas de ese producto.
3. Explicar qué clase de falla previene, en qué contextos aplica y cuándo no debería aplicarse.
4. Comprobar que no contradice otro principio o declarar la tensión y su criterio de resolución.
5. Incorporarlo a la sección responsable de este documento y registrar el cambio en el changelog compartido.
6. Publicar una nueva versión y permitir que cada consumidor la adopte de forma explícita y verificable.

El origen aporta evidencia, no autoridad especial. Una práctica que funcionó una vez puede quedar como aprendizaje local si todavía no existe base para convertirla en regla portable.

### Separación entre lo compartido y lo local

- Este documento contiene criterios transversales, protocolos portables y vocabulario común.
- `AGENTS.md` o el archivo equivalente declara cómo cada repositorio adopta el marco y cuáles son sus gates.
- Dominio, alcance, stack, proveedores, UI y operación permanecen en las fuentes canónicas del producto.
- Una excepción local referencia el principio afectado, explica el costo aceptado y no modifica la copia vendorizada.
- Los ejemplos portables pueden mencionar clases de problemas, pero no deben volver canónico un proveedor o una arquitectura particular.

### Versionado y sincronización

La fuente compartida usa versionado semántico:

- **Patch:** aclaraciones editoriales que no cambian obligaciones ni criterios de salida.
- **Minor:** principios, protocolos o guías nuevas compatibles con adopciones anteriores.
- **Major:** cambios normativos incompatibles o eliminación de garantías existentes.

Cada consumidor registra versión y hash. La sincronización debe negarse a sobrescribir una copia modificada localmente: primero se rescata el aprendizaje, se descarta la divergencia o se promueve el cambio a la fuente compartida. Un proyecto puede permanecer temporalmente en una versión anterior, pero esa decisión debe ser visible; no puede presentarse como actualizado mientras conserva reglas distintas.

## 1. Tesis: conservar soberanía sobre el producto

Un sistema pierde calidad mucho antes de dejar de funcionar. La pierde cuando ya no resulta claro de dónde sale un dato, por qué existe una entidad, qué contrato gobierna una interacción o cuál de varias implementaciones representa la conducta verdadera. A partir de ese punto, cada cambio exige compensar decisiones anteriores que nadie controla por completo.

La excelencia no consiste en acumular capacidades ni en reducir mecánicamente la cantidad de código. Consiste en poder explicar el producto con precisión y modificarlo sin provocar consecuencias misteriosas. Llamamos **soberanía sobre el producto** a esa capacidad de conocer y gobernar sus reglas, sus datos, su interfaz y su operación.

El minimalismo que propone esta filosofía nace de esa búsqueda. No es austeridad cosmética ni una excusa para entregar menos. Es la decisión de que cada elemento pague el costo de existir: una feature debe resolver un problema real; una abstracción debe reducir complejidad comprobada; un dato persistido debe tener una razón; una pantalla debe ayudar a completar una tarea; una dependencia debe aportar más de lo que obliga a mantener.

La robustez tampoco se confunde con sobrediseño. Un sistema robusto hace explícitas sus invariantes, conserva identidades estables, trata los errores como parte del producto y verifica los límites donde más daño produciría una falla. No intenta anticipar todos los futuros imaginables. Prepara los puntos de variación que ya pueden identificarse sin inventar categorías que el dominio todavía no necesita.

Por último, la calidad no puede depender de la memoria de una conversación ni del criterio circunstancial de quien toque el código. Las decisiones relevantes deben quedar en fuentes durables, compartimentadas y verificables. El objetivo no es documentar todo, sino impedir que el conocimiento necesario para gobernar el sistema quede implícito.

## 2. Alcance y lenguaje normativo

Este marco distingue tres niveles:

- **Principios universales:** orientan cualquier proyecto que adopte esta filosofía.
- **Políticas del proyecto:** concretan los principios para un dominio, equipo o producto específico.
- **Decisiones locales:** resuelven una feature, integración o excepción particular.

Los principios viven en este documento. Las políticas y decisiones deben vivir en documentación especializada que lo referencie. Copiar una misma regla en varios lugares crea versiones competidoras y debe evitarse.

En este texto:

- **Debe** indica una condición necesaria para afirmar alineación.
- **Debería** indica la opción predeterminada, salvo excepción razonada.
- **Puede** indica una alternativa admisible según el contexto.

## 3. Principios rectores

### 3.1 Demanda real antes que capacidad aparente

Una feature, entidad, rol, configuración o variante debe responder a una necesidad demostrable del diseño. No se agregan opciones para aparentar amplitud ni para representar futuros hipotéticos.

Antes de incorporar algo nuevo deben poder contestarse cuatro preguntas:

1. ¿Qué problema concreto resuelve?
2. ¿Para qué actor existe?
3. ¿Qué sucede si no se incorpora ahora?
4. ¿Qué parte del sistema deberá sostener su costo desde entonces?

Si las respuestas son vagas, la incorporación se difiere. Diferir una idea no equivale a olvidarla: puede registrarse como hipótesis sin convertirla en alcance ni arquitectura.

### 3.2 Minimalismo preciso

El sistema debe hacer la menor cantidad de cosas compatible con resolver bien su problema. Cada flujo debe tener pocos conceptos, pocas decisiones visibles y un resultado inequívoco.

Minimalismo no significa ocultar información necesaria, omitir estados de error ni entregar una versión descartable. Una versión mínima debe ser una porción pequeña de una solución que pueda evolucionar, no una simulación que deba reemplazarse al crecer.

### 3.3 Única fuente de verdad

Cada regla, estado y dato debe tener una fuente canónica identificable.

- Los datos derivados se calculan desde datos fuente confiables.
- Un estado no debe persistirse dos veces sin una razón explícita de auditoría, contabilidad, integración o rendimiento.
- Dos superficies que muestran el mismo concepto deben depender del mismo contrato de dominio.
- El frontend no debe reimplementar reglas de negocio cuya autoridad pertenece al backend o al dominio compartido.
- La documentación no debe definir la misma política en varios archivos.

Cuando exista duplicación intencional, debe declararse cuál representación es autoritativa, cómo se sincronizan las demás y qué falla se acepta si esa sincronización no ocurre.

### 3.4 Correcta factorización

Cada pieza de conocimiento debe vivir en el nivel de abstracción que le corresponde.

- La filosofía contiene criterios transversales.
- Las decisiones de dominio viven en la documentación de dominio o de la feature.
- Las decisiones arquitectónicas relevantes viven en registros de decisión.
- Los patrones visuales viven en una guía de interfaz.
- Los procedimientos operativos viven en documentación de operación.

Separar no es un fin en sí mismo. Se factoriza cuando la separación aclara propiedad, reduce duplicación o permite evolucionar una parte sin arrastrar a las demás. Una única ficha maestra que mezcla producto, UI, arquitectura, operación y decisiones históricas suele ser tan problemática como una dispersión de archivos sin jerarquía.

### 3.5 Universalidad sin especulación

Las reglas locales, comerciales, regionales o dependientes de un proveedor deben encapsularse en políticas, configuración o adaptadores cuando exista una variación plausible y concreta.

La universalidad no autoriza a modelar categorías sin demanda. Preparar la incorporación futura de idiomas mediante textos centralizados es distinto de inventar hoy una jerarquía completa de mercados, monedas y jurisdicciones. El primer caso protege un punto de variación conocido; el segundo agrega conceptos sin comportamiento real.

### 3.6 Reutilización consciente y por capacidad

Se reutiliza comportamiento cuando hacerlo reduce duplicación real y refuerza consistencia. No se comparte código solo porque dos pantallas se parecen superficialmente.

Las capacidades transversales deben modelarse por la función que cumplen, no por el tipo de usuario o la zona visual donde aparecen. Identidad, perfil, filtros, formularios, tablas, errores y permisos pueden tener una base común con políticas o composición para sus diferencias.

**Umbral de segunda aparición:** cuando una interacción, regla o estructura aparece por segunda vez, la implementación debe detenerse a evaluar si ya existe una capacidad compartida. La evaluación no obliga a abstraer. Obliga a justificar por qué compartir reduce o aumenta complejidad.

### 3.7 Fundaciones tempranas, alcance mínimo

No se posterga una base inevitable cuando incorporarla tarde obligaría a migrar identidades, romper contratos o perder trazabilidad. Repositorio remoto, integración continua, gestión de secretos, migraciones, ambientes separados, identificadores estables y observabilidad básica son ejemplos frecuentes.

La implementación temprana debe ser mínima. Este principio no habilita construir subsistemas completos antes de necesitarlos. La pregunta correcta es: ¿qué fundamento pequeño protege hoy una decisión costosa de cambiar mañana?

### 3.8 Identidad estable y datos derivados

Una entidad que pueda ser referenciada por historia transaccional debe conservar identidad estable. Editar no debe equivaler a borrar y recrear por comodidad.

Los identificadores internos pueden optimizar integridad y distribución. Los identificadores operativos pueden optimizar lectura, dictado o control humano. Ambos pueden convivir si tienen responsabilidades explícitas y no codifican atributos mutables como fecha, mercado o estado.

Los cálculos derivados deben permanecer cerca de su fuente canónica. Persistirlos requiere documentar el motivo y la estrategia de reconciliación.

### 3.9 Consistencia y frescura explícitas

La frescura de los datos es una decisión de producto y arquitectura, no un accidente de la caché.

Para cada estado relevante debe definirse:

- Qué superficie lo modifica.
- Qué superficies lo leen.
- Cuándo debe observarse el cambio.
- Qué cachés, proyecciones o estados locales intervienen.
- Cómo se invalida o versiona cada copia.

Si un flujo exige consistencia inmediata después de escribir, todas sus superficies deben respetar el mismo contrato. Corregir una pantalla mientras otra conserva datos viejos no resuelve el problema conceptual.

### 3.10 Robustez ligera

La robustez surge de modelos claros, contratos verificables y fallas controladas. Se prefieren:

- Dependencias justificadas y reemplazables cuando corresponda.
- Flujos simples con estados explícitos.
- Invariantes protegidas cerca del dominio.
- Transacciones para cambios que deben ser atómicos.
- Errores traducidos al lenguaje del producto.
- Trazabilidad suficiente para reconstruir una operación.

No se agregan capas por prestigio arquitectónico. Cada capa debe reducir un acoplamiento real, proteger una invariante o concentrar una política.

### 3.11 Soberanía operativa

Un sistema no está bajo control si el equipo no puede saber qué versión está desplegada, qué migración se ejecutó, qué secreto falta, qué integración falló o qué datos afectó una operación.

El proyecto debe disponer, en proporción a su riesgo, de:

- Ambientes diferenciados.
- Despliegues reproducibles y observables.
- Migraciones versionadas.
- Secretos fuera del código.
- Timeouts finitos y errores accionables.
- Logs o auditoría para operaciones críticas.
- Procedimientos que no dependan de una única persona o conversación.

### 3.12 Geometría estable y economía visual

La interfaz es un contrato estructural. El contenido asincrónico, los mensajes de validación, las acciones condicionales y los cambios de copy no deben desplazar elementos de forma imprevisible.

Las pantallas operativas deben priorizar escaneo, comparación y acción repetida. Se prefieren columnas explícitas, dimensiones estables, encabezados reutilizables, filtros homogéneos y filas de una altura predecible. El espacio flexible no debe usarse como mecanismo de posicionamiento entre elementos independientes.

La economía visual exige eliminar títulos, subtítulos, cards, colores, modales y explicaciones que no cambian una decisión del usuario. La ausencia de ruido no justifica esconder restricciones, estados o consecuencias relevantes.

### 3.13 Restricciones tempranas y revelación progresiva

Una restricción conocida debe mostrarse antes de que el usuario invierta trabajo en una acción imposible. No debe completar un formulario entero para descubrir al final que carece de permiso o que el estado del recurso impide el cambio.

Las acciones complejas o críticas deben revelarse en secuencia:

1. Se presenta la acción y su disponibilidad.
2. El usuario expresa intención.
3. Se muestran consecuencias y opciones pertinentes.
4. Se exige la fricción proporcional al riesgo.
5. Se confirma un resultado inequívoco.

La revelación progresiva reduce carga inicial sin ocultar información necesaria. Una acción deshabilitada debe explicar su motivo de forma breve y contextual.

### 3.14 Métricas del contexto visible

Una métrica principal debe responder una pregunta operativa actual. Los acumulados históricos que pierden significado con el tiempo no deben ocupar espacio prominente solo porque pueden calcularse.

Los totales visibles deberían pertenecer a la entidad, período, filtro o estado que el usuario está observando. Los acumulados de toda la vida quedan para reportes, exportaciones o análisis donde tengan una finalidad explícita.

### 3.15 Calidad proporcional al riesgo

La verificación debe escalar con el daño posible y con la cantidad de contratos afectados.

- Un ajuste de copy o estilo requiere revisión dirigida, no una suite completa por reflejo.
- Una regla de dominio requiere pruebas unitarias sobre invariantes.
- Un contrato entre módulos requiere integración.
- Una integración externa requiere probar éxito y al menos un error realista.
- Un recorrido crítico que cruza UI, backend y persistencia requiere E2E.
- Un cambio de infraestructura requiere comprobar despliegue y observabilidad.

Probar todo siempre es caro y vuelve lentas las iteraciones. Probar solo el flujo feliz oculta los fallos más costosos. La respuesta es una estrategia explícita y proporcional.

### 3.16 Documentación como memoria durable

El chat, la memoria individual y el código por sí solo no alcanzan como fuente de contexto.

Al cerrar trabajo sustantivo debe quedar documentado:

- Qué decisión cambió.
- Qué regla gobierna ahora el comportamiento.
- Dónde vive su fuente canónica.
- Cómo se valida.
- Qué quedó deliberadamente fuera.

La documentación debe permitir que otra persona o agente retome el proyecto sin reconstruir sus principios desde el historial de conversaciones.

## 4. Resolver tensiones sin convertir principios en dogmas

Los principios se aplican juntos. Cuando parecen competir, se usa el siguiente criterio:

| Tensión | Pregunta de decisión | Resultado predeterminado |
| --- | --- | --- |
| Minimalismo vs. completitud | ¿La omisión rompe el flujo real o solo reduce apariencia de amplitud? | Completar el flujo; omitir adornos y variantes especulativas. |
| Universalidad vs. simplicidad | ¿Existe un punto de variación conocido o solo un futuro imaginable? | Encapsular variaciones conocidas; no modelar las imaginarias. |
| Reutilización vs. abstracción prematura | ¿La segunda implementación repite contrato o solo apariencia? | Compartir el contrato; conservar separadas las responsabilidades distintas. |
| Fundaciones tempranas vs. alcance | ¿Agregarlo tarde exige migrar identidad, operación o datos? | Incorporar la fundación mínima, sin construir features alrededor. |
| Caché vs. consistencia | ¿El usuario puede aceptar datos viejos y por cuánto tiempo? | No cachear sin un presupuesto explícito de antigüedad e invalidación. |
| Interfaz estática vs. dinamismo | ¿La interacción mejora materialmente la tarea? | HTML y navegación predecibles primero; dinamismo donde aporta valor concreto. |
| Velocidad vs. pruebas | ¿Qué contrato y qué daño potencial introduce el cambio? | Verificación dirigida al riesgo, ampliada al cerrar un frente. |
| Brevedad vs. claridad | ¿Reducir elementos obliga a adivinar una consecuencia? | Mantener la información necesaria, expresada una sola vez. |

Una excepción legítima debe registrar contexto, alternativa descartada, costo aceptado y condición para revisarla. Una excepción sin motivo es una desviación accidental.

## 5. Doctrina de arquitectura y datos

### 5.1 Mapa de fuentes de verdad

Todo proyecto debería mantener un mapa simple de propiedad:

| Concepto | Fuente canónica esperada | Representaciones derivadas posibles |
| --- | --- | --- |
| Regla de negocio | Dominio o servicio de aplicación | Mensajes de UI, reportes, documentación de feature |
| Estado transaccional | Persistencia autoritativa | Proyecciones, cachés, vistas materializadas |
| Configuración comercial | Entidad o política con dueño explícito | Valores efectivos heredados por recursos |
| Texto visible | Catálogo de idioma o fuente de copy | Componentes renderizados |
| Formato de fecha, moneda e ID | Utilidad transversal | Tablas, emails, PDF, exportaciones |
| Permiso | Política de capacidades | Navegación y acciones visibles |
| Decisión arquitectónica | ADR | Código que la implementa |

El mapa no necesita ser una base de datos de gobierno. Debe ser suficientemente claro para impedir que dos módulos se atribuyan autoridad sobre el mismo concepto.

### 5.2 Límites por responsabilidad

Los módulos deben seguir responsabilidades del dominio o capacidades transversales. No deberían seguir accidentes de navegación ni replicar universos completos por tipo de usuario.

Una diferencia de permiso puede modificar qué operación está disponible. No necesariamente justifica otra implementación del perfil, del formulario, del filtro o del cálculo.

### 5.3 Políticas y configuración

Una regla variable debe modelarse con tres preguntas:

1. ¿Quién es su dueño real?
2. ¿En qué nivel se configura?
3. ¿Cómo se obtiene el valor efectivo cuando existe herencia o sobreescritura?

La UI no debe conceder una capacidad a un actor solo porque la configuración pertenece a una entidad que ese actor utiliza.

### 5.4 Errores como parte del dominio

Los errores técnicos deben convertirse en categorías útiles para el producto. `Failed to fetch`, una excepción SQL o el objeto crudo de un proveedor no son mensajes finales.

El contrato de error debería incluir:

- Código estable para la aplicación.
- Mensaje localizado y accionable.
- Contexto técnico para logs.
- Distinción entre validación, conflicto, permiso, dependencia externa y fallo inesperado.
- Estrategia de reintento cuando corresponda.

### 5.5 Integraciones externas

Una integración no está validada porque la llamada no arrojó una excepción. Deben verificarse estados rechazados, respuestas parciales, timeouts, credenciales inválidas y restricciones operativas del proveedor.

El proveedor se encapsula detrás de un contrato propio cuando su semántica no debería contaminar el dominio. El sistema conserva responsabilidad por sus tickets, órdenes, permisos, trazabilidad y estados aunque delegue pagos, email, identidad u otra capacidad.

### 5.6 Paradigmas, objetos y composición

La arquitectura se evalúa por cómo protege responsabilidades, invariantes y puntos de variación, no por la cantidad de clases, interfaces o funciones. Adoptar principios de programación orientada a objetos significa favorecer encapsulación, cohesión, identidad estable, polimorfismo contractual e inversión de dependencias. No significa convertir todo el sistema a clases ni privilegiar herencia sobre alternativas más simples.

Un objeto de dominio se justifica cuando reúne datos y comportamiento que deben evolucionar juntos, especialmente si existe alguno de estos factores:

- Identidad y ciclo de vida propios.
- Transiciones de estado que deben impedir combinaciones inválidas.
- Invariantes que varias operaciones necesitan preservar.
- Conducta cuyo significado pertenece al lenguaje del dominio.

Los agregados no acceden directamente a base de datos, red, reloj global, filesystem ni proveedores. Reciben los datos o capacidades necesarios, protegen sus reglas y exponen snapshots serializables en los límites. La carga, persistencia, transacción e integración pertenecen a casos de uso o servicios de aplicación que dependen de contratos propios e inyectados.

Las funciones puras siguen siendo la opción predeterminada para cálculos, normalizaciones, validaciones de forma y transformaciones deterministas. Los esquemas de entrada validan datos no confiables antes de reconstruir objetos de dominio. Los componentes de interfaz respetan el paradigma natural del framework cuando transformarlos en clases no protege ninguna regla adicional.

Se prefiere composición sobre herencia. Una jerarquía solo se incorpora cuando existe sustituibilidad semántica comprobable, no para compartir unas pocas líneas. Deben evitarse clases base genéricas, repositorios universales, pares de getters y setters sin conducta y objetos que sólo renombran operaciones de infraestructura.

Los principios SOLID se aplican como preguntas de diseño, no como cuotas de archivos:

- Una responsabilidad debe tener un motivo coherente para cambiar.
- Una variación conocida debería incorporarse detrás de un contrato sin reabrir reglas estables.
- Dos implementaciones de un contrato deben conservar la misma semántica de éxito, error y efectos, no sólo la misma firma.
- Los consumidores dependen de capacidades pequeñas y pertinentes.
- El dominio y los casos de uso dependen de contratos propios; la infraestructura los implementa.

Una migración hacia este modelo debe ser incremental. Primero se caracterizan las conductas vigentes; luego se extrae un agregado o caso de uso dentro de un recorrido vertical; finalmente se retira la implementación anterior después de verificar paridad. Cambiar de paradigma no justifica por sí solo una reescritura general.

## 6. Doctrina de experiencia e interfaz

### 6.1 La tarea primero

La primera vista debe ser la experiencia utilizable, no una explicación de lo que el producto podría hacer. En herramientas operativas se priorizan información escaneable, navegación predecible y acciones frecuentes.

Un título o subtítulo existe si orienta, desambigua o contextualiza. Repetir en tres niveles la misma idea aumenta ruido y abre oportunidades de contradicción.

### 6.2 Estructuras compartidas

Formularios equivalentes, filtros, filas, encabezados, estados, diálogos y acciones deben partir de primitivas comunes. Las diferencias se expresan mediante datos, composición o políticas.

Los encabezados de columnas describen una vez el contenido. Las filas no repiten etiquetas salvo que el viewport obligue a una representación distinta.

### 6.3 Estabilidad durante carga y edición

El primer render debe reservar la geometría del contenido final. Se usan skeletons estructurales o datos previos durante refetch cuando un texto de carga cambiaría la huella de la pantalla.

Editar una fila o alternar una opción debería conservar el mismo esqueleto siempre que sea posible. Las acciones opcionales mantienen casilleros estables o se apilan en un orden explícito para pantallas angostas.

### 6.4 Formularios y validación

Al enviar, todos los campos obligatorios faltantes se señalan en conjunto. El usuario no debe corregir uno por uno requisitos que el sistema ya conoce.

Los errores se ubican cerca del campo cuando indican cómo corregirlo, pero su aparición no debería desplazar toda la interfaz. Las marcas visuales y el espacio reservado pueden comunicar obligatoriedad sin repetir “campo obligatorio” debajo de cada control.

Las validaciones que afectan a varias filas o al total del formulario se expresan una sola vez, en el lugar donde puede comprenderse el cálculo completo.

### 6.5 Controles y copy

Los controles familiares usan símbolos familiares. Un ícono desconocido debe tener tooltip. El tooltip utiliza el verbo más corto que desambigüe la acción.

El nombre de un CTA describe su efecto real. Después de guardar o publicar, el flujo navega al resultado natural cuando permanecer en configuración no aporta una tarea siguiente.

Todo texto visible debe pertenecer a una estrategia de idioma y locale. Fechas, monedas, plurales y voseo o registro lingüístico se centralizan, no se corrigen pantalla por pantalla.

### 6.6 Estático primero, interacción con propósito

El contenido esencial y público debería poder entregarse en el primer render siempre que la arquitectura lo permita. La interacción en cliente se agrega para mejorar una tarea, no para reconstruir información que el servidor ya conoce.

Un diálogo, un desplegable o una actualización dinámica no contradicen este criterio si reducen navegación o mantienen contexto. “Estático primero” no significa “sin JavaScript”; significa que el dinamismo debe tener una función concreta y no convertirse en dependencia accidental para comprender la página.

## 7. Topología documental recomendada

Una estructura mínima puede ser:

```text
docs/
  filosofia-desarrollo-software.md
  arquitectura/
    panorama.md
    decisiones/
  dominio/
  features/
    _template.md
  ui/
    sistema.md
    idioma.md
  operaciones/
    ambientes.md
    despliegue.md
    incidentes.md
```

Reglas de mantenimiento:

- El documento rector define principios, no detalles de features.
- Una feature tiene una ficha canónica propia.
- Un ADR explica una decisión estructural y sus alternativas.
- La guía de UI define patrones reutilizables, no capturas de cada pantalla.
- La operación documenta procedimientos reproducibles.
- Los documentos especializados enlazan la fuente transversal; no copian sus reglas.
- Las preguntas abiertas tienen dueño y condición de resolución.
- Las decisiones obsoletas se marcan como reemplazadas; no se borran si explican historia relevante.

## 8. Workflow permanente con orquestador y subagentes

El workflow se ejecuta por feature, corrección sustantiva o cambio estructural. El orquestador conserva contexto, decide qué especialistas participan y evita que sus entregables creen verdades paralelas.

Los pasos pueden compactarse para tareas pequeñas, pero no deben omitirse sus criterios de salida. Una corrección de copy puede recorrer varias fases en una única revisión; una modificación transaccional requiere entregables separados.

| Fase | Especialidad principal | Entregable | Criterio de salida |
| --- | --- | --- | --- |
| 0. Intake | Orquestación | Problema, actor, alcance, no-alcance, fuentes de verdad, dudas | La necesidad está definida sin asumir solución. |
| 1. Exploración | Producto | Pocas alternativas buenas, bordes, riesgos, ideas descartadas | Existe un flujo principal y no quedan preguntas de producto bloqueantes. |
| 2. Dominio | Producto y Dominio | Entidades, estados, transiciones, invariantes, permisos, criterios de aceptación | La feature puede explicarse sin framework ni proveedor. |
| 3. UX/UI | Experiencia | Flujo, estados, controles, copy, reutilización, restricciones tempranas | La tarea se entiende sin ruido ni componentes injustificados. |
| 4. Arquitectura | Arquitectura, Datos y Seguridad | Contratos, módulos, modelo, políticas, consistencia, riesgos, alternativas | Cada regla y dato tiene dueño; las decisiones estructurales están aprobadas. |
| 5. Plan | Implementación Lead | Incrementos, archivos, pruebas y riesgos de regresión | Cada incremento tiene una verificación concreta. |
| 6. Implementación | Especialistas necesarios | Código y migraciones dentro del alcance aprobado | Funciona el flujo principal y los errores esperables están controlados. |
| 7. Verificación | QA, Testing y Revisión | Pruebas proporcionales, revisión de contratos, navegación y errores | Los riesgos relevantes tienen evidencia de validación. |
| 8. Principios | Validador de Principios | Evaluación de alineación y excepciones | Las desviaciones se corrigen o se documentan con motivo. |
| 9. Documentación | Documentación | Actualización de fuentes canónicas y operación | No queda conocimiento esencial solo en el chat o en la memoria. |
| 10. Retrospectiva | Aprendizaje | Supuesto fallido, señal temprana, prevención y regla general | El proceso reduce la probabilidad de repetir la misma clase de error. |

### 8.1 Rol del orquestador

El orquestador debe:

- Mantener visión, alcance y principios.
- Entregar a cada subagente el contexto necesario.
- Separar exploración de decisión.
- Detectar contradicciones entre dominio, UI, arquitectura y operación.
- Exigir aprobación antes de decisiones costosas, irreversibles o de alto impacto.
- Integrar resultados y resolver solapamientos.
- Mantener una sola ficha canónica por feature.
- Cerrar el ciclo con verificación y documentación.

El orquestador no usa subagentes para multiplicar opiniones sin síntesis. Cada especialista produce evidencia o una decisión dentro de un límite claro.

### 8.2 Gates de decisión

Se requiere decisión explícita antes de:

- Elegir o reemplazar stack, proveedor, persistencia o infraestructura principal.
- Introducir una entidad, estado o permiso con impacto transversal.
- Modificar contratos públicos o migrar identidades.
- Aceptar pérdida de consistencia, auditoría o compatibilidad.
- Ampliar el alcance más allá del problema aprobado.

Los detalles locales, reversibles y coherentes con patrones existentes no necesitan burocracia adicional.

### 8.3 Ficha mínima por feature

```markdown
# Feature - Nombre

## Problema y actor
## Alcance y no-alcance
## Fuentes de verdad
## Reglas, estados e invariantes
## Flujo y estados de UI
## Arquitectura y consistencia
## Criterios de aceptación
## Plan y riesgos
## Verificación
## Decisiones y excepciones
## Retrospectiva
```

## 9. Estrategia de verificación

### 9.1 Matriz por riesgo

| Tipo de cambio | Verificación mínima | Cuándo ampliar |
| --- | --- | --- |
| Copy o estilo aislado | Typecheck, prueba dirigida y revisión renderizada | Si altera layout denso, navegación o accesibilidad. |
| Componente compartido | Unitarios y revisión de todas sus variantes conocidas | Si participa de un flujo crítico. |
| Regla de dominio | Unitarios de invariantes y bordes | Si cruza persistencia o permisos. |
| Persistencia o migración | Integración, migración en ambiente seguro y rollback conocido | Si transforma datos existentes. |
| Integración externa | Contrato de éxito, rechazo, timeout y respuesta parcial | Siempre que intervenga en un flujo primario. |
| Recorrido crítico | E2E focalizado | Al cerrar un frente, ampliar regresión. |
| Infraestructura | Build, despliegue, health check y observabilidad | Si cambia secretos, red, runtime o base. |

### 9.2 Evidencia, no ritual

Un test que no cubre el contrato modificado no aporta seguridad por el solo hecho de ejecutarse. La selección de pruebas debe poder explicar qué riesgo reduce.

Los E2E no deben usarse como sustituto de unitarios o integración, ni correrse completos por cada microajuste. Tampoco deben omitirse cuando el valor de la feature depende de que UI, backend, base e integración funcionen juntos.

## 10. Retrospectiva preventiva

La retrospectiva es obligatoria cuando ocurre alguno de estos casos:

- La UI promete una capacidad inexistente.
- Un flujo informa éxito aunque una operación importante falló.
- Un dato actualizado aparece viejo en alguna superficie.
- Una integración incumple una suposición no verificada.
- El usuario encuentra redundancia, contradicción o movimiento visual que el sistema de componentes debía prevenir.
- Una corrección puntual reaparece en otra pantalla equivalente.

La retrospectiva responde:

1. ¿Qué supuesto conceptual fue incorrecto?
2. ¿Qué señal temprana se ignoró?
3. ¿Qué prueba o criterio de salida habría prevenido el problema?
4. ¿Cuál es la solución transversal, además del arreglo puntual?
5. ¿Qué fuente canónica debe actualizarse?
6. ¿El aprendizaje es portable y debería proponerse a la filosofía compartida, o sigue siendo una política local?

El objetivo no es justificar el error. Es reducir la probabilidad de repetir su clase dentro del proyecto y, cuando la evidencia permite generalizarla, en los demás consumidores del marco.

## 11. Protocolo para auditar un repositorio existente

Este protocolo permite evaluar alineación sin convertir la filosofía en una excusa para reescribir un sistema que funciona.

### 11.1 Regla inicial

La auditoría comienza en modo solo lectura. No se modifica código hasta presentar evidencia, impacto y prioridad. El estilo distinto no es por sí solo un defecto.

### 11.2 Etapa A: inventario

Relevar:

- Propósito declarado del producto y actores.
- Stack, dependencias y estructura de módulos.
- Modelo de datos y migraciones.
- Rutas, endpoints, jobs e integraciones.
- Estado, cachés y estrategias de carga.
- Componentes, formularios, tablas y filtros compartidos.
- Autenticación, permisos y capacidades.
- Errores, logs y auditoría.
- Tests, CI, ambientes y despliegue.
- Documentación y decisiones existentes.

### 11.3 Etapa B: mapa de autoridad

Para los conceptos principales, identificar:

- Fuente de verdad.
- Lectores y escritores.
- Representaciones derivadas.
- Política de frescura.
- Propietario de negocio y propietario técnico.
- Documentación canónica.

Si no puede determinarse alguno, eso es un hallazgo de gobernabilidad, no una invitación inmediata a refactorizar.

### 11.4 Etapa C: recorridos verticales

Elegir pocos recorridos representativos y seguirlos de extremo a extremo:

1. Entrada del usuario.
2. Validación de UI.
3. Contrato de aplicación.
4. Regla de dominio.
5. Persistencia o integración.
6. Respuesta, error y actualización visible.
7. Pruebas y documentación.

Los recorridos verticales revelan contradicciones que un inventario por carpetas no muestra.

### 11.5 Etapa D: clasificación de hallazgos

Cada hallazgo debe clasificarse como:

- **Alineado:** existe evidencia suficiente de que el principio se cumple.
- **Brecha:** el comportamiento contradice un principio y produce una consecuencia concreta.
- **Excepción justificada:** existe una razón documentada y el costo es consciente.
- **Evidencia insuficiente:** no puede concluirse sin ejecutar, medir o preguntar.

Formato recomendado:

| ID | Principio | Evidencia | Consecuencia | Recomendación | Alcance | Riesgo | Prioridad | Confianza |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A-01 | Única fuente de verdad | Archivo y línea | Qué puede fallar | Cambio mínimo propuesto | Local o transversal | Bajo/medio/alto | Ahora/próximo/después | Alta/media/baja |

Una preferencia personal sin consecuencia observable no debe registrarse como brecha.

### 11.6 Etapa E: priorización

Priorizar por esta secuencia:

1. Integridad de datos, dinero, seguridad y permisos.
2. Contradicciones de dominio y múltiples fuentes de verdad.
3. Fallas operativas, despliegues opacos y ausencia de trazabilidad.
4. Flujos que inducen error o impiden completar tareas.
5. Duplicación que ya provoca divergencia.
6. Inconsistencia visual y costo de mantenimiento.
7. Limpieza sin impacto inmediato.

También deben considerarse frecuencia, reversibilidad, superficie afectada y costo de migración. Una brecha importante puede requerir una secuencia gradual en lugar de un cambio masivo.

### 11.7 Etapa F: plan de alineación

El plan debe separar:

- Correcciones urgentes.
- Fundaciones pequeñas e inevitables.
- Refactorizaciones guiadas por una feature real.
- Deuda aceptada con condición de revisión.
- Ideas descartadas por no tener demanda.

Se prefiere alinear mediante cortes verticales que dejen comportamiento verificable. No se recomienda una reescritura general salvo que exista evidencia de que una migración incremental no puede preservar integridad o continuidad.

### 11.8 Entregable de auditoría

El informe final debe contener:

1. Resumen ejecutivo.
2. Topología actual del sistema.
3. Mapa de fuentes de verdad.
4. Hallazgos ordenados por prioridad y evidencia.
5. Fortalezas que deben preservarse.
6. Quick wins con bajo riesgo.
7. Trabajo estructural por etapas.
8. Decisiones que requieren al dueño del producto.
9. Plan de validación.
10. Conocimiento faltante y nivel de confianza.

## 12. Prompt portable para un agente

Después de incorporar este documento a un repositorio, puede utilizarse el siguiente prompt:

```text
Leé docs/filosofia-desarrollo-software.md y tratala como marco rector para esta tarea.

Auditá el repositorio existente para determinar qué tan alineado está con esa filosofía. Empezá en modo solo lectura: no modifiques archivos durante la auditoría.

1. Inventariá arquitectura, dominio, datos, UI, errores, tests, documentación y operación.
2. Identificá las fuentes de verdad de los conceptos principales y seguí pocos flujos verticales representativos.
3. Separá evidencia de inferencia. No marques como defecto una diferencia meramente estética o una preferencia personal.
4. Presentá primero los hallazgos con archivo y línea, consecuencia concreta, riesgo, prioridad y confianza.
5. Señalá también las fortalezas que deben preservarse y las excepciones que parezcan justificadas.
6. Proponé un plan incremental: correcciones urgentes, fundaciones inevitables, refactorizaciones ligadas a demanda real y deuda aceptable.
7. No propongas una reescritura general ni nuevas abstracciones sin demostrar qué complejidad reducen.
8. Indicá qué decisiones necesitan confirmación del dueño del producto.

El entregable debe poder ejecutarse por etapas y cada etapa debe incluir su verificación.
```

Para implementar una etapa ya aprobada:

```text
Aplicá la etapa aprobada del plan de alineación respetando docs/filosofia-desarrollo-software.md.

Antes de editar, confirmá la fuente de verdad afectada y el contrato que debe conservarse. Mantené el cambio acotado, reutilizá capacidades existentes y no amplíes el alcance. Ejecutá pruebas proporcionales al riesgo, actualizá solamente la documentación canónica correspondiente y cerrá con una retrospectiva si descubrís una causa conceptual reutilizable.
```

## 13. Señales de desalineación frecuentes

- Dos módulos calculan de forma distinta el mismo estado.
- Una edición parece exitosa, pero otra vista conserva datos viejos sin contrato explícito.
- Se borran y recrean entidades referenciadas para simplificar un formulario.
- Una categoría de dominio existe “por las dudas” y no modifica comportamiento.
- Un mismo formulario o filtro fue copiado para cada tipo de usuario.
- Las restricciones se informan después de que el usuario completó la acción.
- Los mensajes técnicos llegan a la UI sin traducción de dominio.
- La pantalla agrega títulos, cards o métricas sin una decisión que apoyar.
- Los datos asincrónicos desplazan acciones y columnas.
- El equipo corre todos los E2E por cada ajuste, pero no prueba errores de integraciones críticas.
- Una decisión importante existe solo en el chat o en la memoria de una persona.
- La arquitectura se explica por el framework, no por las responsabilidades del producto.
- Los despliegues, migraciones o secretos dependen de pasos manuales no documentados.
- Una corrección equivalente se implementa pantalla por pantalla.

## 14. Definición de un repositorio alineado

Un repositorio está razonablemente alineado cuando:

- El propósito y los actores del producto son explícitos.
- Las features activas responden a demanda real.
- Los conceptos principales tienen una fuente de verdad identificable.
- Las reglas de dominio no dependen accidentalmente de UI o proveedor.
- La duplicación relevante se comparte o tiene una excepción explicable.
- Las identidades y transacciones conservan integridad.
- Los contratos de consistencia y caché están definidos.
- La interfaz usa estructuras estables, sobrias y reutilizables.
- Las restricciones y errores aparecen en el momento útil.
- Las pruebas corresponden a los riesgos reales.
- Los ambientes y despliegues son observables y reproducibles.
- La documentación permite retomar el trabajo sin depender del chat.
- Las decisiones futuras pueden tomarse sin perder control de lo que ya existe.

La alineación no exige perfección ni uniformidad absoluta. Exige que la complejidad sea deliberada, que las excepciones sean conscientes y que el sistema siga siendo gobernable mientras evoluciona.
