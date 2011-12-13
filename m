From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Dec 2011 18:59:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f75375s) Added F75387SG/RG support
Message-Id: <20111213185940.GA23914@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2D36B16B-9487-4A4D-B4EB-60FA8766BFFB@bgerhart.de>
In-Reply-To: <2D36B16B-9487-4A4D-B4EB-60FA8766BFFB@bgerhart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Dec 13, 2011 at 01:19:58PM -0500, Bj=F6rn Gerhart wrote:
> Added support for Fintek F75387SG/RG.
>=20
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Signed-off-by: Bjoern Gerhart <oss@extracloud.de>
> ---
>=20
> Tested with kernel 2.6.39, but without fans so far.
>=20
> v2:
> - suitable ontop of the latest set of f75375s related patches
> - simplified name of a local char variable
>=20
> v3:
> - detected reason for corrupted patch, should be solved now
> - fixed F75387 fan handling: detect/select pwm_enable[0,1]=20
>=20
Yes, this time it worked.

There was one checkpatch warning (line too long) which I fixed myself.
Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
