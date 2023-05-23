<?php

require_once "Conexion.php";

class Usuario extends Conexion{

  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion = parent::getConexion();
  }

  public function iniciarSesion($nombreusuario = ""){
    try{
      $consulta = $this->conexion->prepare("spu_usuario_login");
      $consulta->execute(array($nombreusuario));
      return $consulta->fetch(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }
}
