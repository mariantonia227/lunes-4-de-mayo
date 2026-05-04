<?php
session_start();
require_once(__DIR__ . "/php/conexion.php");

/* ============================
   VERIFICAR SESIÓN
============================ */

if (!isset($_SESSION['tipo_usuario']) || $_SESSION['tipo_usuario'] != "negocio") {
    header("Location: principal.php");
    exit();
}

$email = $_SESSION['email'];

/* ============================
   1️⃣ OBTENER USUARIO
============================ */

$resultUser = $enlace->query("
SELECT id_usuarios, nombre, foto_perfil
FROM usuarios
WHERE email = '$email'
");

$user = $resultUser->fetch_assoc();

$id_usuario = $user['id_usuarios'];
$nombre_usuario = $user['nombre'];
$foto = $user['foto_perfil'];

/* ============================
   2️⃣ OBTENER NEGOCIO + ESTADO
============================ */

$resultNegocio = $enlace->query("
SELECT id_negocios, nombre_negocio, estado
FROM negocios
WHERE id_usuario = '$id_usuario'
");

$negocio = $resultNegocio->fetch_assoc();

$id_negocio = $negocio['id_negocios'];
$nombre_negocio = $negocio['nombre_negocio'];
$estado_negocio = $negocio['estado'];

/* ============================
   SI NO ESTÁ APROBADO
============================ */

$bloqueado = false;

if ($estado_negocio != "aprobado") {
    $bloqueado = true;
}

/* ============================
   3️⃣ CONTAR PRODUCTOS
============================ */

$totalProductos = 0;
$totalPedidos = 0;
$totalPendientes = 0;
$totalVentas = 0;

if (!$bloqueado) {

    $resultProductos = $enlace->query("
    SELECT COUNT(*) as total
    FROM productos
    WHERE id_negocios = '$id_negocio'
    ");
    $totalProductos = $resultProductos->fetch_assoc()['total'];

    $resultPedidos = $enlace->query("
    SELECT COUNT(*) as total
    FROM pedidos
    WHERE id_negocios = '$id_negocio'
    ");
    $totalPedidos = $resultPedidos->fetch_assoc()['total'];

    $resultPendientes = $enlace->query("
    SELECT COUNT(*) as total
    FROM pedidos
    WHERE id_negocios = '$id_negocio'
    AND estado_pedido = 'pendiente'
    ");
    $totalPendientes = $resultPendientes->fetch_assoc()['total'];

    $resultVentas = $enlace->query("
    SELECT SUM(total) as total
    FROM pedidos
    WHERE id_negocios = '$id_negocio'
    AND estado_pedido = 'completado'
    ");

    $totalVentas = $resultVentas->fetch_assoc()['total'];

    if (!$totalVentas) {
        $totalVentas = 0;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Dashboard - <?php echo $nombre_negocio; ?></title>
<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>

<div class="sidebar">

<h2><?php echo $nombre_negocio; ?></h2>

<ul>
<li><a href="dashboard.php">Inicio</a></li>

<?php if(!$bloqueado): ?>
<li><a href="dashboard_productos.php">Mis Productos</a></li>
<li><a href="dashboard_pedidos.php">Pedidos</a></li>
<?php endif; ?>

</ul>

</div>

<div class="main">

<div class="topbar">

<div class="user-menu">

<div class="user-trigger" onclick="toggleMenu()">

<img src="<?php echo (!empty($foto)) ? str_replace('../','',$foto) : 'assets/perfil-default.png'; ?>" class="perfil-img">

<span>Bienvenido, <?php echo $nombre_usuario; ?></span>

<i class="fa-solid fa-chevron-down"></i>

</div>

<div class="dropdown" id="dropdownMenu">
<a href="dashboard_configuracion.php">⚙ Configuración</a>
<a href="php/logout.php">Cerrar sesión</a>
</div>

</div>
</div>

<h2 class="negocio-nombre"><?php echo $nombre_negocio; ?></h2>

<!-- MENSAJES SEGÚN ESTADO -->

<?php if($estado_negocio == "pendiente"): ?>

<div style="background:#fff3cd;padding:15px;border-radius:10px;margin-bottom:20px;color:#856404;">
⏳ Tu negocio está en revisión. Cuando sea aprobado podrás usar todas las funciones.
</div>

<?php elseif($estado_negocio == "rechazado"): ?>

<div style="background:#f8d7da;padding:15px;border-radius:10px;margin-bottom:20px;color:#721c24;">
❌ Tu solicitud fue rechazada. Revisa tu información y contacta soporte.
</div>

<?php elseif($estado_negocio == "suspendido"): ?>

<div style="background:#d6d8db;padding:15px;border-radius:10px;margin-bottom:20px;color:#383d41;">
🚫 Tu negocio está suspendido temporalmente.
</div>

<?php endif; ?>

<div class="cards">

<div class="card">
<h3>📦 Productos</h3>
<p><?php echo $totalProductos; ?></p>
</div>

<div class="card">
<h3>🛒 Pedidos</h3>
<p><?php echo $totalPedidos; ?></p>
</div>

<div class="card">
<h3>⏳ Pendientes</h3>
<p><?php echo $totalPendientes; ?></p>
</div>

<div class="card">
<h3>💰 Ventas</h3>
<p>$<?php echo number_format($totalVentas,0,',','.'); ?></p>
</div>

</div>

</div>

<script src="js/dashboard.js"></script>
</body>
</html>