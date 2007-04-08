From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Apr 2007 17:36:47 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <4619282F.1000807@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hans-J=FCrgen Koch wrote:
> Am Sonntag 08 April 2007 15:51 schrieb Hans de Goede:
>=20
>> The abituguru3 has a register which contains a motherboard ID. The curre=
nt
>> driver uses this ID, to look up info about the motherboard in a somewhat
>> lenght table in the driver.=20
>=20
> Can you elaborate your design decision a bit? My first idea would be to h=
ave
> a sysfs file that delivers that motherboard ID and then do the lookup in
> user space.
>=20

As I don't want the abituguru3 driver to create entries in sysfs for sensor=
s=20
which aren't there, and as without the table in the driver I cannot be sure=
=20
wether to create an in / temp / fan device for a given sensor address. Last=
 but=20
not least doing things this way allows me to always give a proper reading=20
without userspace needing to "guess" any further nescesarry calculations to=
 get=20
from the reading to an actual measurement.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
