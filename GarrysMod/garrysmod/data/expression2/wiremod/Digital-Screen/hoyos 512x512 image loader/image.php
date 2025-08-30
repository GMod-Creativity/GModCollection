<?php
$add = "";
$str = "";
$img = imagecreatefrompng("input.png");
$idx = 0;
$count = 0;
for ($y=0;$y<512;$y++)
{
    for ($x=0;$x<512;$x++)
    {
        $px = imagecolorat($img,$x,$y);
        $r = floor((($px >> 16) & 0xFF)/28.3333);
        $g = floor((($px >> 8) & 0xFF)/28.3333);
        $b = floor(($px & 0xFF)/28.3333);
        if ($idx == 0)
        {
            $add .= "$r$g$b";
            $idx = $idx + 1;
            $count++;
        }
        elseif ($idx < 32)
        {
            $add .= "$r$g$b";
            $idx = $idx + 1;
            $count++;
        }
        else
        {
            $add .= "$r$g$b";
            $idx = 1;
            $count++;
        }
    }
}

$f = fopen("output.txt", "w");
fwrite($f, $add);
fclose($f);
?>