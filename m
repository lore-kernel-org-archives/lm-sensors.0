From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 May 2012 01:08:26 +0000
Subject: Re: [lm-sensors] Fan control for Asus P8Z77
Message-Id: <20120521010826.GA20905@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAD=fgeLGr1H4-+mXO3W3+Gzr55qM8Wsy=bSgdeavQX0QzKSK+A@mail.gmail.com>
In-Reply-To: <CAD=fgeLGr1H4-+mXO3W3+Gzr55qM8Wsy=bSgdeavQX0QzKSK+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, May 20, 2012 at 04:30:27PM -0400, Andr=E9e 'Glaucous' wrote:
> Indeed, after an hour of searching around I actually found that experimen=
tal
> driver.
> I can confirm that it works very well!
>=20
Please don't top-post.

Looks like it is time to submit the driver for review so it can make it int=
o the kernel.

Guenter

> On 20 May 2012 21:21, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
>=20
>     On Sun, May 20, 2012 at 01:19:46PM -0400, Andr e 'Glaucous' wrote:
>     > Hi,
>     >
>     > The (somewhat) new Asus P8Z77 boards have arrived, I'm wondering ho=
w the
>     status
>     > for fan control is for them?
>     > I have a Asus P8Z77-V Pro, tried both it87 and asus_atk0110, both r=
esult
>     in
>     > that pwmconfig cannot find any controllable fans.
>     >
>     > Currently running libsensors version 3.3.2+SVN. I'm up for testing =
any
>     patches
>     > related to this chipset.
>=20
>     Are you sure the board uses an IT87xx ? As far as I know, it uses NCT=
6779D.
>=20
>     For NCT6779D, you can find an experimental driver at https://github.c=
om/
>     groeck/nct6775.
>=20
>     Thanks,
>     Guenter
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
