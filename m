From: max.maverick@maverick.eu.org (Benoit Plessis)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello guy,

i own an Asus Mainboard with it's infamous ASB100 Bach ASIC. I
wanted to get it work with lm_sensors, but some part were
behaving mysteriously (mainly the 2d fan speed and the 2nd temp).

While googling i found something that may interesst you:
http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html

the xmbmon package which is in the following license:
  The programs are completely free software.   Any modifications
and changes to the programs are welcome, and they are freely
copied and distributed.  The author is not at all responsible if
anyone have any problems or damages when using the programs.  The
author won't keep the development of the programs any further, at
least now.  But if someone develops any new better programs based
on my own, I am very glad if feedback is made to me (of course,
it is not at all any duties!).

THis software is able to initialise correctly the ASB100 ASIC
(since after running mbmon sensors can find the fan 2 speed, but
not the temp2) and to read the Athlon thermal diod temperature.

Maybe some of its code can be ported to lm_sensors ?

Btw, great works to all
Benoit

--
Benoit Plessis					+33 6 77 42 78 32
<benoit.plessis@tuxfamily.org>
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76
