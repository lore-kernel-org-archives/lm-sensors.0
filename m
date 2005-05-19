From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm78 ok on isa but not on i2c
Message-Id: <20031202225309.74d555b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As I was testing lm_sensors on my old Pentium 200 system, I noticed that
also sensors-detect sees my LM78 chip on both the i2c bus (at 0x2d) and
isa bus (at 0x290), the lm78 driver itself won't detect the chip on the
i2c bus (i2c-piix4 for that matter). It will only work if I load
i2c-isa.

Same behavior tested with CVS, 2.8.1, 2.7.0 and 2.6.1. Am I missing
something or does it need to be investigated and fixed?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
