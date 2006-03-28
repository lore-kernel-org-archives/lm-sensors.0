From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Mar 2006 20:57:18 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring
Message-Id: <20060328225718.8629a1b1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603042101570.3972@Laila>
In-Reply-To: <Pine.LNX.4.63.0603042101570.3972@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut, Raphael,

> > Maybe something (BIOS?) is accessing the chip too, but if so I'd expect
> > other problems to show sooner or later. And I don't get the point
> > of changing these limits on the fly anyway.
> >
> > Hartmut, I guess you never observed anything like this on your own
> > system?
> 
> No, for me everything works like expected. If I set any limits, nobody 
> touches them, and they stay like I set them. If I reboot, the BIOS resets 
> limits for temp1 and temp2 to -128 .. +127 degC, but it doesn't seem to 
> bother setting limits for temp3 - those stay like I set them even
> through a reboot. A little bit  strange, because temp3 is what the BIOS 
> shows as "System temperature". It doesn't show any alarms though.
> I have a Gigabyte K8U board with ULi M1689 chipset. All voltages are 
> connected, except the +1.8V, which is in upper saturation. To be precise, 
> the voltages almost never change, so I cannot really be sure they're 
> connected, but they all show roughly their nominal value.

As I was just explaining to Raphael on IRC, my guess is that the BIOS
on his motherboard uses the temperature limits to get interrupt, and
change the fan speed depending on this. First time I see this, but
that's the only way his motherboard can implement automatic fan speed
control when the SMSC LPC47M192 chip doesn't offer this feature in
hardware. And the temperature limits match the settings in the BIOS
screen for the fan speed changes too.

This means that Raphael cannot use the temperature limits for himself,
but no big deal. Automatic fan speed control is great. And given that
the BIOS doesn't need to poll the register values, it shouldn't
interfere too much with the smsc47m192 driver either.

Thanks,
-- 
Jean Delvare

