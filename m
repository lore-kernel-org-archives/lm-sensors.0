From: Holger Bocklet <holger.bocklet@arcor.de>
Date: Thu, 10 May 2007 15:39:33 +0000
Subject: [lm-sensors] Fintek F71882FG (MSI K9AGM2-FIH)
Message-Id: <200705101739.33746.holger.bocklet@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I tested the F71882FG-Driver (see this post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019649.html  ) 
on my MSI K9AGM2-FIH, which has a F71882FG, and is using
Hardware-monitoring (there is temp-related fan-control in bios).
The chip is recognized (vendor/chip-id), base-adress ist identified
(0x600), but all other readings of any register seem to deliver 0xFF only...

Maybe it is just a hardware issue, but the driver causes the kernel to
bug() If removed (modprobe -r).
I had no time to look further into that.
Regards,
Holger Bocklet

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
