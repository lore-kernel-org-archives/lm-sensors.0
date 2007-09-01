From: Alex <ambroxa@yahoo.it>
Date: Sat, 01 Sep 2007 08:54:16 +0000
Subject: [lm-sensors] Philips PCA9540 sensor not included ?
Message-Id: <787924.25589.qm@web26515.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My pc motherboard (DFI Infinity) is equipped with a PCA9540 I2C device.
I use Ubuntu 7.04 with original kernel 2.6.20

sensor-detect detects it but module is not present in kernel tree (in drivers/i2c/chips/ ) but there is a pca9539.c (useless).

I've found this post http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015743.html that propose the code for pca954x .
Just now I'm trying to recompile my kernel with this patch.

There is a chance that code for pca954x will be included in future ?





      ___________________________________ 
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: http://it.docs.yahoo.com/nowyoucan.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
