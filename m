From: Jelle de Jong <jelledejong@powercraft.nl>
Date: Fri, 11 Jun 2010 20:47:16 +0000
Subject: [lm-sensors] ITE IT8712F chipset support?
Message-Id: <4C12A0D4.80702@powercraft.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everybody,

I got a new motherboard with an ITE IT8712F and it seems there is no
driver support yet. I tested with the latest sensors-detect and
checked the 2.6.34 kernel code.

http://imagebin.ca/img/KOmZOy.jpg # picture chipset
http://debian.pastebin.com/zagTLbkx # dmidecode
http://debian.pastebin.com/P50Mf0Bv # latest sensors-detect

I want to use the driver to control fans with PWM. There are two four
pin fan connectors on the motherboard and the BIOS shows support for
PWM fans in silent standard turbo and manual mode.

I can't find a datasheet with the differences between 20f and 21f? If
somebody can add support for this chipset I would be very thankful.

I helped in the past with providing motherboard for developers. I can
provide remote SSH root access to the system if needed.

Thank in advance,

With kind regards,

Jelle de Jong
PowerCraft Technology
+31 (0)10 707 9913

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
