From: Roman Mamedov <roman@rm.pp.ru>
Date: Mon, 01 Mar 2010 12:48:12 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <20100301174812.1637661e@natsu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8865546141402879452=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
To: lm-sensors@vger.kernel.org

--===============8865546141402879452==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/9=oBHIwfnv8tr1cKkibD9Ev"; protocol="application/pgp-signature"

--Sig_/9=oBHIwfnv8tr1cKkibD9Ev
Content-Type: multipart/mixed; boundary="MP_/JwJw9h8BNOI=y.ma52jg.2O"

--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.

Thanks for the reply.

On Mon, 1 Mar 2010 11:35:48 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> * The contents of /proc/ioports
> * The output of "isadump -f 0x290 16"
> * The output of "dmidecode -t baseboard -t system"

Please see the attached text files.

> * The kernel log messages when cycling the i2c-i801 driver ("rmmod
>   i2c-i801 && modprobe i2c-i801" as root)

There are no messages in dmesg or syslog when removing and reloading this
driver in 2.6.30, but in 2.6.33 there are errors:

[  173.468108] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts wi=
th
ACPI region SM00 [0xe800-0xe806]
[  173.468125] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver

How can I solve this?

--=20
With respect,
Roman

--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=2.6.30-dmidecode-baseboard-system.txt

# dmidecode 2.9
SMBIOS 2.3 present.

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: System Manufacturer
	Product Name: System Name
	Version: System Version
	Serial Number: SYS-1234567890
	UUID: Not Settable
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: CUSL2
	Version: REV 1.xx
	Serial Number: xxxxxxxxxxx

Handle 0x002E, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected


--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=2.6.30-ioports.txt

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0073 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:1f.1
  0170-0177 : piix
01f0-01f7 : 0000:00:1f.1
  01f0-01f7 : piix
0376-0376 : 0000:00:1f.1
  0376-0376 : piix
03c0-03df : vga+
03f0-03f1 : pnp 00:03
03f6-03f6 : 0000:00:1f.1
  03f6-03f6 : piix
04d0-04d1 : pnp 00:03
0cf8-0cff : PCI conf1
b000-b01f : 0000:00:1f.4
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1f.2
  b400-b41f : uhci_hcd
b800-b80f : 0000:00:1f.1
  b800-b80f : piix
d000-dfff : PCI Bus 0000:01
  d800-d83f : 0000:01:0c.0
    d800-d83f : e1000
e400-e47f : 0000:00:1f.0
  e400-e47f : pnp 00:04
    e400-e403 : ACPI PM1a_EVT_BLK
    e404-e405 : ACPI PM1a_CNT_BLK
    e408-e40b : ACPI PM_TMR
    e428-e42b : ACPI GPE0_BLK
e800-e80f : 0000:00:1f.3
  e800-e80f : i801_smbus
ec00-ec3f : 0000:00:1f.0
  ec00-ec3f : pnp 00:04

--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=2.6.30-isadump.txt

# isadump -f 0x290 16
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x290 to 0x29f.
Continue? [Y/n] y
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0290: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=2.6.33-dmidecode-baseboard-system.txt

# dmidecode 2.9
SMBIOS 2.3 present.

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: System Manufacturer
	Product Name: System Name
	Version: System Version
	Serial Number: SYS-1234567890
	UUID: Not Settable
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: CUSL2
	Version: REV 1.xx
	Serial Number: xxxxxxxxxxx

Handle 0x002E, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected


--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=2.6.33-ioports.txt

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0073 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:1f.1
  0170-0177 : piix
01f0-01f7 : 0000:00:1f.1
  01f0-01f7 : piix
0376-0376 : 0000:00:1f.1
  0376-0376 : piix
03c0-03df : vga+
03f0-03f1 : pnp 00:03
03f6-03f6 : 0000:00:1f.1
  03f6-03f6 : piix
04d0-04d1 : pnp 00:03
0cf8-0cff : PCI conf1
b000-b01f : 0000:00:1f.4
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1f.2
  b400-b41f : uhci_hcd
b800-b80f : 0000:00:1f.1
  b800-b80f : piix
d000-dfff : PCI Bus 0000:01
  d800-d83f : 0000:01:0c.0
    d800-d83f : e1000
e400-e47f : 0000:00:1f.0
  e400-e47f : pnp 00:04
    e400-e403 : ACPI PM1a_EVT_BLK
    e404-e405 : ACPI PM1a_CNT_BLK
    e408-e40b : ACPI PM_TMR
    e428-e42b : ACPI GPE0_BLK
e800-e80f : 0000:00:1f.3
ec00-ec3f : 0000:00:1f.0
  ec00-ec3f : pnp 00:04

--MP_/JwJw9h8BNOI=y.ma52jg.2O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=2.6.33-isadump.txt

# isadump -f 0x290 16
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x290 to 0x29f.
Continue? [Y/n] y
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0290: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

--MP_/JwJw9h8BNOI=y.ma52jg.2O--

--Sig_/9=oBHIwfnv8tr1cKkibD9Ev
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuLt4wACgkQTLKSvz+PZwgB9ACfUE7HJKZuIZGotdgV05NeRlKf
+1oAn14YAfkeo5I+vAVcS63m1t1YsBPl
=/BiZ
-----END PGP SIGNATURE-----

--Sig_/9=oBHIwfnv8tr1cKkibD9Ev--


--===============8865546141402879452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8865546141402879452==--
