From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 query
Message-Id: <1081342891.4073fbab1def3@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040406215731.401d32c1.khali@linux-fr.org>
In-Reply-To: <20040406215731.401d32c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me directly]

According to Alexandre D ALTON:

> When in automatic mode, the ADM1030 chip automatically controls the
> fan speed depending on the CPU temperature.

Do you mean that no other parameter cen be set by the user (when in
automatic mode)?

This would be very different from the IT87 then. The IT87 "smart
guardian" mode lets you define several temperature/fan speed points (5
IIRC). You can think of them as the expression of conditions and
actions like: "If the temperature raises above 40?C, set fan speed to
80%" or "If the temperature raises above 50?C, set fan speed to 95%"
and so on. I don't think you can change the points through the BIOS
setup screen but they can be configured through the chipset's registers
and the Linux driver (2.4 only at the moment) allows that.

I would yet have to take a look at the other implementations (recent
Winbond chips have something similar) and see if we can draw a common
scheme.

> What I would like to implement is to set pwm1_enable to 2 by default
> meaning that the chip controls the fan. 0 would mean allways full
> speed and 1 to set the speed using the "pwm1" file.

That's one of the solution I had in mind, yes.

The only objection I would have is about the default. The correct
default would be (IMHO) not to change what was set by the BIOS. Same
goes for the rest of the initialization, BTW (i.e. don't break what the
BIOS did).

What does your BIOS setup screen offer WRT hardware monitoring?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
