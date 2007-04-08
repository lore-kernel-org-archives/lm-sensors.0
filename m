From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Sun, 08 Apr 2007 14:30:16 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <200704081630.17151.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Sonntag 08 April 2007 15:51 schrieb Hans de Goede:

>
> The abituguru3 has a register which contains a motherboard ID. The current
> driver uses this ID, to look up info about the motherboard in a somewhat
> lenght table in the driver. 

Can you elaborate your design decision a bit? My first idea would be to have
a sysfs file that delivers that motherboard ID and then do the lookup in
user space.

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
