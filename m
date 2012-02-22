From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Feb 2012 04:15:40 +0000
Subject: Re: [lm-sensors] dual output buck controller pmbus based
Message-Id: <20120222041539.GA31696@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
In-Reply-To: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 01:20:25AM -0500, Vivek Bardia wrote:
> Hello,
>=20
> I want to know whether does the current pmbus driver support dual output =
buck
> controller based PMIC?
>=20
> Basically for this particular PMIC: http://goo.gl/BFwcu
>=20
> How do I test the driver for it?
>=20
Hi,

I got the evaluation board for TPS40422. Here is the output from the sensor=
s command
after instantiating it as "pmbus".

pmbus-i2c-0-1b
Adapter: i2c-diolan-u2c:002
vout1:        +1.20 V
vout2:        +3.30 V
temp1:        +26.0=B0C  (high =3D +100.0=B0C, crit =3D +125.0=B0C)
iout1:        +0.31 A  (max =3D +25.00 A, crit max =3D +30.00 A)
iout2:        +0.31 A  (max =3D +20.00 A, crit max =3D +25.00 A)

Similar, for TPS40400:

pmbus-i2c-0-1c
Adapter: i2c-diolan-u2c:002
vin:         +11.59 V
vout1:        +1.16 V  (crit min =3D  +1.14 V, crit max =3D  +1.26 V)
iout1:        +0.50 A  (max =3D +29.00 A, crit max =3D +30.00 A)

Overall pretty good for generic detection. Only problem (or, rather, limita=
tion)
with TPS40422 is that the auto-detection code does not support paged temper=
ature
registers, and thus only a single temperature is reported.

Did you have a chance to test it yourself ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
