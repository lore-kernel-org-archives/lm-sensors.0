From: Forest Bond <forest@alittletooquiet.net>
Date: Wed, 09 Dec 2009 15:32:25 +0000
Subject: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20091209153225.GA3947@alittletooquiet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5507902767544003854=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============5507902767544003854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline


--LyciRD1jyfeSSjG0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am seeing a situation where sensors-detect fails to find sensors in a sin=
gle
run due to an apparent race condition.  It looks like it loads the i2c-* mo=
dules
and then tries to open /dev/i2c-0 for probing, but it fails to open
successfully.  My sense is that the device is not fully initialize and read=
y for
opening immediately following the modprobe calls, but sensors-detect does n=
ot
wait for initialization to complete.  I'm not sure what should be happening=
=2E  It
seems sensible that modprobe would not return until the device is initializ=
ed.

Running sensors-detect again correctly probes the hardware because the i2c =
bus
is fully initialized at that point.

I don't know anything about i2c, so I hope the language I'm using to descri=
be
this situation is reasonable.

I've attached the output from sensors-detect for the first (failed) run and=
 the
second (successful) run.

Thoughts?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors-detect.log"
Content-Transfer-Encoding: quoted-printable

# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): Module loaded=
 successfully.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 2000 (i2c-0)
Do you want to scan it? (YES/no/selectively): Can't open /dev/i2c-0

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semi=
conductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O =
at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors'         Success!
    (address 0x680, driver `smsc47m1')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): Silicon Integrate=
d Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20
Driver `smsc47m1' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x680
    Chip `SMSC LPC47M15x/192/997 Super IO Fan Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:=20
To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
smsc47m1
#----cut here----

Do you want to add these lines automatically? (yes/NO)
--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sensors-detect2.log"
Content-Transfer-Encoding: quoted-printable

# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 2000 (i2c-0)
Do you want to scan it? (YES/no/selectively): Client found at address 0x2d
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85 or LM96000'...     No
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83783S'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L784R/AR/G'...                      No
Probing for `Winbond W83L785R/G'...                         No
Probing for `Genesys Logic GL518SM Revision 0x00'...        No
Probing for `Genesys Logic GL518SM Revision 0x80'...        No
Probing for `Genesys Logic GL520SM'...                      No
Probing for `Genesys Logic GL525SM'...                      No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Philips NE1619'...                             No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `VIA VT1211 (I2C)'...                           No
Probing for `ITE IT8712F'...                                No
Probing for `ALi M5879'...                                  No
Probing for `SMSC LPC47M15x/192/292/997'...                 Success!
    (confidence 6, driver `smsc47m192')
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Analog Devices ADM1024'...                     No
Probing for `Winbond W83791D'...                            No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semi=
conductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O =
at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors'         Success!
    (address 0x680, driver `smsc47m1')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): Silicon Integrate=
d Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20
Driver `smsc47m192' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c-i801', I2C address 0x2d
    Chip `SMSC LPC47M15x/192/292/997' (confidence: 6)

Driver `smsc47m1' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x680
    Chip `SMSC LPC47M15x/192/997 Super IO Fan Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:=20
To load everything that is needed, add this to /etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
smsc47m192
smsc47m1
#----cut here----

Do you want to add these lines automatically? (yes/NO)
--VS++wcV0S1rZb1Fb--

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLH8MJRO4fQQdv5AwRArYQAJ4/NnC5cMM8BgA9/0BCF0XTDBYvEQCg2Kne
VGepxmhLEeSA0kD4UFCrRiI=
=2R2I
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--


--===============5507902767544003854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5507902767544003854==--
