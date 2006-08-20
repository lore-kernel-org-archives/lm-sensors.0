From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Sun, 20 Aug 2006 05:50:34 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <44E7F82A.6020807@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I've got one general question:

AFAICS the values measured by the sensor chips are pretty
far away from reality, as it seems. The mapping to real
temperatures, and voltages is done in the sensors tool
in user space.

But: Ain't this extremely hardware dependent? Looking at the
same sensor built into several different mainboards of different
manufacturers, I would guess that the range for the measured
temperatures or voltages can vary alot, depending upon some
external resistors, the position of the chip on the main
board, etc. Every second board needs its own sensors.conf,
does it?

Or is there some kind of standard, at least for the major
chips?


Regards

Harri


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060820/c730fca2/attachment.bin 
