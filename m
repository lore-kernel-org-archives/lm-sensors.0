From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Date: Fri, 15 Jun 2007 08:37:41 +0000
Subject: Re: [lm-sensors] Possible support for the SMSC SCH5317? (found on
Message-Id: <46724FD5.2030802@onelan.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <46711ACE.3070809@onelan.co.uk>
In-Reply-To: <46711ACE.3070809@onelan.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Simon,
>=20
> If you feel adventurous, you can add device ID 0x85 to the smsc47b397
> driver which also supports the sch5037 chip. You'd have to modify it
> as follows:
>=20
> static int __init smsc47b397_find(unsigned short *addr)
> {
>        u8 id, rev;
>=20
>        superio_enter();
>        id =3D superio_inb(SUPERIO_REG_DEVID);
>=20
> -        if ((id !=3D 0x6f) && (id !=3D 0x81)) {
> +        if ((id !=3D 0x6f) && (id !=3D 0x81) && (id !=3D 0x85)) {
>                superio_exit();
>                return -ENODEV;
>        }
>=20
Did this, and the chip is found, but the numbers I get back look wrong:

dmesg output from the module:
smsc47b397: found SMSC LPC47B397-NC (base address 0x0480, revision 2)

sensors output:

# sensors
smsc47b397-isa-0480
Adapter: ISA adapter
temp1:       +44=B0C
temp2:       +53=B0C
temp3:       +26=B0C
temp4:      -128=B0C
fan1:     2011 RPM
fan2:       82 RPM
fan3:     1262 RPM
fan4:     1095 RPM

temp1 and temp2 both look likely for CPU, while temp3 might well be
system temperature. temp4 is completely out, and I'm not sure how I'd
relate the fan speeds to the fans in the system (I have a fan in the
front, a CPU fan, and a fan in the PSU.
--=20
Thanks for the help,

Simon Farnsworth


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
