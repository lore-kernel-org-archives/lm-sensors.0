From: krzysztof.h1@wp.pl (Krzysztof Helt)
Date: Fri, 23 Feb 2007 07:16:28 +0000
Subject: [lm-sensors] [PATCH] THMC50/ADM1022 support for 2.6 kernel
Message-Id: <45de94cc79ae0@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for Texas Instruments THMC50 and its
clone Analog Devices ADM1022. It support temperature sensors and
fan control on the chip. The ADM1022 chip works only in 2 remote
 temperature sensors mode.

Signed-off-by: Krzysztof Helt <krzysztof.h1 at wp.pl>

---

The THMC50 driver is the same as the lmsensor driver with added
fan control and fix that enables the fan (the fan off signal is
always set in the original driver).

The ADM1022 driver works only with 2 remote sensors. Otherwise,
the fans are forced to full speed on the Compaq AP550. The
ADM1022 driver has no way currently to switch the ADM1022 sensor
into the THMC50 mode (with only 1 remote temperature sensor).  

I may extend functionality of this driver later (as time and kids
allow).

Regards,
Krzysztof
PS. This driver was diffed against 2.6.20 and do not apply
cleanly to 2.6.21-rc1. It applies correctly, but there are some
messages about line numbers.

----------------------------------------------------
Mistrzostwa Polski w ?lizgu Na Bele Czym 2007, 
tego jeszcze nie widzia?e? :) 
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd76.html&sid28
-------------- next part --------------
A non-text attachment was scrubbed...
Name: thmc50.patch
Type: text/x-patch
Size: 15606 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070223/5ca06dba/attachment-0001.bin 
