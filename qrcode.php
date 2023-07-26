<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
$msg = "";
$ok = false;

if(count($_POST)>0) {
	//FEHLT: Prüfen der SVNr
	
	$arr = str_split($_POST["SVNr"]);
	ta($arr);
	
	$pruefziffer = (
		$arr[0]*3 +
		$arr[1]*7 +
		$arr[2]*9 +
		$arr[4]*5 +
		$arr[5]*8 +
		$arr[6]*4 +
		$arr[7]*2 +
		$arr[8] +
		$arr[9]*6
		) % 11;
	
	ta($pruefziffer);
	if($arr[3]==$pruefziffer) {
		//das ist eine gültige Sozialversicherungsnummer
	
		$sql = "
			SELECT
				COUNT(*) AS cnt
			FROM tbl_user
			WHERE(
				SVNr=" . $_POST["SVNr"] . "
			)
		";
		$userliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
		$user = $userliste->fetch_object();
		if($user->cnt==0) {
			//diese SVNr ist im System noch nicht gespeichert --> speichern
			$sql = "
				INSERT INTO tbl_user
					(Vorname, Nachname, SVNr, FIDGeschlecht)
				VALUES (
					'" . $_POST["VN"] . "',
					'" . $_POST["NN"] . "',
					" . $_POST["SVNr"] . ",
					" . $_POST["IDGeschlecht"] . "
				)
			";
			//ta($sql);
			$ok = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			$text = $_POST["VN"] . " " . $_POST["NN"] . ", " . $_POST["SVNr"];
			
			$msg = '<p class="success">Vielen Dank. Ihre Daten wurden gespeichert.</p>';
		}
		else {
			$msg = '<p class="error">Diese SVNr ist in unserem System bereits registriert.</p>';
		}
	}
	else {
		$msg = '<p class="error">Das ist keine gültige SVNr.</p>';
	}
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>QR-Code</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1">
		<link rel="stylesheet" href="css/common.css">
		<script src="js/qrcode.min.js"></script>
		<style>
			#qrcode {
				margin:auto;
				width:fit-content;
				padding:0.5em;
				border-radius:0.2em;
				border:1px solid #ccc;
			}
		</style>
	</head>
	<body>
		<?php echo($msg); ?>
		<form method="post">
			<label>
				Vorname:
				<input type="text" name="VN" required>
			</label>
			<label>
				Nachname:
				<input type="text" name="NN" required>
			</label>
			<label>
				Geschlecht:
				<select name="IDGeschlecht">
					<?php
					$sql = "
						SELECT
							*
						FROM tbl_geschlechter
					";
					$geschlechter = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
					while($geschlecht = $geschlechter->fetch_object()) {
						echo('
							<option value="' . $geschlecht->IDGeschlecht . '">' . $geschlecht->Geschlecht . '</option>
						');
					}
					?>
				</select>
			</label>
			<label>
				SVNr:
				<input type="number" name="SVNr" required min="10100" max="9999311299" step="1">
			</label>
			<input type="submit" value="eintragen">
		</form>
		
		<?php if($ok) { ?>
		<div id="qrcode"></div>
		<script>
		var qrcode = new QRCode(document.querySelector("#qrcode"), {
			text: "<?php echo($text); ?>",
			width: 128,
			height: 128,
			colorDark : "#333333",
			colorLight : "#ffffff",
			correctLevel : QRCode.CorrectLevel.H
		});
		</script>
		<?php } ?>
	</body>
</html>