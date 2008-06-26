From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jun 2008 15:44:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <20080626174403.3735218d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 26 Jun 2008 08:26:39 -0700, Juerg Haefliger wrote:
> > On Thu, 19 Jun 2008 16:20:34 -0700, Juerg Haefliger wrote:
> >> New driver to support temperature and voltage sensors embedded inside
> >> the VIA C7 CPU.
> >
> > Is it really an analog voltage sensor? Or does it simply reflect the
> > value of the VID pins? The conversion formula "(data->in << 4) + 700"
> > corresponds to VRM case 13 in hwmon-vid.c, which is what the C7 uses.
> > This makes me suspect that the latter is true. If I am right then the
> > attribute should be named cpuN_vid rather than in0_input.
> 
> The datasheet states that this register value is a copy of the MSR
> 0x198 value (performance status register). The bios writting guide
> labels 0x198 as 'current value'  whereas MSR 0x199 (performance
> control register) is labeled as 'desired value'. Unless I'm
> misinterpreting taiwanese english, I'd say it's a measured value :-)

Not necessarily. The CPU knows what voltage value it wants, and tells
that to the voltage regulation unit (through binary VID outputs). The
voltage regulation unit may allow the user to override the CPU voltage,
in either relative or absolute way. Then the voltage regulation unit
could export the actual VID value back to the CPU (through binary VID
inputs from the CPU's perspective.)

The best way to find out would be to check the CPU datasheet (if you
have it) to find out what pins are related to MSR 0x198. If the value
is obtained by analog-to-digital conversion of Vcore, you don't need
any dedicated pin on the CPU. If OTOH this is a feedback of the VID
value, then you should see 5 pins dedicated to VID input.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
