<?php

class Conexion{

  private function Conexion(){
    try{
      $pdo = new PDO("mysql:host=localhost;port=3306;dbname=almacen;charset=UTF8","root","");
      return $pdo;
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function getConexion(){
    try{
      $pdo = $this->Conexion();
      $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $pdo;
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }
}