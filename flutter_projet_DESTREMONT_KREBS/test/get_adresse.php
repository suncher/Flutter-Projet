<?php	
header("Access-Control-Allow-Origin:*", true);
	try{
	
		$objPdo = new PDO('mysql:host=devbdd.iutmetz.univ-lorraine.fr;port=3306;dbname=destremo7u_flutter','destremo7u_appli','31902868');
	
	}
	catch( Exception $exception ) 
	{  
		die($exception->getMessage()); 
	} 
	 

?>

<?php
//header("Content-type: application/json; charset=utf-8");
$query = 'SELECT * FROM `adresse`';
$stm = $db->prepare($query);
$stm->execute();
$rows = $stm->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);
?>