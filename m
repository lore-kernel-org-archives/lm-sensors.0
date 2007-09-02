From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 15:43:49 +0000
Subject: Re: [lm-sensors] Philips PCA9540 sensor not included ?
Message-Id: <20070902174349.209f7098@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <787924.25589.qm@web26515.mail.ukl.yahoo.com>
In-Reply-To: <787924.25589.qm@web26515.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

On Sat, 1 Sep 2007 08:54:16 +0000 (GMT), Alex wrote:
> My pc motherboard (DFI Infinity) is equipped with a PCA9540
> I2C device.
> I use Ubuntu 7.04 with original kernel 2.6.20
> 
> sensor-detect detects it but module is not present in kernel
> tree (in drivers/i2c/chips/ ) but there is a pca9539.c (useless).

The PCA9540 is not a sensor chip, it's an I2C bus multiplexer. It's
very difficult to detect, BTW, so it is entirely possible that
sensors-detect got it wrong. Do you have any reason to believe that you
really have a PCA9540 on your system?

> I've found this post
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015743.html
> that propose the code for pca954x .
> Just now I'm trying to recompile my kernel with this patch.
> 
> There is a chance that code for pca954x will be included in future ?

This is a question for the i2c list.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
