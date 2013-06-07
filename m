From: "Marcus Roeckrath" <marcus.roeckrath@gmx.de>
Date: Fri, 07 Jun 2013 12:29:38 +0000
Subject: [lm-sensors] lsensors3.conf for ASRock K7VT2
Message-Id: <201306071429.42740.marcus@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

here is my sensors3.conf for ASRock K7VT2 Board, please add this to the=20
Motherboard Specific Configuration:

# Sample configuration for ASRock K7VT2

chip "w83697hf-*"
set beep_enable 0
label in0 "VCore"
label in2 "+3.3V"
label in3 "+5V"
label in4 "+12V"
label in5 "-12V"
label in6 "-5V"
label in7 "V5SB"
label in8 "VBat"
compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
compute in4 ((28/10)+1)*@ , @/((28/10)+1)
#compute in5 (5.14 * @) - 14.91 , (@ + 14.91) / 5.14
#compute in5 (3.14 * @) - 7.71 , (@ + 7.71) / 3.14
compute in5 -((28/10)+1)*@ , -@/((28/10)+1)
compute in6 -((6.8/10)+1)*@ , -@/((6.8/10)+1)
compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)
set in0_min 1.5 * 0.95
set in0_max 1.65 * 1.05
set in2_min 3.3 * 0.9
set in2_max 3.3 * 1.1
set in3_min 5 * 0.95
set in3_max 5 * 1.05
set in4_min 12 * 0.9
set in4_max 12 * 1.1
set in5_min -12 * 0.9
set in5_max -12 * 1.1
set in6_min -5 * 0.9
set in6_max -5 * 1.1
set in7_min 5 * 0.9
set in7_max 5 * 1.1
set in8_min 3.0 * 0.8
set in8_max 3.0 * 1.2
label temp1 "System Temp"
label temp2 "CPU Temp"
set temp1_max 50
set temp1_max_hyst 45
set temp2_max 52
set temp2_max_hyst 47
label fan1 "CPU Fan"
ignore fan2
set fan1_div 4
set fan1_min 2000

- --=20

Gru=DF Marcus

Marcus R=F6ckrath -- Vikarsbusch 8 -- D-48308 Senden -- Germany
Phone  : +49-2536-9944 -- Fax : +49-2536-9943
E-Mail : marcus.roeckrath@gmx.de
WWW    : http://home.foni.net/~marcusroeckrath/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQEVAwUBUbHSNgp4kFlTVf6VAQL0uwf/eAbf8ZSNoh/zKxG52En/Ko8WbEz2w5/1
A+Mw4aMNTZFysHH707QpX0D1u+guIfg1yN/ZuISP3SapIaYpjQc1UzvLXvijSFAy
QNacxL8r3GV11LNJYVsgELiYuDSUZxd+kY0Hsb5tUvfPybFP7AH4Q0jV3326cWYr
UvbQQCuwB5ILd5kGT2SBntzHmZNc90knHbDvFos5Nt0+bE+QANVWOWPfJXQwz30M
dgf4jp4dz/blMZPkpdxCyG/kNakmCx+U8W5EqzRQtGdAZeAbwaENdFWovXCet5IJ
g14cQF0lB5pfaDonlO6CT31+Ml2I/hURvYwhIWRkdVcYbRf+gqfCpw=3D=3D
=3DAdEu
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
