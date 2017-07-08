<?php
// ---------------------------------------
// Webcam image wall display
// Webcam are described in cam-wall.lst 
// Parameters :
//   wall - Wall number to display
//   cam - index of main cam to display
//   rate - refresh rate of the wall (in milliseconds)
// Revision history :
//   07/06/2017 - V1.0 - Creation by N. Bernaerts
// ---------------------------------------

// constant
$rateWall = 1000;
$idxWall = 1;
$idxCam = -1;
$numCam = 0;

// variables
$arrCam = Array ();
$urlPage = $_SERVER['PHP_SELF'];

// get parameters
if (isset($_GET["wall"])) $idxWall = $_GET["wall"];
if (isset($_GET["cam"])) $idxCam = $_GET["cam"];
if (isset($_GET["rate"])) $rateWall = $_GET["rate"];

// read the cam configuration list
$arrLine = file ("cam-wall.lst");
foreach ($arrLine as $index => $line) 
{
	// extract key, label and url from line
	$arrParam = explode(";", trim($line), 4);
	$arrWall  = explode("-", $arrParam[3]);

	// if camera is in current wall, add to array
	if (in_array($idxWall, $arrWall))
	{
		// add cam to cam array
		$arrCam[$numCam]['key'] = "cam" . $numCam;
		$arrCam[$numCam]['name'] = $arrParam[0];
		$arrCam[$numCam]['image'] = $arrParam[1];
		$arrCam[$numCam]['video'] = $arrParam[2];

		// increment cam number
		$numCam += 1;
	}
}

?>

<!doctype html>
<html lang="fr">
<head>

<?php

// if wall doesn't include cam close-up
if ($idxCam != -1) 
{
	// include style sheet
	include 'cam-wall-detail.inc';

	// display title
	echo ("<title>Camera wall " . $idxWall . " - " . $arrCam[$idxCam]['name'] . "</title>\n" );
}

// else, wall include a close-up
else
{
	// include style sheet
	include 'cam-wall-only.inc';

	// display title
	echo ("<title>Camera wall " . $idxWall . "</title>\n" );
}

?>

<meta charset="UTF-8">
<script type='text/javascript'>
function loadImage(imgID)
{
	var now=new Date();
	var URL=document.getElementById(imgID).src
	document.getElementById(imgID).src=URL.substring(0,URL.indexOf("refresh=")) + 'refresh=' + now.getTime();
}

<?php

// loop to declare cams wall refresh rate
echo ("setInterval(function() { ");
foreach ($arrCam as $index => $cam) { echo ("loadImage('" . $cam['key'] . "'); "); }
echo (" }, " . $rateWall . ");\n");

// declare detail cam refresh rate
echo ("setInterval(function() { loadImage('live'); }, 1000);\n");

?>

</script>
</head>

<body>
<div class='list'>

<?php

// loop to display cam miniature
foreach ($arrCam as $index => $cam) 
{
	echo ("<div class='cam'>");
	echo ("<div class='text'>" . $cam['name'] . "</div>");
	echo ("<a href='" . $cam['video'] . "'>");
	echo ("<img id='" . $cam['key'] . "' src='" . $cam['image'] . "'>");
	echo ("</a></div>\n");
}

?>

</div>

<?php

// if main cam is defined
if ($idxCam != -1)
{
	echo ("<div class='live'>");
	echo ("<div class='text'>" . $arrCam[$idxCam]['name'] . "</div>");
	echo ("<a href='" . $arrCam[$idxCam]['video']  . "'>");
	echo ("<img id='live' src='" . $arrCam[$idxCam]['image'] . "'>");
	echo ("</a></div>");
}

?>

</body>

</html>
