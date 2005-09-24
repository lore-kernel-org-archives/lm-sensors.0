From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 24 Sep 2005 06:59:27 +0000
Subject: [lm-sensors] [PATCH] website/protocol.html
Message-Id: <200509240453.AA01316@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

* Implementation of SW PEC for read_byte and read_byte_data is incomplete.
* There is no release of 2.6.6.=20

Index: protocol.html
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3DRCS file: /home/cvs/website/protocol.html,v
retrieving revision 1.7
diff -u -r1.7 protocol.html
--- protocol.html	17 May 2005 17:18:17 -0000	1.7
+++ protocol.html	24 Sep 2005 04:39:45 -0000
@@ -114,8 +114,7 @@
 <td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times"><font s=
ize=3D+0>x
 (2.6.4)</font></font></td>
=20
-<td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times"><font s=
ize=3D+0>x
-(2.6.4)</font></font></td>
+<td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times"><font s=
ize=3D+0>&nbsp;</font></font></td>
 </tr>
=20
 <tr>
@@ -156,8 +155,7 @@
 <td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times"><font s=
ize=3D+0>x
 (2.6.4)</font></font></td>
=20
-<td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times"><font s=
ize=3D+0>x
-(2.6.4)</font></font></td>
+<td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times"><font s=
ize=3D+0>&nbsp;</font></font></td>
 </tr>
=20
 <tr>
@@ -335,7 +333,7 @@
=20
 <td ALIGN=CENTER VALIGN=3DTOP><font face=3D"Times New Roman,Times">x</font=
></td>
=20
-<td ALIGN=CENTER><font face=3D"Times New Roman,Times">x (fixed in 2.6.6)</=
font></td>
+<td ALIGN=CENTER><font face=3D"Times New Roman,Times">x (fixed in 2.7.0)</=
font></td>
 </tr>
=20
 <tr>

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
