From: Christian Krafft <parabelboi@bopserverein.de>
Date: Fri, 16 May 2008 14:52:28 +0000
Subject: Re: [lm-sensors] bmcsensors error
Message-Id: <20080516165228.04fa68e3@bopserverein.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7415435685882119122=="
List-Id: <lm-sensors.vger.kernel.org>
References: <482d7a96.05a0660a.32e5.ffff92d6@mx.google.com>
In-Reply-To: <482d7a96.05a0660a.32e5.ffff92d6@mx.google.com>
To: lm-sensors@vger.kernel.org

--===============7415435685882119122==
Content-Type: multipart/signed; boundary="Sig_/pmNhO.6X5Sq0X2RHAVaPU37";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/pmNhO.6X5Sq0X2RHAVaPU37
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Angela,

On Fri, 16 May 2008 14:14:12 +0200
Angela Palladino <a.palladino@gmail.com> wrote:
=20
> Hi Yani,
>=20
> I have a Sun Netra 4200 and I need to get temperature using=20
> lm_sensors. I downloaded bmcsensors for my kernel (I'm using Red Hat=20
> Enterprise 4 Update 4 WS with kernel 2.6.9-42.ELsmp), I installed it=20
> and then I load the modules in this order: i2c-isa, ipmi_msghandler,=20
> ipmi_si, i2c_ipmi and bmcsensors.
>=20
> The output of dmesg is the following:
>=20
> ipmi message handler version 33.13
> IPMI System Interface driver version 33.13, KCS version 33.13, SMIC=20
> version 33.13, BT version 33.13
> ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca4,=20
> slave address 0x20
>   IPMI kcs interface initialized
> i2c-ipmi.o
> i2c-ipmi.o: Registered IPMI interface 0 with version 2.0
> i2c-ipmi.o: BMC access for i2c modules initialized.
> bmcsensors.o
> bmcsensors.o: Registered client, scanning for sensors...
> bmcsensors.o: Too many reservations cancelled, giving up
>=20
> and this the output of "sensors" command:
>=20
> bmc-i2c-1-00
> Adapter: IPMI adapter
>=20
> Have you any suggestion?

I guess i2c-ipmi should not be necessary. You probably don't want to read o=
ut
the i2c sensors by yourself. Let the BMC do this for you.
You should check, whether the BMC privides that information by using
"ipmitool sensors". ipmitool comes with openipmi package. It just needs ipm=
i_si
and ipmi_dev modules loaded.=20

Also a little clearification: bmcsensors does the same thing as ipmitool, it
reads out the sensors provided by the BMC (the bmc does the i2c communicati=
on
and provides the sensor data using ipmi). If you load i2c-ipmi you will get
access to a i2c-over-ipmi bridge. You can then read out the sensors by
yourself. But you will have to configure lmsensors to interpret the sensor =
data
correctly. As the BMC knows best what sensors are on the board you should l=
et
it speak to the sensors and read out the data using either ipmitool or
bmcsensors (then there is no need for i2c-ipmi).

First I would not let lmsensors interpret the sensor data, but the BMC.
Secondly I would prefer the userspace ipmitool over the bmcsensors kernel
module.

hope that helps,
Christian

>=20
> Thank you in advance,
>=20
> Angela
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294

--Sig_/pmNhO.6X5Sq0X2RHAVaPU37
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFILZ/CKGsoWZeX2LERAsx8AKCU7t8eNy7J+/hAwbZ1fS0Mqf0gUQCgjsO8
iaS7/o8ZGd+MqAe0BWWjxfY=
=pf7Q
-----END PGP SIGNATURE-----

--Sig_/pmNhO.6X5Sq0X2RHAVaPU37--


--===============7415435685882119122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7415435685882119122==--
