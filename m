From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Apr 2015 19:22:12 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Message-Id: <20150407192212.GA6446@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
 <20150407164439.GA4514@roeck-us.net> <55241C02.60103@fr.ibm.com>
In-Reply-To: <55241C02.60103@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

Hi Cedric,

On Tue, Apr 07, 2015 at 08:03:46PM +0200, Cedric Le Goater wrote:
>=20
> on a P7  :
>=20
> 	# ppc64_cpu --info
> 	Core   0:    0*    1*    2*    3*=20
> 	Core   1:    4*    5*    6*    7*=20
> 	Core   2:    8*    9*   10*   11*=20
> 	Core   3:   12*   13*   14*   15*=20
> 	Core   4:   16*   17*   18*   19*=20
> 	Core   5:   20*   21*   22*   23*=20
>=20
How would the 'sensors' output look like on that system ?
Wouldn't it be something like the following ?

 	Core 0-7:    +29.0=B0C =20
 	Core 4-11:   +29.0=B0C =20

>=20
> > Also, how do you know that the range of CPU IDs is always 8 ?
>=20
> This is a shortcut. The code is for the ibmpowernv platform and assumes=20
> that we are running on a P8 (8 hardware threads). It would be better to=20
> use a "maximum threads per core" variable but I am not sure this is=20
> available, as it is a tunable. I will look into it.
>=20
Tunable how ? The core code must have some means to detect this number
when it initialized CPU entries, or am I missing something ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
