From: Dexter.Filmore@gmx.de (Dexter Filmore)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: linux-2.6.1, ECS K7S5A / SiS735
Message-Id: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hi.

I just installed lm-sensors 2.8.2 user utils to read the sis735 board sensors
in my server, running linux-2.6.1.

first of all I got confused over what to compile or not. As of now, there is
sis5595 as a module (since sensors-detect asks for it), then there is sis96x
as a module since the kernel help says it supports the 735 chipset.
i2c support is compiled in statically.

now first of all I hacked the detect script to look for sis96x since sis645
module doesn't exist at all.
script loads it fine, the it8705 chip, too (*and* the sis5595, bob knows why)
but later on after everything is loaded, namely:
i2c_sis96x              4416  0
it87                   21632  0
i2c_sensor              2368  1 it87

it still tells me "no sensors found".

any ideas?


-- 
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
FGCS d--(+)@ s-:+ a- C+++(++++) UL+>++++ P+>++ L+++>++++ E-- W++ N o? K-
w--(---) !O M+ V- PS++(+) PE(-) Y+ PGP(-) t++(---)@ 5 X+(++) R+(++) tv--(+)@ 
b+(+++) DI+++ D G++ e* h>++ r%>* y?
------END GEEK CODE BLOCK------

http://www.againsttcpa.com - nothing fights like the opposition
