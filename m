From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Feb 2015 16:52:12 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
Message-Id: <20150220165212.GE22752@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On Fri, Feb 20, 2015 at 04:07:34PM +0100, C=E9dric Le Goater wrote:
> Hello !
>=20
> These patches rework the ibmpowernv driver to support the new device=20
> tree as proposed by this patchset on the skiboot mailing list :
>=20
>   https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html
>=20
> They are based on Linux 3.19 and were tested on IBM Power and Open Power =

> systems running trusty.
>=20
> The main issue is that the new device tree is incompatible with the=20
> previous ibmpowernv drivers. The consequence is no powernv sensors=20
> on systems with such a opal/linux configuration.
>=20
I don't think that would be acceptable. There must be lots of such
systems out there. Why does it have to be incompatible ?
Can't it support both the old and new versions ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
