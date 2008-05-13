From: Lukasz Michalski <lm@zork.pl>
Date: Tue, 13 May 2008 21:30:15 +0000
Subject: [lm-sensors] FSC D-1501 motherboard
Message-Id: <482A0867.5080602@zork.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2446895724334381624=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2446895724334381624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DA014E45FDA99FC62349DF4"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DA014E45FDA99FC62349DF4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I have FSC-1501 motherboard and lm_sensors does not detect chip here.

How can I help to make it work? I have very little experience with=20
hardware monitoring.

My current findings are:
This motherboard have BMC with:
=E2=80=A2  Interrupt-Controller Chipset: Winbond W83910F and W24100S
=E2=80=A2  EEPROM 2 Mbyte (Winbond W39F010P)
(Source:=20
http://manuals.fujitsu-siemens.com/serverbooks/content/manuals/english/15=
01th-e.pdf)

Here is a link to datasheet of this chip:
http://www.datasheetcatalog.com/datasheets_pdf/W/8/3/9/W83910F.shtml

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Here is a log from latest sensors-detect from trunk:
[root@pldmachine /tmp]# perl "sensors-detect?format=3Dtxt"
# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks CSB6 South=20
Bridge

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus PIIX4 adapter at 0e80 (i2c-0)
Do you want to scan it? (YES/no/selectively):

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      Success!
     (confidence 4, driver `ipmisensors')
Probing for `IPMI BMC SMIC' at 0xca8...                     Success!
     (confidence 4, driver `ipmisensors')

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8741x Super IO'
     (no hardware monitoring capabilities)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0x4040

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `ipmisensors' (should be inserted):
   Detects correctly:
   * ISA bus, address 0xca0
     Chip `IPMI BMC KCS' (confidence: 4)
   * ISA bus, address 0xca8
     Chip `IPMI BMC SMIC' (confidence: 4)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
for initialization at boot time.
You should now start the lm_sensors service to load the required
kernel modules.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is on system:
[root@pldmachine /tmp]# uname -a
Linux pldmachine 2.6.22.19-5 #1 SMP Mon Mar 17 07:58:08 UTC 2008 i686=20
Intel(R)_Pentium(R)_4_CPU_2.00GHz PLD Linux

I don't have impisensors module for kernel 2.6.22. Is there any chance=20
that temperature & fans monitoring will work if I try to build this=20
module against this kernel?

Thanks,
--=20
Lukasz Michalski
pgp key: http://www.zork.pl/lm.asc


--------------enig8DA014E45FDA99FC62349DF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIKghnyp2aFTcdt5MRAgetAJ9tuM1q5o5udb6VunwQqo5RJA3+AwCfbLJp
Qj15FIjU1XavaOvB34fJUkI=
=vbB+
-----END PGP SIGNATURE-----

--------------enig8DA014E45FDA99FC62349DF4--


--===============2446895724334381624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2446895724334381624==--
