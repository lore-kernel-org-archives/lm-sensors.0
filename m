From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Tue, 24 Jul 2007 08:26:46 +0000
Subject: Re: [lm-sensors] drivers/hwmon/lm93.c: array overruns
Message-Id: <200707241026.46814.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070723005453.GS26212@stusta.de> <200707230936.58135.hjk@linutronix.de> <20070724101020.0f1bf458@hyperion.delvare>
In-Reply-To: <20070724101020.0f1bf458@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Am Dienstag 24 Juli 2007 10:10 schrieb Jean Delvare:
> Hi Hans,
>=20
> On Mon, 23 Jul 2007 09:36:57 +0200, Hans-J=FCrgen Koch wrote:
> > Am Montag 23 Juli 2007 02:54 schrieb Adrian Bunk:
> > > The Coverity checker spotted the following array overruns
> > > in drivers/hwmon/lm93.c:
> > >=20
> > > <--  snip  -->
> > >=20
> > > ...
> > > struct lm93_data {
> > > ...
> > >         struct {
> > >                 u8 min;
> > >                 u8 max;
> > >         } temp_lim[3];
> > > ...
> > > };
> > > ...
> > > static void lm93_update_client_common(struct lm93_data *data,
> > >                                       struct i2c_client *client)
> > > {
> > > ...
> > >         for (i =3D 0; i < 4; i++) {
> > >                 data->temp_lim[i].min > > >                         l=
m93_read_byte(client, LM93_REG_TEMP_MIN(i));
> > >                 data->temp_lim[i].max > > >                         l=
m93_read_byte(client, LM93_REG_TEMP_MAX(i));
> > >         }
> > > ...
> > >=20
> > > <--  snip  -->
> >=20
> > This patch should fix it. Thanks a lot, Adrian!
> >=20
> > ----
> > This fixes an array overflow bug. We have 4 pairs of min/max temperatur=
e=20
> > limits, not 3.
> >=20
> > Signed-off-by: Hans J. Koch <hjk@linutronix.de>
> >=20
> > --
> > Index: linux-2.6.23-rc/drivers/hwmon/lm93.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > --- linux-2.6.23-rc.orig/drivers/hwmon/lm=
93.c	2007-07-23 09:22:56.000000000 +0200
> > +++ linux-2.6.23-rc/drivers/hwmon/lm93.c	2007-07-23 09:29:37.000000000 =
+0200
> > @@ -234,7 +234,7 @@
> >  	struct {
> >  		u8 min;
> >  		u8 max;
> > -	} temp_lim[3];
> > +	} temp_lim[4];
> > =20
> >  	/* vin1 - vin16: low and high limits */
> >  	struct {
>=20
> This will do as a quick fix, so:
>=20
> Acked-by: Jean Delvare <khali@linux-fr.org>
>=20
> However, I see that temp4 (which isn't a real temperature channel) is
> not exposed in sysfs. Reading and storing register values you never use
> doesn't seem particularly interesting, so something needs to be done
> here: either drop support for temp4 entirely, or expose the temp4
> values in sysfs.

I've got that on my TODO list. I'll soon work on that driver again. I'm sti=
ll
waiting for that #=A7$?& NDA-covered datasheet of the LM94. As soon as I've=
 got
that, I need to review all these values anyway because there might be subtle
differences between LM93 and LM94.
For the moment, I'd like to postpone the decision about what to do with tem=
p4.

Thanks anyway for pointing this out.

Hans
=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
