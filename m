From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Fri, 18 Jan 2008 15:25:37 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <001401c859e6$61e58100$0204a8c0@IT>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > > > > > > > Trying family `SMSC'...
> Yes
> > > > > > > >
> > > > > > > > Found unknown chip with ID 0x8902
> > > > > > >
> > > > > > > This is indeed unknown. Can you check the markings on the chip
> so
> > > that
> > > > > > > we know what we're dealing with? From the product picture my
> guess
> > > is
> > > > > > > it's the chip in the QFP package close to the IDE connector.
> It
> > > should
> > > > > > > read something like SMSC xyz.
> > > > > >
> > > > > > There is chip marked SMSC SCH-5027D(not sure that D, might be
> 0)-NW
> > > > > >
> > > > > > According to spec which comes with MB it should be SMSC SC-5027D
> > > > >
> > > > > Can you run
> > > > > i2cdetect -y 0
> > > > >
> > > >
> > > >
> > > > Of course - here is output:
> > > >
> > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > > 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> > > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
> > > > 30: 30 31 32 33 -- -- -- -- -- -- -- -- -- -- -- --
> > > > 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> > > > 50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- --
> > > > 60: -- 61 -- 63 64 -- -- -- -- 69 -- -- -- -- -- --
> > > > 70: -- -- -- -- -- -- -- --
> > >
> > > OK, I figured it out, I believe :-) I received the datasheet for the
> > > SCH5027 from SMSC and after a quick glance at it, it looks like the
> > > hardware monitoring features of the DME1737, SCH5027 and EMC6D10x are
> > > identical but they advertise themselves differently. In your case, the
> > > chip is detected as a EMC6D10x and sensors-detect suggests the lm85
> > > driver. However, I believe the dme1737 driver is more appropriate. I
> > > will take a closer look at the various datasheets over the next couple
> > > of days to confirm my theory. In the meantime, you can try the
> > > following:
> > > 1) remove the lm85 driver (rmmod lm85)
> > > 2) force the dme1737 driver (modprobe dme1737 force=0,0x2e)
> > > 3) post the dme1737-related messages in /var/log/messages to the
> mailing
> > > list
> >
> > Here is output:
> >
> > Jan 18 16:09:12 farm dme1737 0-002e: Failed to query Super-IO for
> optional
> > features.
> 
> Ah yes, the dme1737 driver doesn't know anything about the SCH5027
> Super-IO so it can't determine if fans 5&6 and PWMs 5&6 are
> configured.
> 
> 
> > Jan 18 16:09:12 farm dme1737 0-002e: Optional features: pwm3=yes,
> pwm5=no,
> > pwm6=no, fan3=yes, fan4=yes, fan5=no, fan6=no.
> 
> If the BIOS shows 6 fans, fans 5&6 should become available once the
> driver is fixed to recognize the SCH5027.
> 
> 
> > Jan 18 16:09:12 farm i2c-adapter i2c-0: Found a DME1737 chip at 0x2e
> (rev
> > 0x00)
> >
> > >
> > > Note that the SCH5027 only supports 4 fans, so you won't see fan5&6.
> > > How many fans do you have in the machine? Can you see RPMs for all of
> > > them in the BIOS?
> 
> Correction: This is not true. The SCH5027 supports 6 fans, just like
> the dme1737.
> 
> 
> > I've 2 fans - CPU (fan1) and chassis (fan5). They are connected as
> Intel's
> > manual says.
> >
> > BIOS shows 6 fans - it shows some (reasonable) RPMs for fans1, 5 and
> zero
> > for rest (nothing attached there). BIOS is able to control RPMs itself,
> > depending on CPU, chassis and DIMM temperature sensors.
> 
> Again, I'll take a look at the datasheets and if the chips are indeed
> compatible, I'll fix the dme1737 driver to support the sch5027. I
> don't have access to a test machine until next week, so it has to wait
> until then.
> 

Just let me know if I can help with testing - I can't give access to my
S3000AH-based system but definitely can run some tests, etc.

All the best,
Andrew



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
