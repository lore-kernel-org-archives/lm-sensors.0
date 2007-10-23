From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2007 21:01:36 +0000
Subject: Re: [lm-sensors] [patch 1/1] applesmc for Mac Pro 2 x Quad-Core
Message-Id: <20071023230136.456430ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071023120239.GD30546@jupiter.solarsys.private>
In-Reply-To: <20071023120239.GD30546@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 23 Oct 2007 08:02:39 -0400, Mark M. Hoffman wrote:
> > At least the 2x Quad-Core Apple Mac Pro appears to have some over-heat
> > protection which suddenly powers off the whole box under load.  This ad=
ds
> > support for the fans and temerature sensors in the Mac Pro - later some
> > "windwarm" a-like code should probably monitor the values.  For now
> > manually tweaking the fans prevents the sudden shutdown for me.
> >=20
> > cd /sys/devices/platform/applesmc.768
> > for x in fan{1,2,3,4}; do
> > 	echo 1 > ${x}_manual
> > 	echo 1285 > ${x}_output
> > done
>=20
> Ren=E9: there is a series of patches for the f75375s hwmon driver that al=
low fans
> to be initialized with platform data.  Although I haven't reviewed the se=
ries
> in detail yet, IMO the concept looks OK and it may be appropriate for the=
 Macs
> also.
>=20
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021597.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021598.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021599.html

I still need to be convinced why this has to be hard-coded in the
kernel when the same can be done, and fine-tuned, in user-space just
fine.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
