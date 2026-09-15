# BaseDeDatos-U2-Ej20-Coworking
Base de Datos - Unidad 2 - Ejercicio 20

Consigna

Modelar un centro de coworking: espacios físicos tipificados con su tarifa, miembros con tarjeta RFID, reservas de espacios por franja horaria, fichajes de entrada y salida en los molinetes, y consumo de servicios adicionales.

Lógica

TARJETA-RFID como entidad separada de MIEMBRO. La tentación es dejar el número de tarjeta como un atributo más del miembro, pero se rompe en el primer extravío: al dar de alta una tarjeta nueva se pisaría el número viejo y todos los fichajes históricos quedarían apuntando a una tarjeta que ya no existe. Con TARJETA como entidad, un miembro tiene varias a lo largo del tiempo (fecha_emision, fecha_vencimiento, estado_tarjeta) y cada acceso queda atado a la que realmente se usó. Eso es lo que pide el punto 3: el fichaje se relaciona con la tarjeta, no directamente con la persona.

El miembro validado se deduce de la tarjeta, no se repite en el acceso. ACCESO no lleva Id_Miembro: llega a la persona por TARJETA → MIEMBRO. Guardar las dos FK sería una redundancia que permitiría inconsistencias (un fichaje con una tarjeta de Juan pero atribuido a Ana). Este es el tipo de dependencia transitiva que la normalización busca eliminar.

RESERVA como entidad asociativa entre MIEMBRO y ESPACIO. Ambas relaciones son 1:N hacia la reserva. Las tres columnas temporales (fecha_uso, hora_inicio, hora_fin) son lo que permite el control del punto 2.

Control de solapamientos (punto 2). El DER no puede expresar esta regla: se implementa como restricción. Una reserva nueva se rechaza si existe otra del mismo espacio, en la misma fecha_uso, cuyo rango se cruce con el pedido: hora_inicio < hora_fin_pedida AND hora_fin > hora_inicio_pedida, considerando solo las reservas no canceladas. Lo importante es que la condición se evalúa por espacio y no por miembro, porque lo que no puede duplicarse es la ocupación física del lugar. Una restricción UNIQUE simple no alcanza: los solapamientos son rangos, no valores repetidos.

SERVICIO como catálogo y CONSUMO como registro. Los productos de barra, impresiones o alquiler de equipos se repiten entre miembros: dejarlos como texto libre dentro del consumo duplicaría descripciones y precios. Con el catálogo, precio_unitario está en un solo lugar y el consumo guarda cantidad y costo_total, que se congela al momento de la operación para que un cambio de lista de precios no altere los consumos ya facturados.

Nomenclatura y unicidad (punto 4). Entidades en singular y mayúscula, relaciones con verbo, PK subrayada, FK nombradas Id_<Entidad>. Restricciones de unicidad y participación: numero_tarjeta único en todo el sistema y una sola tarjeta activa por miembro a la vez; dni_miembro y email_miembro únicos; participación total de RESERVA en ambas relaciones (no existe reserva sin miembro ni sin espacio) y de ACCESO en la suya (no hay fichaje sin tarjeta); hora_fin posterior a hora_inicio; los fichajes deberían alternar Entrada y Salida por tarjeta; y no se aceptan accesos con tarjetas vencidas o dadas de baja.

Nota sobre el molinete. Se dejó id_molinete como atributo del acceso siguiendo el enunciado. Si se quisiera administrar el parque de molinetes (ubicación, estado, mantenimiento), correspondería una entidad MOLINETE con una relación 1:N hacia ACCESO.

Resultado
<img width="4800" height="2551" alt="BaseDeDatos-U2-Ej20-Coworking" src="https://github.com/user-attachments/assets/818efde0-03e7-49f0-889b-72eb6a2f62e9" />
