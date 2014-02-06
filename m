From: =?ISO-8859-1?Q?Rune_Kj=E6r_Svendsen?= <runesvend@gmail.com>
Date: Thu, 06 Feb 2014 02:02:00 +0000
Subject: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear list

I recently purchased an ASUS M5A97 EVO R2.0 motherboard, which has four fan
connectors on it: CPU_FAN, CHA_FAN1, CHA_FAN2 and CHA_FAN3.

I can only get the fan speeds of the first three of these fans, however,
which appear as fan1, fan2 and fan3 in /sys/devices/platform/it87.656

Is there any chance I might be able to get the speed of the last, CHA_FAN3,
fan?

I'm using fancontrol to control the fans, and this works wonderfully. The
BIOS can't handle it, but it works perfectly with fancontrol - completely
silent. The CPU is controlled by pwm1 and the chassis fans by pwm3, pwm2
seems to do nothing.

I'd really like to get a reading on the third fan. Any tips on where I can
go from here? I'm willing to do some hacking to get it to work.

Cheers! :)
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
