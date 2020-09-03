<?php
  //Dados pessoais
  $nome = $_POST['nome'];
  $email = $_POST['email'];
  $cpf = $_POST['cpf'];
  $dt_nascimento = $_POST['data'];
  $telefone = $_POST['telefone'];
  
  //Dados de endereço
  $cep = $_POST['cep'];
  $rua = $_POST['logradouro'];
  $bairro = $_POST['bairro'];
  $cidade = $_POST['cidade'];
  $uf = $_POST['uf'];
  $numero = $_POST['numero'];
  $comp = $_POST['comp'];
 
  //Dados bancarios
  $banco = $_POST['banco'];
  $tipo = $_POST['tipo'];
  $agencia = $_POST['agencia'];
  $conta = $_POST['conta'];


  //Conexao banco
  $con = new PDO("mysql:host=localhost; dbname=id14675543_arzin2020; charset=utf8;","id14675543_arzinarzin","Ar2020!zin!!");

  //insere dados na tbl prestador
  $sql = $con->prepare("INSERT INTO prestador (id, nome, email, cpf, dt_nascimento, telefone, banco, agencia, tipo, conta) VALUES (NULL,?,?,?,?,?,?,?,?,?)");
  $sql->execute(array(NULL,$nome,$email,$cpf,$dt_nascimento,$telefone,$banco,$agencia,$tipo,$conta));

  //insere dados ba tbl endereco
  $sql = $con->prepare("INSERT INTO endereco (cep, rua, bairro, cidade, uf, numero, complemento) VALUES (?,?,?,?,?,?,?)");
  $sql->execute(array($cep,$rua,$bairro,$cidade,$uf,$numero,$comp));

 
  

?>