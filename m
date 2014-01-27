From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Jan 2014 23:46:52 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <20140127234652.GB18059@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jan 27, 2014 at 02:22:51PM -0800, John wrote:
> Thank you for the reply,=A0Guenter.
>=20
My pleasure.

> >>=20
> >>  Error: file hwmon1/device/pwm5 doesn't exist
> >>  Error: file hwmon1/device/pwm4 doesn't exist
> >>  Error: file hwmon1/device/pwm3 doesn't exist
> >>  Error: file hwmon1/device/pwm1 doesn't exist
> >>  Error: file hwmon1/device/fan5_input doesn't exist
> >>  Error: file hwmon1/device/fan4_input doesn't exist
> >>  Error: file hwmon1/device/fan3_input doesn't exist
> >>  Error: file hwmon1/device/fan1_input doesn't exist
> >>=20
> >=20
> > The above log refers to hwmon1/pwmX and hwmon1/fanX_input,
> > yet the errors refer to hwmon1/device/pwmX and
> > hwmon1/device/fanX_input. So there is an obvious mismatch.
> > How does the actual configuration file look like ?
>=20
> I deleted /etc/fancontrol* and rebuilt again under 3.13 (it is attached a=
fter I edited it). =A0It now works. =A0I am not sure what I did the first t=
ime through. =A0Sorry for the noise to the list.

No problem. Glad the issue is resolved.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
