From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 17:56:21 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <20060604195621.b5ae7692.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Sun, 04 Jun 2006, Hans de Goede wrote:
> > I think they are just seeing if it gives any "ticks" at all, so it won't
> > detect a 2 wire fan even if connected to one if its headers.
> 
> Two-wire fans can be detected just as well as three-wire ones, if you
> measure current draw :)  In fact, some chips (like the lm75) can actually
> COUNT ticks on two-wire fans by measuring spikes in the current draw...

Definitely not the LM75, as it is a temperature-only sensor chip. But I
remember reading datasheets mentioning tick count on 2-wires fans,
indeed. Strangely enough, some vendors are doing the opposite and
propose 4-wire fans, the idea being that tick counts tend to be lost
when fan speed control is in use on 3-wire fans.

> If you detect fan presence using ticks, you will never detect a stuck fan on
> startup, which is *dangerous* as it could cause the software inhibit an
> alarm on that fan.

Indeed - which is why I don't want us to emulate it in software.

-- 
Jean Delvare

