From: Felipe Balbi <balbi@ti.com>
Date: Fri, 12 Aug 2011 08:44:55 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <20110812084454.GD19467@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4646526810389609007=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
 <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
 <20110811103658.GG27742@legolas.emea.dhcp.ti.com>
 <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
 <20110811141248.GK28500@legolas.emea.dhcp.ti.com>
 <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
 <20110811185408.GB15970@legolas.emea.dhcp.ti.com>
 <20110811185558.GC15970@legolas.emea.dhcp.ti.com>
 <4E444B8F.9060908@ti.com>
 <4E449D65.9000004@ti.com>
In-Reply-To: <4E449D65.9000004@ti.com>
To: Rajendra Nayak <rnayak@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, "J, KEERTHY" <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com


--===============4646526810389609007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 12, 2011 at 08:56:29AM +0530, Rajendra Nayak wrote:
> On 8/12/2011 3:07 AM, Roger Quadros wrote:
> >On 08/11/2011 01:55 PM, Felipe Balbi wrote:
> >>Hi,
> >>
> >>On Thu, Aug 11, 2011 at 09:54:09PM +0300, Felipe Balbi wrote:
> >>>>>you need some other way to handle this. Why do you need to manually =
set
> >>>>>the rate rather than having hwmod handle this for you ?
> >>>>>
> >>>>>your argument that "it's a one time setting" is not enough to have t=
his
> >>>>>in the driver. Drivers should not care about clocks anymore, this sh=
ould
> >>>>>have been done on another layer.
> >>>>
> >>>>Hwmod will have no idea on the rate required.
> >>>
> >>>does the rate need to change ? Also, I have not mentioned hwmod anytime
> >>
> >>i did mention hwmod, nevermind that part. Still I'm not sure where is
> >>the right place to handle this.
> >>
> >
> >Aren't the omap_device_pm_latency callbacks the right place to do it?
> >
> >e.g. in the following snippet from mach-omap2/temp_sensor_device.c
> >
> >+static struct omap_device_pm_latency omap_temp_sensor_latency[] =3D {
> >+	{
> >+	 .deactivate_func =3D omap_device_idle_hwmods,
> >+	 .activate_func =3D omap_device_enable_hwmods,
> >+	 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> >+	}
> >+};
> >
> >instead of directly pointing activate_func to omap_device_enable_hwmods,
> >it could point to a function that sets the required clock rate and then
> >enables the hwmod.
>=20
> FWIK, its a one time requirement to set the clock rate to the
> right rate the device can operate in based on what a platform
> supports. What you are suggesting would add the overhead of doing
> this every time the device is runtime enabled/idled.

if it's a one time setting, why don't you just change the clock fwk to
handle this nicely ? Maybe provide a different ->enable() function which
would already set the correct rate ?

Russell, what would be the best way here ? driver needs clock to be at a
particular rate for the device to work, but it's a one time setting and
I don't think driver should be doing clk_get() - clk_enable() -
clk_set_rate(), where should that functionality be put ?

--=20
balbi

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOROgGAAoJEAv8Txj19kN1CxsH/jhGlhj+CELQLG192iYSXEJj
7dvAmNfaGjKFqHpWxZYZV1vALRykKDgG/FyAknv4S49wm20xKgV8SzZskFg8HdvV
r4KakuYIikL4qinaZb1v7C/CAHq5JciIXwUrsu7lPR/bC0U25mFBX1mr3CnFWmaQ
1bLDE1XkvQ0E+YsIEAUP8dUpJftezrF69M7GkrIg8lAzW2NbqN+mZl8JlaWauWkV
Zyq+FMLwthnM5++tgFAvgshEDTe77DJJnX2QuWUbaafalmsvfwFzkc87rUtsV4Og
oK5DPpJDmwTeiQ0Yk0ebLjKt0uaK6eXWRt2IYlHcpw+n/pjKNQR4t6u7tjwqr0s=
=Mlqp
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--


--===============4646526810389609007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4646526810389609007==--
