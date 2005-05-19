From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Another A7N8X User Waiting Patiently
Message-Id: <20030325094107.23575b5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200303242147.59747.rob.blomquist@verizon.net>
In-Reply-To: <200303242147.59747.rob.blomquist@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Running Mandrake 9.0 stock out of the box (at least with respect to 
> this issue), so my kernel is 2.4.19-16mdk, i2c is built into it, and 
> I have the lm_sensors-2.6.4-5.1mdk.

A7N8X is recent, 2.6.4 is somehow old. I wouldn't expect it to work.

> I modprobed everything in /i2c and the /sensors directories, and got 
> this:
> [root@timmy2 robbo]# lsmod
> Module                  Size  Used by    Tainted: P
> i2c-isa                 1224   0  (unused)
> i2c-algo-pcf            5212   0
> lm78                    7124   0  (unused)
> lm75                    3232   0  (unused)
> it87                    6852   0  (unused)
> gl520sm                 6824   0  (unused)
> gl518sm                 7888   0  (unused)
> fscscy                  8368   0  (unused)
> fscpos                  6120   0  (unused)
> eeprom                  3476   0  (unused)
> ds1621                  4240   0  (unused)
> ddcmon                  3024   0  (unused)
> bt869                   5368   0  (unused)
> adm9240                 6024   0  (unused)
> adm1025                 5200   0  (unused)
> adm1024                 6592   0  (unused)
> adm1021                 5496   0  (unused)
> i2c-philips-par         2364   0  (unused)
> i2c-algo-bit            7432   0  [i2c-philips-par]
> i2c-dev                 4420   0  (unused)
> i2c-proc                7088   0  [lm78 lm75 it87 gl520sm gl518sm 
> fscscy fscpos eeprom ds1621 ddcmon bt869 adm9240 adm1025 adm1024 
> adm1021]
> i2c-core               15332   0  [i2c-isa i2c-algo-pcf lm78 lm75 it87
> 
> gl520sm gl518sm fscscy fscpos eeprom ds1621 ddcmon bt869 adm9240 
> adm1025 adm1024 adm1021 i2c-algo-bit i2c-dev i2c-proc]
> parport_pc             21672   1
> parport                23936   1  [i2c-philips-par lp parport_pc]

Definitely not the thing to do. You have to load only the module you
need, or the other modules will get in the way and you won't go
anywhere. You are supposed to run sensors-detect in order to know which
modules you need.

BTW, what's your problem exactly?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
