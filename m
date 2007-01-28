From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 28 Jan 2007 19:27:13 +0000
Subject: [lm-sensors] VT1211 at 0x4e/0x4f
Message-Id: <20070128202713.a60b89a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

As almost all Super-I/O chips, the VT1211 can live at two different
address pairs, 0x2e/0x2f or 0x4e/0x4f. The vt1211 driver only supports
the former at the moment. Some systems use the latter though:
http://www.lm-sensors.org/ticket/2149

Could you please add support for the second address? It shouldn't be
too difficult, you can simply turn SIO_REG_{CIP,DIP} into global
variables and run vt1211_find() twice, once with each possible address
pair. The w83627hf, f71805f, pc87360 and pc87427 drivers do it that way
already.

Thanks,
-- 
Jean Delvare

