From: adal1c@motorola.com (Alexandre D ALTON)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 query
Message-Id: <1081346627.26093.33.camel@marge>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040406215731.401d32c1.khali@linux-fr.org>
In-Reply-To: <20040406215731.401d32c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Could I be added to the mailing list ?

On Wed, 2004-04-07 at 15:01, Jean Delvare wrote:
> [Please reply to the list, not to me directly]
> 
> According to Alexandre D ALTON:
> 
> > When in automatic mode, the ADM1030 chip automatically controls the
> > fan speed depending on the CPU temperature.
> 
> Do you mean that no other parameter cen be set by the user (when in
> automatic mode)?

NO, I do not mean it...

> This would be very different from the IT87 then. The IT87 "smart
> guardian" mode lets you define several temperature/fan speed points (5
> IIRC). You can think of them as the expression of conditions and
> actions like: "If the temperature raises above 40?C, set fan speed to
> 80%" or "If the temperature raises above 50?C, set fan speed to 95%"
> and so on. I don't think you can change the points through the BIOS
> setup screen but they can be configured through the chipset's registers
> and the Linux driver (2.4 only at the moment) allows that.

ADM1030 has the same behavior, in auto mode, it adapts fan speed to
temp, and temp parameters that can be changed. But it's more like a
feedback linear loop, not step one.

> I would yet have to take a look at the other implementations (recent
> Winbond chips have something similar) and see if we can draw a common
> scheme.
> 
> > What I would like to implement is to set pwm1_enable to 2 by default
> > meaning that the chip controls the fan. 0 would mean allways full
> > speed and 1 to set the speed using the "pwm1" file.
> 
> That's one of the solution I had in mind, yes.

I'll go into that solution as a first step.

> The only objection I would have is about the default. The correct
> default would be (IMHO) not to change what was set by the BIOS. Same
> goes for the rest of the initialization, BTW (i.e. don't break what the
> BIOS did).

Ok, the default value will be taken from what the bios set. (from
reading the config registers.)
 
> What does your BIOS setup screen offer WRT hardware monitoring?
I'll give you that info when I'll get home, I'm at work righ now.

Alex.
