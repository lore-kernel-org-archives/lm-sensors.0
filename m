From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 20 May 2012 19:21:00 +0000
Subject: Re: [lm-sensors] Fan control for Asus P8Z77
Message-Id: <20120520192100.GA19903@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAD=fgeLGr1H4-+mXO3W3+Gzr55qM8Wsy=bSgdeavQX0QzKSK+A@mail.gmail.com>
In-Reply-To: <CAD=fgeLGr1H4-+mXO3W3+Gzr55qM8Wsy=bSgdeavQX0QzKSK+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, May 20, 2012 at 01:19:46PM -0400, Andr=E9e 'Glaucous' wrote:
> Hi,
>=20
> The (somewhat) new Asus P8Z77 boards have arrived, I'm wondering how the =
status
> for fan control is for them?
> I have a Asus P8Z77-V Pro, tried both it87 and asus_atk0110, both result =
in
> that pwmconfig cannot find any controllable fans.
>=20
> Currently running libsensors version 3.3.2+SVN. I'm up for testing any pa=
tches
> related to this chipset.

Are you sure the board uses an IT87xx ? As far as I know, it uses NCT6779D.

For NCT6779D, you can find an experimental driver at https://github.com/gro=
eck/nct6775.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
