From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: i850 && lm_sensors (solved)
Message-Id: <200307271851.18348.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307271655.39929.ondrej.cecak@centrum.cz>
In-Reply-To: <200307271655.39929.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne ne 27. ?ervence 2003 17:34 jste napsal(a):
> > > > i2cdump 0 0x44:
> > >
> > > I don't know what this one is. Your main device (see below) has no
> > > sub-address AFAICT. If you re-run the command some times later, are
> > > the values still the same?
> >
> > yes, it's same like yesterday.
>
> I suspect it to be some EEPROM. See the first line (the only one not
> being empty):
>
> 00: 00 00 0f 3f 00 00 02 00 50 00 00 00 00 00 00 00
>
> I noticed that (all hexa) 00+00+0f+3f+00+00+02+00P. So this is likely
> to be 8 data bytes and a 1-byte checksum. However, I don't know what
> these 8 bytes could mean. Is your system specific in any way?

I don't know, p4@2,4; intel D850EMV2; 512 RIMM; original BIOS. Maybe plushy 
Tux on monitor ;-)

> Only one user so far was seen with something at this address. I
> contacted him, I'll let you know if I find anything.

OK, thanks ...

> > good job, if I use new sensors-detect it write:
> >
> > Probing for `Philips NE1619'... Success!
> >     (confidence 8, driver `adm1025')
>
> Great.
>
> > and after force load adm1025 is output of sensors like this:
> >
> > adm1025-i2c-0-2d
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Non-I2C SMBus adapter
> > +2.5V:     +2.48 V  (min =  +2.22 V, max =  +2.72 V)
> > VCCP:      +1.46 V  (min =  +2.00 V, max =  +2.44 V)   ALARM
> > +3.3V:     +3.33 V  (min =  +2.93 V, max =  +3.59 V)
> > +5V:       +5.02 V  (min =  +4.45 V, max =  +5.44 V)
> > +12V:      +0.06 V  (min = +10.68 V, max = +13.06 V)   ALARM
> > VCC:       +3.26 V  (min =  +2.93 V, max =  +3.59 V)
> > SYS Temp:  +40.0?C  (min =   +0?C, max =  +60?C)
> > CPU Temp:  +41.0?C  (min =   +0?C, max =  +60?C)
> > vid:       +1.35 V
> >
> > so, my problem look like solved ...
>
> Not bad, but it's not perfect yet. VCCP is bad (I don't know what it is)
> and +12V is very bad too. The temperatures look correct.

I know, what I "needed" was CPU temperature. 
Temperatures are really correct, memory (+2.5), +3.3V, +5.5V too.

IMHO VCCP looks like "CPU Core (+1.5 V)" from intel Active Monitor

Nominal Value       1,500
Current Value       1,447
Upper Threshold     2,300
Lower Threshold     0,700.

value "+12V" isn't in Active Monitor, maybe simply isn't(?) on my chip.

> I'll take a look at the driver. It hasn't been written by our team and
> wasn't heavily tested AFAIK, so maybe there are some bugs to be fixed.
>
> The other possibility is that there are slight differences between the
> original ADM1025 and the NE1619. After a quick look I thought it was
> similar, but I didn't look in deep enough to tell it for sure. So I'll
> verify this too.

> I'll let you know how it goes.

once again: thank you ;-)
-- 
Ondrej Cecak

