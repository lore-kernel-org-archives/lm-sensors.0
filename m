From: juergh@gmail.com (Juerg Haefliger)
Date: Sat, 23 Sep 2006 03:31:22 +0000
Subject: [lm-sensors] [PATCH]: lm-sensors vt1211 updates
Message-Id: <191fb4ca0609222031n3c634c41s49ba26c1b15fd83d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
In-Reply-To: <191fb4ca0609220907w416fb35r3533de04d8ee0bd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > +/* temp1 (i = 1) is an intel thermal diode which is scaled in user space.
> > +   temp2 (i = 2) is the internal temp diode so it's scaled in the driver
> > +   according to some measurements taken on an EPIA M10000.
> > +   temp3-7 are thermistor based so the driver returns the voltage measured at
> > +   the pin (range 0V - 2.2V). */
> > +#define TEMP_FROM_REG(i, reg)        ((i) = 1 ? (reg) * 10 : \
> > +                              (i) = 2 ? (reg) < 51 ? 0 : \
> > +                              ((reg) - 51) * 10 : \
> > +                              ((253 - (reg)) * 220 + 1050) / 2100)
> > +/* for 10-bit temp values */
> > +#define TEMP_FROM_REG10(i, reg)      ((i) = 1 ? (reg) * 10 / 4 : \
> > +                              (i) = 2 ? (reg) < 204 ? 0 : \
> > +                              ((reg) - 204) * 10 / 4 : \
> > +                              ((1012 - (reg)) * 55 + 1050) / 2100)
> > +#define TEMP_TO_REG(i, val)  SENSORS_LIMIT( \
> > +                              ((i) = 1 ? ((val) + 5) / 10 : \
> > +                               (i) = 2 ? ((val) + 5) / 10 + 51 : \
> > +                               253 - ((val) * 2100 + 110) / 220), 0, 255)
>
> The problem is that the formulas for i >= 3 assume a magnitude of 3
> (LSB = 0.001 mV), while the driver (and libsensors) export a magnitude
> value of 1 (LSB = 0.1 degree C). I guess you didn't have the
> opportunity to test these inputs on your system? You need to change the
> magnitude value in vt1211_temp() (operation = SENSORS_PROC_REAL_INFO),
> and then in libsensors.

Not sure what you mean. I did notice that there is a factor 100
difference between the 2.4 and 2.6.

Actually, I did test i=3 and both the 2.4 and 2.6 driver return the
correct values such that the sensors output matched and were correct.
I only tested reading though, not writing. I was assuming that the
conversion for writing is just the inverse from reading.


> > -#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP2
> > +#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP3
> >  #define VT1211_ALARM_TEMP4 VT1211_ALARM_IN1
> >  #define VT1211_ALARM_TEMP5 VT1211_ALARM_IN2
> >  #define VT1211_ALARM_TEMP6 VT1211_ALARM_IN3
>
> I am surprised to see temp1 alarm unchanged... I take it that the
> original code was not correct? Not necessarily surprising given that
> temp1 and temp3 limit registers were swapped.

Yes, temp1 alarm was broken.


> I'm fine with the rest, so if you're OK I might as well fix the above
> by myself, no need to resend a patch.

Fine by me. I don't have time right now to fix it anyways, need to
pack for Hawaii :-)

...juerg


> --
> Jean Delvare
>

