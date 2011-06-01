From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Jun 2011 16:21:06 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add detection of MAX6642
Message-Id: <1306945266.2163.1752.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 2011-06-01 at 06:13 -0400, Jean Delvare wrote:
> On Wed, 01 Jun 2011 10:02:25 +0200, Per Dal=C3=A9n wrote:
> > Hi,
> >=20
> > Here's the new patch for sensors-detect.
> >=20
> > Changed according to the suggestions from Jean Delvare:
> >=20
> > * Check the manufacturer ID directly. Fastens the test if it's not a
> > Maxim chip.
> > * Read the other non-existing registers after the manufacturer ID.
> > * Read the other non-existing registers after the status.
> > * Removed NO_CACHE from manufacturer ID, Status and Configuration regis=
ters.
>=20
> Looks good, except that maybe I'd go for a confidence value of only 5,
> not 6, due to the lack of proper device ID register.
>=20
> Guenter, please apply.
>=20
Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
