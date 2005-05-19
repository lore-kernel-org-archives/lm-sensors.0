From: enrico_tux@yahoo.it (Cataldi Enrico)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: sensors on Acer TM427LC
Message-Id: <200312170127.30400.enrico_tux@yahoo.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi, i'm Enrico, from Italy...
I've an Acer TravelMate 427LC, my acpi can't get thermal state and=20
sensors-detect recognize just an eeprom... i contacted Acer, but they wont =

tell me sensors on my pc... they just told me that it implements acpi=20
v1.0b... I know, it's not much pleasuring... Well, i would like to know if =

there is a way to try to detect my sensors and write driver for them...

The chipset identification from Intel says it's a i845MP/MZ...

This is mi sensors:
Adapter: SMBus I801 adapter at 1840
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

This is my lspci...:
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge =

(rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (r=
ev=20
04)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio=20
Controller (rev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 =
LW=20
[Radeon Mobility 7500]
02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000=
=20
Controller (PHY/Link)
02:04.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM)=20
Ethernet Controller (rev 42)

Thanks for the attention, and if i hope to be helpfull....
- --=20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cataldi Enrico
Undergraduate student @ Computer Science
University of Bologna - Italy -
Homepage: http://ecataldi.web.cs.unibo.it/
mail to: enrico_tux@yahoo.it ecataldi@cs.unibo.it
My Public key is avaible on my home page.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP9+i8AigCNU6oAMgAQJFxw//YcHc+zO1OhnMD4EGXRUtUH3jIcFU4kL6
URsatdyXtAjQAUVR/9GVHhOlW9540iWKufyryhxaGGPRSOmb7vySj0nCCXDbWELQ
eVHFdv0PpyclK9vxjDxquPAEgfQ1E03D/eTn3l0iL20ZOykWttQCteuq3XjqSkb/
ZMf8g/GtfuhjyDPVqXEPuewA2N/NkhCMYVj0+AL+7aJnkfP2mdTT6HUzb68F8rCr
o3F48q901jqUAfUEqJJtW1+ryHe8rvYRpO/SfCyD2Os+O8W2hOwkIMZOQmglvAw4
kLQFen5az1Biam5J53PPZHspiGZ2ZWt33mGR2/CQIspMHZIbc/fIZjz6vgleJS7w
cNs1uMIo9Fw/kHpCXBU5hJmpOHXkfwiJRheMjvopHVLHJ/+/lqICBatuRjuTT1oV
pT6y1iiLlIh+F53ZkMD5RJ/ry1nzc9PW1yrxZXOrxqi9QTVEqmiQp6NOwrBPv4pl
iaW2Vp2ky3BCWQ7avdOqaJ3HYTnu8qtRBzSZfm55tKv4i5RR3rainviuvuEDxaMF
6nQ1z2sAmIfshH1Ltry2lJk36xHw3KRrF+oVpLW6KmKYT9SbIIt1S3RVRBnGDeyJ
+sFkiv0413x9OofCnHmdWATVSWwiIHEGg5sMeXZ6McoYZ2h2vfvcAa/7ceAJ9l5I
yqGvflzSkGg=BBJf
-----END PGP SIGNATURE-----

