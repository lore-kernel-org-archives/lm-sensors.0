From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 28 Jan 2008 00:35:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix divide-by-0
Message-Id: <191fb4ca0801271635x24ca004fo21c4e7ecf4c743ab@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
In-Reply-To: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi jean,


On Jan 26, 2008 8:26 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Thu, 24 Jan 2008 09:11:25 -0800, Juerg Haefliger wrote:
> > This patch fixes a possible divide-by-0.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> >
> > Index: linux-2.6.24-rc8/drivers/hwmon/dme1737.c
> > =================================> > --- linux-2.6.24-rc8.orig/drivers/hwmon/dme1737.c     2008-01-24 09:04:24.000000000 -0800
> > +++ linux-2.6.24-rc8/drivers/hwmon/dme1737.c  2008-01-24 09:05:05.000000000 -0800
> > @@ -285,8 +285,8 @@
> >
> >  static inline int FAN_TO_REG(int val, int tpc)
> >  {
> > -     return SENSORS_LIMIT((tpc = 0) ? 90000 * 60 / val : val / tpc,
> > -                          0, 0xffff);
> > +     return (val <= 0) ? 0xffff : SENSORS_LIMIT((tpc = 0) ?
> > +             90000 * 60 / val : val / tpc, 0, 0xfffe);
> >  }
> >
> >  /* Fan TPC (tach pulse count)
>
> While I agree that it fixes the division by 0, and the fix looks OK in
> legacy mode, I am not sure that it is correct in TPC mode. While
> register value 0xffff corresponds to a stalled fan in legacy mode,
> that's not the case in TPC mode according to the datasheet. In TPC
> mode, a stalled fan leads to a register value of 0x0000. So I believe
> that the driver should write 0x0000, not 0xffff, to the register if the
> user sets the limit to 0 RPM in TPC mode. This would lead to the
> following code (untested):
>
>         if (tpc)
>                 return SENSORS_LIMIT(val / tpc, 0, 0xffff);
>         else
>                 return (val <= 0) ? 0xffff :
>                        SENSORS_LIMIT(90000 * 60 / val, 0, 0xfffe);
>
> What do you think?

Good catch, and this also applies for the conversion in the other direction.
Updated patch will follow...

...juerg


> (I wish manufacturers could come up with more simple chips...)
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
