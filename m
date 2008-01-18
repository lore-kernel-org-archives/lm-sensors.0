From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 18 Jan 2008 12:49:37 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <191fb4ca0801180449w5b7ee806i4a69049871fbc47a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,


On Jan 17, 2008 5:54 PM, Andrew Voznytsa <andrew.voznytsa@gmail.com> wrote:
> Hi Juerg,
>
> > > > > Trying family `SMSC'...                                     Yes
> > > > >
> > > > > Found unknown chip with ID 0x8902
> > > >
> > > > This is indeed unknown. Can you check the markings on the chip so that
> > > > we know what we're dealing with? From the product picture my guess is
> > > > it's the chip in the QFP package close to the IDE connector. It should
> > > > read something like SMSC xyz.
> > >
> > > There is chip marked SMSC SCH-5027D(not sure that D, might be 0)-NW
> > >
> > > According to spec which comes with MB it should be SMSC SC-5027D
> >
> > Can you run
> > i2cdetect -y 0
> >
>
>
> Of course - here is output:
>
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
> 30: 30 31 32 33 -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- 61 -- 63 64 -- -- -- -- 69 -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --

OK, I figured it out, I believe :-) I received the datasheet for the
SCH5027 from SMSC and after a quick glance at it, it looks like the
hardware monitoring features of the DME1737, SCH5027 and EMC6D10x are
identical but they advertise themselves differently. In your case, the
chip is detected as a EMC6D10x and sensors-detect suggests the lm85
driver. However, I believe the dme1737 driver is more appropriate. I
will take a closer look at the various datasheets over the next couple
of days to confirm my theory. In the meantime, you can try the
following:
1) remove the lm85 driver (rmmod lm85)
2) force the dme1737 driver (modprobe dme1737 force=0,0x2e)
3) post the dme1737-related messages in /var/log/messages to the mailing list

Note that the SCH5027 only supports 4 fans, so you won't see fan5&6.
How many fans do you have in the machine? Can you see RPMs for all of
them in the BIOS?

...juerg



> Thanks for your time,
> Andrew
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
