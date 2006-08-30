From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 17:53:32 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 3] hwmon: new vt1211 driver
Message-Id: <20060830195332.c50f26ee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
In-Reply-To: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

> > Hmmm, so you permuted temp1, temp2 and temp3 compared to the Linux 2.4
> > driver. While I was OK with swapping temp1 and temp3 (in line with the
> > datasheet), I'm not as happy with changing temp2. It makes matching
> > with the datasheet harder.
> >
> > What are the benefits? Making ISTEMP() more simple, and getting rid of
> > TEMPIX_FROM/TO_REG()?
> 
> Oh yes! The mapping is screwed either way, just in different places.
> This way the code is simpler and easier to read.

Hmmm...

OK. We'll need to make some adjustments to user-space and possibly to
the 2.4 kernel driver, but we would have had to, anyway.

Will you be able to test the 2.4 kernel driver if we modify it?

> > > +     /* Read VID and set VRM */
> > > +     data->vid = vt1211_read8(data, VT1211_REG_VID) & 0x1f;
> >
> > Any reason why this is only read once, rather than updated on every
> > read?
> 
> That's a static value, isn't it? Why read it more than once?

No, it may not be static. Recent CPUs change voltages on the fly, so
the VID value could change as well. 

-- 
Jean Delvare

