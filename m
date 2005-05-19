From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH] i2c-amd8111 bug fix (compare i2c-nforce2 bug fix)
Message-Id: <20031201074237.024fbe8c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200311302339.11863.hfvogt@arcor.de>
In-Reply-To: <200311302339.11863.hfvogt@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> a similar bug for the send/receive byte SMBus transfer as in the
> i2c-nforce2 bus driver is also present in the i2c-amd8111 driver. The
> attached small patch corrects it. I have no board with AMD-8111 and
> therefore cannot test it, but the patch brings the AMD-8111 bus driver
> in line with the ACPI 2.0 spec chapter 13.9, to which is is compliant
> according to the AMD-8111 data sheet (AMD document #24674). Can
> anybody with an AMD-8000 chip set based mainboard confirm the fix?

Not sure any of us does. You could try sending your patch to Vojtech
Pavlik (vojtech at suse dot cz). Since he is the original driver author
and sent various patches for it since, I'd guess he has the hardware to
test it.

Thanks for the patch, will apply (unless Pavlik isn't happy with it).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
