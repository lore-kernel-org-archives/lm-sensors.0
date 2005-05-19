From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <Pine.LNX.4.58.0407221629440.15802@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407221213.00965.lourens@rainbowdesert.net>
In-Reply-To: <200407221213.00965.lourens@rainbowdesert.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> The positive values seem to be alright. -12V and -5V obviously
> aren't. Fan1 (the CPU fan) seems to be okay, but Fan2 (case fan)
> gives 0 rpm, even though it is actually running. Temperature
> readings do work.

The voltages might use non-standart circuit, only chance getting this
working is bios disassembly. Second reason might be that it is actualy
unconnected.

You can add ignore statements to /etc/sensors.conf.

First find your chip configuration part and use the
ignore statement.

like ignore inX where X would corresspond to the label inX statement.
ignore in6
ignore in5


For the fan there might be two reasons

1) fan3 is ignored via the config file
2) fan2 has wrong divisor set

   set fan2_div 4
(try 8)

After these changes (to config file) dont't forget to run
sensors -s

I hope this helps.
Please CC to list too when replying.

Thanks

Regards

Rudolf
