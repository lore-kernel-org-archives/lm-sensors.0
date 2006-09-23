From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 08:59:49 +0000
Subject: [lm-sensors] [PATCH]: lm-sensors vt1211 updates
Message-Id: <20060923105949.b4be7978.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
In-Reply-To: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

> > > +/* temp1 (i = 1) is an intel thermal diode which is scaled in user space.
> > > +   temp2 (i = 2) is the internal temp diode so it's scaled in the driver
> > > +   according to some measurements taken on an EPIA M10000.
> > > +   temp3-7 are thermistor based so the driver returns the voltage measured at
> > > +   the pin (range 0V - 2.2V). */
> > > +#define TEMP_FROM_REG(i, reg)        ((i) = 1 ? (reg) * 10 : \
> > > +                              (i) = 2 ? (reg) < 51 ? 0 : \
> > > +                              ((reg) - 51) * 10 : \
> > > +                              ((253 - (reg)) * 220 + 1050) / 2100)
> > > +/* for 10-bit temp values */
> > > +#define TEMP_FROM_REG10(i, reg)      ((i) = 1 ? (reg) * 10 / 4 : \
> > > +                              (i) = 2 ? (reg) < 204 ? 0 : \
> > > +                              ((reg) - 204) * 10 / 4 : \
> > > +                              ((1012 - (reg)) * 55 + 1050) / 2100)
> > > +#define TEMP_TO_REG(i, val)  SENSORS_LIMIT( \
> > > +                              ((i) = 1 ? ((val) + 5) / 10 : \
> > > +                               (i) = 2 ? ((val) + 5) / 10 + 51 : \
> > > +                               253 - ((val) * 2100 + 110) / 220), 0, 255)
> >
> > The problem is that the formulas for i >= 3 assume a magnitude of 3
> > (LSB = 0.001 mV), while the driver (and libsensors) export a magnitude
> > value of 1 (LSB = 0.1 degree C). I guess you didn't have the
> > opportunity to test these inputs on your system? You need to change the
> > magnitude value in vt1211_temp() (operation = SENSORS_PROC_REAL_INFO),
> > and then in libsensors.
> 
> Not sure what you mean. I did notice that there is a factor 100
> difference between the 2.4 and 2.6.

Indeed, due to the magnitude difference (10 ^ (3 - 1) = 100).

> Actually, I did test i=3 and both the 2.4 and 2.6 driver return the
> correct values such that the sensors output matched and were correct.
> I only tested reading though, not writing. I was assuming that the
> conversion for writing is just the inverse from reading.

My bad, I misread the formulas... OK, they generate the right number.
However, exporting the voltages with just one decimal place (magnitude
= 1) means that we have a very bad resolution in userspace (6 degrees C
around 40 degrees C) so that's hardly useful. We need at least two
decimal places (that's what the vt8231 driver does), and if we are
going to change the magnitude convention, let's go for 3 directly to
limit the accuracy loss due to rounding.

> Fine by me. I don't have time right now to fix it anyways, need to
> pack for Hawaii :-)

OK, have a nice trip! I'll try to fix the remaining issues myself and
hopefully everything will be OK in 2.10.1.

-- 
Jean Delvare

