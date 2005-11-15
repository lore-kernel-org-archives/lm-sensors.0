From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 08:33:52 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051115081327.4b3437b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

Once again, sorry for the delay... :(

> > temp3 is a bit special, it is diode-based. The conversion which is
> > currently done in userspace should be moved into the driver, so that the
> > exported value is a temperature rather than a random register value.
> > Other temps are thermistor based, a part of the conversion has to be
> > moved into the driver so that we export the voltage value at the chip
> > pin. The thermistor bridge computation (voltag -> temperature) belongs
> > to userspace because different thermistors can be used on different
> > motherboards. The same is done for the PC87366 temp4-6 already.
> 
> We know what the datasheet and porting guide say about the temperatures, but
> I am not sure that this matches reality.  On my VIA EPIA 500 motherboard,
> the CPU is a VIA EPIA 5000 and not an Intel CPU.  I don't doubt that the
> sensor scale is correct for an Intel CPU, but the VIA EPIA CPU is different.
> If I use the scaling values in the porting guide then my temperatures are
> over 30C off.
> 
> For reference, 
> 	VIA's equation:  REG = TEMP * 0.9686 + 65
> 	My EPIA Mobo:    REG = TEMP * 0.7809 + 45

Good point. Do these constant have any kind of physical meaning? Is the
information publicly available? How did you come up with the correct
one for your VIA CPU?

What would the formula required for VIA CPUs look like if the Intel one
was integrated into the driver as I first proposed?

> We can put the VIA official Intel scaling into the driver, but this would be
> very misleading as the VT8231 is used on the VIA EPIA platform which is in
> widespread use, and all users of that board would therefore need to know
> that additional scaling was required.  If they didn't then they would be
> panicking when they see the CPU temperature (since the motherboard is only
> passively cooled).

Well, whatever we do, the VIA CPU users will have an incorrect reading
at first and will have to edit some lines in their configuration file
to get the proper reading. So this point doesn't really weight in
either direction. All it really means is that we will have to improve
the vt8231's sensors.conf.eg section to make the point clear.

Thanks,
-- 
Jean Delvare
