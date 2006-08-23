From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 23 Aug 2006 06:18:42 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608222318i60b6010fm3a9a57d95c90ae20@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > > > +     case SHOW_SET_FAN_DIV:
> > > > +             data->fan_div[ix] = DIV_TO_REG(val);
> > > > +             vt1211_write8(data, VT1211_REG_FAN_DIV,
> > > > +                           ((data->fan_div[1] << 6) |
> > > > +                            (data->fan_div[0] << 4) |
> > > > +                             data->fan_ctl));
> > > > +             break;
> > >
> > > Not correct. You assume the data cache is in synch with register
> > > VT1211_REG_FAN_DIV, while it may not be (e.g. if this function is
> > > called before the update function ever is.) Please read the contents of
> > > VT1211_REG_FAN_DIV so that you are sure you won't change bits in that
> > > register.

Thinking about this some more I fail to see how the data cache can
ever be out of sync (assuming the update function gets called during
initialization). The only way for the registers to  change is through
a callback and the callbacks always update the cache as well. How can
they ever get out of sync?

...juerg

