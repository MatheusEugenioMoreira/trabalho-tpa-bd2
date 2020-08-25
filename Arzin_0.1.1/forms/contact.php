<?php
  
 $nome = $_POST['nome'],
 $email = $_POST['email'],
 $dt_nascimento = $_POST['data'],
 $telefone = $_POST['telefone'],
 $cep = $_POST['cep'],
 $rua = $_POST['logradouro'],
 $bairro = $_POST['bairro'],
 $cidade = $_POST['cidade'],
 $uf = $_POST['uf'],
 $numero = $_POST['numero'],
 $comp = $_POST['comp'],

  $db_host = 'localhost';
  $db_username = 'id14675543_arzinarzin';
  $db_password = 'Ar2020!zin!!';
  $db_name = 'id14675543_arzin2020';
  mysql_connect($db_host,$db_username, $db_password);
  mysql_select_db($db_name);

  mysql_query("INSERT INTO prestador (id, nome, email, dt_nascimento, telefone, cep, rua, bairro, cidade, uf, numero, complemento) VALUES (NULL, $nome, $email, $dt_nascimento, $telefone, $cep, $rua, $bairro, $cidade, $uf, $numero, $comp)");
  

?>
  