From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Apr 2015 17:32:36 +0000
Subject: Re: [lm-sensors] [PATCH v5 0/4] hwmon: (ibmpowernv) add DTS support
Message-Id: <20150408173236.GB26109@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On Wed, Apr 08, 2015 at 07:19:46PM +0200, C=E9dric Le Goater wrote:
> Hello !
>=20
> These patches extend the ibmpowernv driver to support the new OPAL firmwa=
re=20
> which now exposes in its device tree the Digital Temperature Sensors of=20
> a P8 system.
>=20
> They are based on Linux 4.0.0-rc7 + the initial cleanup serie :
>=20
>      http://lists.lm-sensors.org/pipermail/lm-sensors/2015-March/043670.h=
tml
>=20
> and were tested on IBM Power and Open Power systems running Trusty.
>=20
Series applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
