From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <20031119215656.74d70710.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > 5. Doing a 'modprobe i2c-piix4' generates the following kernel log
> > > messages:
> > >    i2c-core.o: i2c core module version 2.8.1 (20031005)
> > >    i2c-piix4.o version 2.8.1 (20031005)
> > >    Found ServerWorks OSB4 South Bridge device
> > >    dmi_scan.o version 2.8.1 (20031005)
> > >    dmi_scan.o: SM BIOS found
> > >    Worked around buggy BIOS (I2C)
> >
> > That last message looks interesting. I would edit i2c-piix4.c in
> > your 2.8.1 sources and disable that workaround. Could be that on
> > your system, the workaround does more harm than help. Or it might be
> > worse, I dunno;)
> 
> I disabled that workaround and everything works fine now. Thanks a
> lot! I am not sure if you would like to investigate this further. I
> assume you got better things to do :-)
> If you are interested in investigating this and I can provide any
> additional data, do not hesitate to contact me again, so I will do
> what I can to help improve lm_sensors.

That workaround was suggested by Tom Rini and the patch was applied in
August 2003. It was supposed to fix a problem on the Force CPCI-735.
After testing it on "normal" systems, we thought it was safe for
everyone, and applied the change. Looks like we were wrong.

Could it be that it is safe for Intel PIIX4 chips but *not* for
ServerWorks ones?

We obviously have to undo the fix somehow. Either we limit it to the
PIIX4 chips, or we disable it by default and it would be enabled by a
module parameter.

Tom, I'm quoting you:
"In this register, bit 0 is an enable, bits 1-3 assign the interrupt,
and bits 4-7 are reserved.  The only valid values for the interrupt are
000b(SMI#) and 100b (IRQ9).  All other values are reserved.  Thus bit 1
should never be set in the register."
I guess you got this information from Intel, and it might not apply to
ServerWorks', right?

Greg, I think I remember the fix was applied on your side as well, so it
will probably have to be modified there too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
