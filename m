From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 07:32:53 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <20140213083253.79ca31c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi J=FCrgen,

On Thu, 13 Feb 2014 07:39:04 +0100, J=FCrgen Fuchsberger wrote:
> >> The board supports IPMI. I would guess that the errors happen when the
> >> native driver and IPMI attempt to access the SMBus at the same time.
> >
> > Yes, that would explanin the problem.
>=20
> >> As usual, my recommendation is to either use IPMI or native drivers but
> >> not mix.
> >
> > Agreed.
>
> OK, how can I choose which driver to use?

In your case, the native drivers are i2c-nforce2, dme1737 and lm85, and
the native tool is "sensors". The IPMI driver would be ipmi-si if I
remember correctly, and its tool is "ipmitool" or equivalent (there are
several IPMI packages out there, I don't know which ones are available
to you.) If you have a BMC card in the machine, that card would be
accessing the monitoring chips over IPMI as well so it will happen even
without any driver loaded.

If you want to use IPMI (and if you have a BMC this is the only safe
option), blacklist i2c-nforce2 and delete your lm_sensors configuration
file (typically /etc/sysconfig/lm_sensors on a sysconfig-based system,
might be different on your distributions, e.g. on Debian you'd just
delete the relevant modules from /etc/modules.) Then load ipmi-si and
use ipmitool or whatever IPMI tool you have installed.

If you don't have a BMC and want to use native access, uninstall every
package related to IPMI, make sure no service related to IPMI is
started, and if there are still ipmi modules listed in "lsmod" after
thatn blacklist them. I am not too familiar with IPMI so I can't tell
more, sorry.

Another note as far as native access is concerned: Tyan offers a
configuration file for your board:
ftp://ftp.tyan.com/software/lms/2932.sensors.conf

A few things caught my eye:
* They mention the SMSC SCH5017, not DME1737. This points us to this
  old support ticket:
  http://www.lm-sensors.org/ticket/2265
  Juerg, there was a question for you in that ticket, which was never
  answered.
* They surprisingly do not configure the chip at I2C address 0x2c,
  which is supposed to be the SMSC chip.
* They configure the chips at 0x2d and 0x2e as adm1027/lm85 but they
  are now detected as emc6d103, which we properly support. The
  configuration file would have to be adjusted to the proper chip names.

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
