From: =?UTF-8?B?IlN0YW5pc8WCYXcgVC4gRmluZGVpc2VuIg==?=
Date: Thu, 11 Feb 2010 20:05:21 +0000
Subject: [lm-sensors] Asus K8U-X (Uli M1689)
Message-Id: <4B746301.5040402@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3559039774122001731=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3559039774122001731==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEBD9A9666A6247B1F554810C"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBD9A9666A6247B1F554810C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello

I have Asus K8U-X motherboard[1] and the newest Debian GNU/Linux.
The computer restarts spontaneously about once a day (but this is
not regular). Today it even turned off.

I've been testing my RAM with memtest86[2], but everything seems OK
with that.

I am trying to monitor the system with sensors. The output looks
strange:

----------------------------------------------------------------------
# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +29.0=C2=B0C

it8712-isa-0d00
Adapter: ISA adapter
VCore 1:     +1.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VCore 2:     +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
+3.3V:       +3.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+5V:         +5.05 V  (min =3D  +0.00 V, max =3D  +6.85 V)
+12V:       +12.67 V  (min =3D  +0.00 V, max =3D +16.32 V)
-12V:        +3.93 V  (min =3D -27.36 V, max =3D  +3.93 V)   ALARM
-5V:         +4.03 V  (min =3D -13.64 V, max =3D  +4.03 V)   ALARM
Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
VBat:        +3.23 V
fan1:        835 RPM  (min =3D    0 RPM, div =3D 8)
fan2:          0 RPM  (min =3D    0 RPM, div =3D 128)
fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
M/B Temp:    +30.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0C=
)  sensor =3D
transistor
CPU Temp:    +38.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0C=
)  sensor =3D
transistor
Temp3:      +128.0=C2=B0C  (low  =3D  -1.0=C2=B0C, high =3D +127.0=C2=B0C=
)  sensor =3D
disabled
cpu0_vid:   +1.550 V
----------------------------------------------------------------------

As you can see, the lines with "ALARM" are set exactly to max. And
they don't ever seem to change their values. Why?

This is sensors version:

----------------------------------------------------------------------
# sensors -v
sensors version 3.0.2 with libsensors version 3.0.2
----------------------------------------------------------------------

This is my hardware configuration:

----------------------------------------------------------------------
# lspci
00:00.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8
Single Chip]
00:01.0 PCI bridge: ALi Corporation AGP8X Controller
00:02.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
00:03.0 ISA bridge: ALi Corporation M1563 HyperTransport South
Bridge (rev 70)
00:03.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:04.0 Multimedia audio controller: ALi Corporation M5455 PCI
AC-Link Controller Audio Device (rev 20)
00:0d.0 Ethernet controller: ALi Corporation ULi 1689,1573
integrated ethernet. (rev 40)
00:0e.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
00:0e.1 Mass storage controller: ALi Corporation ULi 5289 SATA (rev 10)
00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:0f.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:0f.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:0f.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA
TNT2 Model 64/Model 64 Pro] (rev 15)
02:05.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
----------------------------------------------------------------------

This is sensors-detect result (I ran it before sensors, of course):

----------------------------------------------------------------------
# sensors-detect
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-ali15x3' for device 0000:00:03.1: Acer Labs 1533/1543
Use driver `i2c-ali1535' for device 0000:00:03.1: Acer Labs 1535
Use driver `i2c-ali1563' for device 0000:00:03.0: Acer Labs 1563

We will now try to load each adapter module in turn.
Module `i2c-ali15x3' already loaded.
Module `i2c-ali1535' already loaded.
Module `i2c-ali1563' already loaded.
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

Next adapter: SMBus ALi 1563 Adapter @ 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      Yes
Found `ITE IT8712F Super IO Sensors'                        Success!
    (address 0xd00, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus, address 0xd00
    Chip `ITE IT8712F Super IO Sensors' (confidence: 9)

Driver `k8temp' (should be inserted):
  Detects correctly:
  * Chip `AMD K8 thermal sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
it87
k8temp
#----cut here----

Do you want to add these lines automatically? (yes/NO)
----------------------------------------------------------------------

This is what I have in the configuration file[3] (this chip section
only):

----------------------------------------------------------------------
chip "it87-*" "it8712-*"

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in5 (7.67 * @) - 27.36  ,  (@ + 27.36) / 7.67
    compute in6 (4.33 * @) - 13.64  ,  (@ + 13.64) / 4.33
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    label temp1       "M/B Temp"
    label temp2       "CPU Temp"
    label temp3       "Temp3"
----------------------------------------------------------------------

So it looks that my sensors configuration file is wrong: the actual
values for "-12V" and "-5V" are very far from what is expected, and
the system is still up. Right? What should it be?

Where do min/max values for in1, in5, in6, in7 come from?
It looks as if those for in5, in6, in7 were defaulted from (raw
value) --> (real world value) expressions (with @=3D0).
Is in1_min just defaulted to 0?
Where do the max values come from?

What do you think is wrong with my system?

[1]: http://www.asus.com/product.aspx?P_ID=3D9A2K9jFcnqjqzAZr
[2]: http://packages.debian.org/stable/memtest86
[3]: /etc/sensors3.conf

STF

http://eisenbits.homelinux.net/~stf/
OpenPGP: DFD9 0146 3794 9CF6 17EA  D63F DBF5 8AA8 3B31 FE8A


--------------enigEBD9A9666A6247B1F554810C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkt0YwYACgkQ2/WKqDsx/oqtpwCgmL6ztL4EHv17f8Yu/KESXFBW
C5UAn2nRMyjhv/i9dB68il33ivMN02xv
=+LZB
-----END PGP SIGNATURE-----

--------------enigEBD9A9666A6247B1F554810C--


--===============3559039774122001731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3559039774122001731==--
