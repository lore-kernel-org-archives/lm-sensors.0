From: Clemens Ladisch <clemens@ladisch.de>
Date: Sat, 08 Sep 2012 16:53:25 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <504B7805.3030706@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <504B7388.8020102@01019freenet.de>
In-Reply-To: <504B7388.8020102@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter Roeck wrote:
> On Sat, Sep 08, 2012 at 06:34:16PM +0200, Andreas Hartmann wrote:
>> I'm getting this temperature after more than one hour of activity
>> (mostly idle, load of the machine is: 0,11, 0,17, 0,21):
>>
>> temp1:        +14.5=B0C  (high =3D +70.0=B0C)
>>
>> 14.5=B0C is completely impossible as the surrounding temperature is
>> > 20=B0C.

Documentation/hwmon/k10temp says:
| There is one temperature measurement value, available as temp1_input in
| sysfs. It is measured in degrees Celsius with a resolution of 1/8th degre=
e.
| Please note that it is defined as a relative value; to quote the AMD manu=
al:
|
|   Tctl is the processor temperature control value, used by the platform to
|   control cooling systems. Tctl is a non-physical temperature on an
|   arbitrary scale measured in degrees. It does _not_ represent an actual
|   physical temperature like die or case temperature. Instead, it specifies
|   the processor temperature relative to the point at which the system must
|   supply the maximum cooling for the processor's specified maximum case
|   temperature and maximum thermal power dissipation.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
