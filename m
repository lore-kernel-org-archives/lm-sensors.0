From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Support for DDR2 DRAM??
Message-Id: <Pine.LNX.4.58.0411012228080.18762@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
In-Reply-To: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hello,

I lost half hour when I treated 17 as 0x17 ...

Patch is here:

http://www.assembler.cz/download/sensors_ddr2

Sample SPD DDR2 Rom and specs:
http://www.infineon.com/cgi/ecrm.dll/ecrm/scripts/public_download.jsp?oid=
=89099&parent_oidQ869

Inline patch is here:
diff -Naur lm_sensors-2.8.8/prog/sensors/chips.c lm_sensors-2.8.8new/prog/s=
ensors/chips.c
--- lm_sensors-2.8.8/prog/sensors/chips.c	2004-09-19 19:09:59.000000000 +02=
00
+++ lm_sensors-2.8.8new/prog/sensors/chips.c	2004-11-01 22:25:31.000000000 =
+0100
@@ -2860,6 +2860,10 @@
 					print_label(label, 24);
 					printf("DDR SDRAM DIMM\n");
 					break;
+				case 8:
+					print_label(label, 24);
+					printf("DDR2 SDRAM DIMM\n");
+					break;
 				case 17:
 					print_label(label, 24);
 					printf("RAMBUS RIMM\n");
@@ -2915,6 +2919,9 @@
 		} else if (type =3D 1) { /* DRDRAM */
 			i =3D (((int) b) & 0x0f) + (((int) b) >> 4) + (((int) c) & 0x07) - 13;
 			k =3D 1;
+		} else if (type =3D 8) { /* DDR2 */
+			i =3D (((int) a) & 0x0f)  + (((int) b) & 0x0f) - 17;
+			k =3D ((((int) c) & 0x7) + 1) * ((int) d);
 		} else { /* SDRAM */
 			i =3D (((int) a) & 0x0f) + (((int) b) & 0x0f) - 17;
 			if (((int) c) <=3D 8 && ((int) d) <=3D 8)

> Rudolf,
>     Any chance you might have time to look at this??  I'd be happy to
> test any patches...

Now you can. Thank you

regards

Rudolf
