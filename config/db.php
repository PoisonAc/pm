
<?php
// Configurações do banco de dados
$servername = "localhost"; // ou o endereço do seu servidor
$username = "usuario"; // seu usuário do banco de dados
$password = ""; // sua senha do banco de dados
$dbname = "nome_do_banco"; // nome do banco de dados

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexão
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}
?>