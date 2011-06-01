From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jun 2011 10:13:45 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add detection of MAX6642
Message-Id: <20110601121345.2bd91880@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 01 Jun 2011 10:02:25 +0200, Per Dal=E9n wrote:
> Hi,
>=20
> Here's the new patch for sensors-detect.
>=20
> Changed according to the suggestions from Jean Delvare:
>=20
> * Check the manufacturer ID directly. Fastens the test if it's not a
> Maxim chip.
> * Read the other non-existing registers after the manufacturer ID.
> * Read the other non-existing registers after the status.
> * Removed NO_CACHE from manufacturer ID, Status and Configuration registe=
rs.

Looks good, except that maybe I'd go for a confidence value of only 5,
not 6, due to the lack of proper device ID register.

Guenter, please apply.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
