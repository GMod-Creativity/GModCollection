<?php
 require('./mc.php');
error_reporting(E_ALL);
ini_set( 'display_errors','1');


    
   
    $midi = new Midi();
    $midi->importMid($_GET['fn']);
    echo "";
    echo ($midi->getBpm()+$midi->getTimebase() . "@@");
    echo "";
    






?>

<pre>
    <?=$midi->getTxt(0)?>
</pre>