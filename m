From: lllars with only one lll <lllars@gmail.com>
Date: Sat, 22 Oct 2011 02:22:30 +0000
Subject: [lm-sensors] support for ite it8518
Message-Id: <CAFCitk=iAdJX_vkWPazqrZ76mH1tfJtSUz0c6C-5fRGRjNAsTQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hello,

i have a fairly new laptop that uses the ITE it8518e chip to control
the cpu fan. =A0can anyone provide some advice on how to interface with
this chip?

i've tried probing all of its registers to see if any changes are
apparent with changes in fan speed, but to no avail.  i've also tried
to manually load the it87 module with the force_id parameter, but am
not sure what id to use.

kernel: 3.0
processor: i7 2630QM
laptop: sager np5160 / clevo w150hnq


relevant sensors-detect output:

Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 Y=
es
Found unknown chip with ID 0x8518
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No
Trying family `SMSC'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0              No
Trying family `VIA/Winbond/Nuvoton/Fintek'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 No
Trying family `ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0                   No

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
