From: Andreas Hartmann <andihartmann@01019freenet.de>
Date: Sat, 08 Sep 2012 19:15:21 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <504B9949.9090009@01019freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <504B7388.8020102@01019freenet.de>
In-Reply-To: <504B7388.8020102@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Clemens Ladisch wrote:
> Guenter Roeck wrote:
>> On Sat, Sep 08, 2012 at 06:34:16PM +0200, Andreas Hartmann wrote:
>>> I'm getting this temperature after more than one hour of activity
>>> (mostly idle, load of the machine is: 0,11, 0,17, 0,21):
>>>
>>> temp1:        +14.5=B0C  (high =3D +70.0=B0C)
>>>
>>> 14.5=B0C is completely impossible as the surrounding temperature is
>>>> 20=B0C.
>=20
> Documentation/hwmon/k10temp says:
> | There is one temperature measurement value, available as temp1_input in
> | sysfs. It is measured in degrees Celsius with a resolution of 1/8th deg=
ree.
> | Please note that it is defined as a relative value; to quote the AMD ma=
nual:
> |
> |   Tctl is the processor temperature control value, used by the platform=
 to
> |   control cooling systems. Tctl is a non-physical temperature on an
> |   arbitrary scale measured in degrees. It does _not_ represent an actual
> |   physical temperature like die or case temperature. Instead, it specif=
ies
> |   the processor temperature relative to the point at which the system m=
ust
> |   supply the maximum cooling for the processor's specified maximum case
> |   temperature and maximum thermal power dissipation.
>=20

I already read this, too.

My point of view is: If sensors says: "temp1: +14.5=B0C (high: +70=B0C)"
then it is a temperature of +14.5=B0C and nothing else. If this value
isn't a physical temperature (like the room temperature e.g.), why is it
called temperature if it isn't one?

However, if it is an instrument to manage a fan (or maybe a complete
cooling system), I most probably would use a percentaged value, which
reveals something about the actual required cooling capacity for the
individual system.
At least it would avoid misunderstanding IMHO.


jm2c,
thanks,
kind regards,
Andreas Hartmann

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
