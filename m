From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Jun 2005 09:32:56 +0000
Subject: [lm-sensors] LM77 temp sensor on national sc1100 (wrap board)
Message-Id: <2CLipYpo.1119511407.6426240.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B9D9B0.9020604@infovia.com.ar>
In-Reply-To: <42B9D9B0.9020604@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Beat,

Beat Meier wrote:
> What's the clue about the LM77 temp sensor?
> I've read the thread from 1. July 2004 and have downloaded version 2.9.1
> of lm_sensor which is from 20050412 and LM77 module is not there.

No surprise here, as Andreas Bali wrote a driver for Linux 2.6, while
kernel drivers in the lm_sensors package are for Linux 2.4.

> In "REQUESTED SENSOR CHIP DRIVERS - STATUS" in Initial Support it is
> nor in CVS nor in a version only in linux-2.6.8,

Correct.

> but the driver name is listed as lm77.

Linux 2.6 drivers have names too, unsurprisingly, and lm77 sounded like a
good name for a driver supporting the LM77 chip.

> Is there no linux-2.4.x support?

No, as clearly stated on our pages. There is no user-space support either.

> Where can I get this driver for linux-2.4.x?

You don't, as it doesn't exist. You are welcome to backport it though,
and add user-space support if you need it.

> I'm really confused.

There really is nothing to be confused. Andreas wrote as much of the LM77
support as he personally needed, and left the rest to anyone who would
need more than that. It's that easy.

--
Jean Delvare
