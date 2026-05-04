<?php
session_start();
require_once("php/conexion.php");

/* SEGURIDAD */
if(!isset($_SESSION['email'])){
    header("Location: login.php");
    exit();
}

if($_SESSION['tipo_usuario'] != "admin"){
    header("Location: principal.php");
    exit();
}

/* =====================================
   ACCIONES ADMIN
===================================== */

if(isset($_GET['aprobar'])){

    $id = intval($_GET['aprobar']);

    $enlace->query("
    UPDATE negocios
    SET estado='aprobado'
    WHERE id_negocios='$id'
    ");

    header("Location: admin_negocios.php");
    exit();
}

if(isset($_GET['rechazar'])){

    $id = intval($_GET['rechazar']);

    $enlace->query("
    UPDATE negocios
    SET estado='rechazado'
    WHERE id_negocios='$id'
    ");

    header("Location: admin_negocios.php");
    exit();
}

if(isset($_GET['suspender'])){

    $id = intval($_GET['suspender']);

    $enlace->query("
    UPDATE negocios
    SET estado='suspendido'
    WHERE id_negocios='$id'
    ");

    header("Location: admin_negocios.php");
    exit();
}

if(isset($_GET['eliminar'])){

    $id = intval($_GET['eliminar']);

    $enlace->query("
    DELETE FROM negocios
    WHERE id_negocios='$id'
    ");

    header("Location: admin_negocios.php");
    exit();
}

/* =====================================
   LISTAR NEGOCIOS
===================================== */

$negocios = $enlace->query("
SELECT n.*, u.nombre, u.email
FROM negocios n
INNER JOIN usuarios u
ON n.id_usuario = u.id_usuarios
ORDER BY n.id_negocios DESC
");
?>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Negocios</title>

<link rel="stylesheet" href="css/admin_leafy.css">
<link rel="stylesheet" href="css/admin_negocios.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">

<div class="logo">Leafy</div>

<a href="admin_leafy.php">
<i class="fa-solid fa-chart-line"></i> Dashboard
</a>

<a href="admin_usuarios.php">
<i class="fa-solid fa-users"></i> Usuarios
</a>

<a href="admin_negocios.php" class="activo">
<i class="fa-solid fa-store"></i> Negocios
</a>

<a href="admin_productos.php">
<i class="fa-solid fa-shirt"></i> Productos
</a>

<a href="admin_comentarios.php">
<i class="fa-solid fa-comments"></i> Comentarios
</a>

<a href="admin_reportes.php">
<i class="fa-solid fa-flag"></i> Reportes
</a>

<a href="php/logout.php">
<i class="fa-solid fa-right-from-bracket"></i> Salir
</a>

</div>

<!-- MAIN -->
<div class="main">

<!-- TOPBAR -->
<div class="topbar">

<div class="titulo">
<h1>Gestión de Negocios</h1>
<p>Administra los negocios registrados</p>
</div>

<div class="perfil-admin">
<?php echo $_SESSION['nombre']; ?>
</div>

</div>

<!-- TABLA -->
<div class="tabla-box">

<table>

<thead>
<tr>
<th>ID</th>
<th>Negocio</th>
<th>Dueño</th>
<th>Correo</th>
<th>Teléfono</th>
<th>Estado</th>
<th>Acciones</th>
</tr>
</thead>

<tbody>

<?php if($negocios && $negocios->num_rows > 0): ?>

<?php while($fila = $negocios->fetch_assoc()): ?>

<tr>

<td><?php echo $fila['id_negocios']; ?></td>

<td><?php echo $fila['nombre_negocio']; ?></td>

<td><?php echo $fila['nombre']; ?></td>

<td><?php echo $fila['email']; ?></td>

<td><?php echo $fila['telefono']; ?></td>

<td>
<span class="estado <?php echo strtolower($fila['estado']); ?>">
<?php echo ucfirst($fila['estado']); ?>
</span>
</td>

<td>

<div class="acciones">

<a href="admin_negocios.php?aprobar=<?php echo $fila['id_negocios']; ?>" class="btn aprobar">
Aprobar
</a>

<a href="admin_negocios.php?rechazar=<?php echo $fila['id_negocios']; ?>" class="btn rechazar">
Rechazar
</a>

<a href="admin_negocios.php?suspender=<?php echo $fila['id_negocios']; ?>" class="btn suspender">
Suspender
</a>

<a href="admin_negocios.php?eliminar=<?php echo $fila['id_negocios']; ?>"
onclick="return confirm('¿Eliminar negocio?')"
class="btn eliminar">
Eliminar
</a>

</div>

</td>

</tr>

<?php endwhile; ?>

<?php else: ?>

<tr>
<td colspan="7" class="vacio">
No hay negocios registrados.
</td>
</tr>

<?php endif; ?>

</tbody>

</table>

</div>

</div>

</body>
</html>