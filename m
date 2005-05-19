From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [rootkit85@yahoo.it: gcc-4.0 compilation issue]
Message-Id: <20050324212602.GA8963@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

----- Forwarded message from Matteo Croce <rootkit85@yahoo.it> -----

From: Matteo Croce <rootkit85@yahoo.it>
Subject: gcc-4.0 compilation issue
Cc: Ky?sti M?lkki <kmalkki@cc.hut.fi>, Frodo Looijaard <frodol@dds.nl>,
	"Simon G.Vogl" <simon@tk.uni-linz.ac.at>
To: "Undisclosed.Recipients": ;
X-Virus-Scanned: ClamAV 0.83/782/Thu Mar 24 13:29:35 2005 on morannon.frodo=
.local
X-Virus-Scanned: amavisd-new isd-holland.nl
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on=20
	morannon.frodo.local
X-Spam-Status: No, score=3D-2.6 required=3D5.0 tests=BAYES_00 autolearn=3Dh=
am=20
	version=3D3.0.2
X-Spam-Level:=20

Hi,
i've made this trivial patch to make the linux kernel
i2c driver compile with gcc-4.0

Regards,
Matteo Croce

diff -urN linux-2.6.11.5/include/linux/i2c.h linux-2.6.11.5-vanilla/include=
/linux/i2c.h
--- linux-2.6.11.5/include/linux/i2c.h	2005-03-24 17:27:52.000000000 +0100
+++ linux-2.6.11.5-vanilla/include/linux/i2c.h	2005-03-19 07:34:52.00000000=
0 +0100
@@ -55,7 +55,7 @@
=20
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,int =
num);
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int=
 num);
=20
 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviu=
or.=20
@@ -194,7 +194,7 @@
 	   to NULL. If an adapter algorithm can do SMBus access, set=20
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs,=20
+	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[],=20
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,=20
 	                   unsigned short flags, char read_write,


----- End forwarded message -----

--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.
