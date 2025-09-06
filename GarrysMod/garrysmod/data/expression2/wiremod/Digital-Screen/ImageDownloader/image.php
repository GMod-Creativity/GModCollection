<?php
    function map($in, $imin, $imax, $omin, $omax)
    {
        return (($in - $imax) * (($omin - $omax) / ($imin - $imax)) + $omax);
    }
    
    if(strpos($_GET["i"],".png")){
   $img = imagecreatefrompng($_GET["i"]);
   }
   if(strpos($_GET["i"],".gif")){
   $img = imagecreatefromgif($_GET["i"]);
   }
   if(strpos($_GET["i"],".jpg")){
   $img = imagecreatefromjpeg($_GET["i"]);
   } 
   
   echo ini_set("allow_url_fopen","1"); 
   $w = imagesx($img);
   $h = imagesy($img);
    
   for($y=0;$y<$h;$y++) {
      for($x=0;$x<$w;$x++) {
         $rgb = imagecolorat($img, $x, $y);
         $r = ($rgb >> 16) & 0xFF;
         $g = ($rgb >> 8) & 0xFF;
         $b = $rgb & 0xFF;        
         echo chr(round($g+1,-1)).chr(round($b+1,-1)).chr(round($r+1,-1));
         //echo "#".str_repeat("0",2-strlen(dechex($r))).dechex($r).
         //str_repeat("0",2-strlen(dechex($g))).dechex($g).
         //str_repeat("0",2-strlen(dechex($b))).dechex($b).",";
      }
   }
?>