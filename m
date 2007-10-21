From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 21 Oct 2007 18:40:58 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071021184058.GA30539@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

> > Von: Jean Delvare <khali@linux-fr.org>
> > Gesendet: 17.10.07 23:32:28
> > 
> > This can only happen on a multi-master I2C bus, which is rather rare on
> > consumer PCs. Juergen, do you have detailed technical documentation
> > about your system? It would be interesting to find out what chip the
> > other master is talking to. If it's the DME1737 chip, this could lead
> > to problems.

* Juergen Bausa <Juergen.Bausa@web.de> [2007-10-20 21:28:02 +0200]:
> No. I dont have detailes information. Its an asus barebone.
> 
> Asus borads have a feature called 'ASUS Q-Fan Technology'. Its a BIOS-based controller for the 
> FAN/CPU-temperature. This is turned on in the bios. However, when booting linux, the script
> 'fancontrol' is started and then controls cpu-temperature. Maybe the Q-fan still tries to access
> the fan and this is the reason for the collision?

Unlikely.  I have several Asus boards... in all cases, "Q-fan" is merely their
rebranding of whatever automatic fan control is supported by the sensor chip.

I.e. the BIOS may allow you to set up some automatic fan control of the sensor
chip, but after initialization the BIOS has nothing more to do with it.

Of course it's *possible* that your board is different than all of mine and
that there is active BIOS control.  But again, *unlikely*.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
