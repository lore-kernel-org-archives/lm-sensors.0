From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Mon, 08 Oct 2007 01:35:40 +0000
Subject: [lm-sensors] [ANNOUNCE] superiotool -- Detect Super I/Os,
Message-Id: <20071008013540.GB12533@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4594199615577478007=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============4594199615577478007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+DRhDX4TDhSuvTBU"
Content-Disposition: inline


--+DRhDX4TDhSuvTBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'd like to announce a tool called 'superiotool' which was developed by
a bunch of LinuxBIOS developers over at linuxbios.org:

  http://linuxbios.org/Superiotool

Superiotool is a user-space utility which can

 - detect which Super I/O chip is soldered onto your mainboard,

 - at which configuration port it's located (usually 0x2e or 0x4e), and

 - dump all register contents of the Super I/O chip, together with the
   default values as per datasheet (to make comparing the values easy).

Installation:

 $ svn co svn://linuxbios.org/repos/trunk/util/superiotool
 $ cd superiotool
 $ make
 $ sudo make install

It's written in C and licensed under the GPL (version 2 or later).

We're using it for LinuxBIOS development purposes (e.g. you need to
properly init the Super I/O for early serial output support), but I
guess this might be a useful tool for lm-sensors purposes, too.

Yes, we're aware of sensors-detect and we considered merging our
code into sensors-detect for a while, but decided to keep them two
different tools for now. Some reasons (or difference=D1=95 between the tool=
s):

 - superiotool is written in C, which allows (some) code copying into
   LinuxBIOS (which is also written in C).

 - superiotool _only_ supports and cares about Super I/Os, not other
   sensors, I2C, etc. etc. We don't intend to support anything other
   than Super I/Os in superiotool (hence the name :-) We don't need
   sensors et al in LinuxBIOS, that's mostly handled by the OS/userspace,
   e.g. lm-sensors.

 - The main difference to the sensors-detect Super I/O support is in the
   register dump feature, I guess. You can use 'superiotool -d' to get
   output like this:

     $ superiotool -d
     Found Winbond W83627EHF/EF/EHG/EG (id=3D0x88, rev=3D0x63) at 0x2e
     Register dump:
     idx 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f=20
     val 88 63 ff 00 44 00 00 ff 50 04 00 00 9a 21 00 ff=20
     def 88 MM ff 00 MM 00 MM RR 50 04 00 RR 00 21 00 00=20
     LDN 0x00 (Floppy)
     idx 30 60 61 70 74 f0 f1 f2 f4 f5=20
     val 00 03 f0 06 02 0e 00 ff 00 00=20
     def 01 03 f0 06 02 8e 00 ff 00 00=20
     LDN 0x01 (Parallel port)
     idx 30 60 61 70 74 f0=20
     val 00 03 78 00 04 3c=20
     def 01 03 78 07 04 3f=20
     LDN 0x02 (COM1)
     idx 30 60 61 70 f0=20
     val 00 03 f8 04 00=20
     def 01 03 f8 04 00=20
     LDN 0x03 (COM2)
     idx 30 60 61 70 f0 f1=20
     val 00 02 f8 03 00 00=20
     def 01 02 f8 03 00 00=20
     LDN 0x05 (Keyboard)
     idx 30 60 61 62 63 70 72 f0=20
     val 01 00 60 00 64 01 0c 83=20
     def 01 00 60 00 64 01 0c 83=20
     LDN 0x06 (Serial flash interface)
     idx 30 62 63=20
     val 00 ff ff=20
     def 00 00 00=20
     LDN 0x07 (GPIO 1, GPIO 6, game port, MIDI port)
     idx 30 60 61 62 63 70 f0 f1 f2 f3 f4 f5 f6 f7=20
     val 00 02 01 03 30 00 ff ff ff ff ff ff ff 00=20
     def 00 02 01 03 30 09 ff 00 00 00 ff 00 00 00=20
     LDN 0x08 (WDTO#, PLED)
     idx 30 f5 f6 f7=20
     val 00 ff 00 ff=20
     def 00 00 00 00=20
     LDN 0x09 (GPIO 2, GPIO 3, GPIO 4, GPIO 5, SUSLED)
     idx 30 e0 e1 e2 e3 e4 e5 f0 f1 f2 f3 f4 f5 f6 f7=20
     val 0f ff 21 00 ff 08 00 ff 0c 00 09 9f ff 00 00=20
     def 00 ff 00 00 ff 00 00 ff 00 00 00 ff 00 00 00=20
     LDN 0x0a (ACPI)
     idx 30 70 e0 e1 e2 e3 e4 e5 e6 e7 e8 f2 f3 f4 f6 f7=20
     val 01 00 00 00 ff 00 40 02 0c 10 09 7d 00 00 00 00=20
     def 00 00 01 00 ff 08 00 RR 00 00 RR 7c 00 00 00 00=20
     LDN 0x0b (Hardware monitor)
     idx 30 60 61 70 f0 f1=20
     val 01 02 90 00 c1 3f=20
     def 00 00 00 00 c1 00

  All numbers are in hex. idx is the register number, val is the current
  content of the register, def is the default value as per datasheet.

  I assume the dump feature might help with lm-sensors development, as
  you can easily dump the hardware monitor register contents (or have
  users send dumps) and compare values from different boards/chips etc.


We currently detect a number of chips which are not detected by
sensors-detect (and vice versa), I'll provide patches to sensors-detect
to keep the number of detected Super I/Os in sync between the tools.

This is open-source of course, so feel free to poke in the code and reuse
whatever parts of it you need or want. Contributions to supertiotool are
welcome, too, of course :)

We also try to collect a number of example register dumps for various
chips in the LinuxBIOS wiki for reference (any contributions are welcome
here, too; just run 'superiotool -dV' and send the output to the
LinuxBIOS mailing list, see http://linuxbios.org/Mailinglist).

The list of currently supported chips, as well as links to sample dumps,
is available here: http://linuxbios.org/Superiotool.


HTH, Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--+DRhDX4TDhSuvTBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCYlsXdVoV3jWIbQRAslmAKCXy4f3jlrwTfLp9w9ed5kQ6f8m8ACggs6a
srmPrWqvvNJVCqM5fv4XYks=
=QRUk
-----END PGP SIGNATURE-----

--+DRhDX4TDhSuvTBU--


--===============4594199615577478007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4594199615577478007==--
