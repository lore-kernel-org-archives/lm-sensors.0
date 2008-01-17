From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Thu, 17 Jan 2008 16:54:40 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <000c01c85929$a84a4530$0204a8c0@IT>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > > > Trying family `SMSC'...                                     Yes
> > > >
> > > > Found unknown chip with ID 0x8902
> > >
> > > This is indeed unknown. Can you check the markings on the chip so that
> > > we know what we're dealing with? From the product picture my guess is
> > > it's the chip in the QFP package close to the IDE connector. It should
> > > read something like SMSC xyz.
> >
> > There is chip marked SMSC SCH-5027D(not sure that D, might be 0)-NW
> >
> > According to spec which comes with MB it should be SMSC SC-5027D
> 
> Can you run
> i2cdetect -y 0
> 


Of course - here is output:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
30: 30 31 32 33 -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- --
60: -- 61 -- 63 64 -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Thanks for your time,
Andrew



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
