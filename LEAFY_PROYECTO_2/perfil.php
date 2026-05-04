<?php
session_start();
require_once("php/conexion.php");

if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

$email = $_SESSION['email'];

// Obtener datos del usuario
$sql = "SELECT * FROM usuarios WHERE email='$email'";
$user = $enlace->query($sql)->fetch_assoc();
$id_usuario = $user['id_usuarios'];
?>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Mi Perfil</title>
<link rel="stylesheet" href="css/perfil.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>

<div class="perfil-container">
<h1>👤 Mi Perfil</h1>

<!-- Menú -->
<div class="tabs">
    <button type="button" data-tab="info">Datos</button>
    <button type="button" data-tab="compras">Compras</button>
    <button type="button" data-tab="favoritos">Favoritos</button>
</div>

<!-- INFO -->
<div id="info" class="tab active">
    <form action="php/actualizar_perfil.php" method="POST" enctype="multipart/form-data">
        <div class="foto-perfil">
            <img src="<?php echo (!empty($user['foto_perfil'])) ? str_replace('../','',$user['foto_perfil']) : 'assets/perfil-default.png'; ?>">
            <input type="file" name="foto">
        </div>
        <input type="text" name="nombre" value="<?php echo $user['nombre']; ?>">
        <input type="email" name="email" value="<?php echo $user['email']; ?>">
        <input type="password" name="password" placeholder="Nueva contraseña">
        <button type="submit">Guardar cambios</button>
    </form>
    <a href="javascript:history.back()" class="btn-volver">← Volver</a>
</div>

<!-- COMPRAS -->
<div id="compras" class="tab">
<?php
$compras = $enlace->query("SELECT * FROM pedidos WHERE id_usuarios='$id_usuario' ORDER BY id_pedido DESC");

if (!$compras) {
    die("ERROR COMPRAS: " . $enlace->error);
} elseif ($compras->num_rows > 0) {
    while($compra = $compras->fetch_assoc()) {
        echo '<div class="card">';
        echo '<p><strong>Pedido #' . $compra['id_pedido'] . '</strong></p>';
        echo '<p>Total: $' . number_format($compra['total']) . '</p>';
        echo '<p>Fecha: ' . $compra['fecha'] . '</p>';
        echo '<p>Estado: ' . $compra['estado_pedido'] . '</p>';

        // 🔥 BOTÓN VER DETALLE
        echo '<a href="detalle_pedido.php?id=' . $compra['id_pedido'] . '" class="btn-detalle">Ver detalle</a>';

        echo '</div>';
    }
} else {
    echo '<p>No tienes compras aún 🛒</p>';
}
?>
</div>

<!-- FAVORITOS -->
<div id="favoritos" class="tab">
<?php
$favoritos = $enlace->query("
    SELECT p.*, f.id_favorito 
    FROM favoritos f
    JOIN productos p ON f.id_producto = p.id_producto
    WHERE f.id_usuarios='$id_usuario'
");

if (!$favoritos) {
    die("ERROR FAVORITOS: " . $enlace->error);
} elseif ($favoritos->num_rows > 0) {
    while($prod = $favoritos->fetch_assoc()) {
        echo '<div class="card">';
        echo '<p>' . $prod['nombre'] . '</p>';
        echo '<p>$' . number_format($prod['precio']) . '</p>';

        // 🔥 BOTÓN ELIMINAR
        echo '<a href="php/eliminar_favorito.php?id=' . $prod['id_favorito'] . '" class="btn-eliminar">Eliminar</a>';

        echo '</div>';
    }
} else {
    echo '<p>No tienes favoritos ❤️</p>';
}
?>
</div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function() {

    const botones = document.querySelectorAll(".tabs button");
    const tabs = document.querySelectorAll(".tab");

    botones.forEach(boton => {
        boton.addEventListener("click", function() {

            tabs.forEach(tab => tab.classList.remove("active"));
            botones.forEach(btn => btn.classList.remove("active"));

            const tabId = this.getAttribute("data-tab");
            document.getElementById(tabId).classList.add("active");

            this.classList.add("active");
        });
    });

});
</script>

</body>
</html>