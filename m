From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [TRIVIAL PATCH 2.5.67] fix compilation error for various i2c-devices
Message-Id: <200304091417.h39EHQWq001134@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Thomas Schlichter -----

Received: from localhost (frodo@localhost [127.0.0.1])
	by morannon.frodo.local (8.12.3/8.12.3/Debian-6.3) with ESMTP id h39De4i0012905
	for <frodo@localhost>; Wed, 9 Apr 2003 15:40:05 +0200
Received: from pop3.dds.nl [213.204.195.153]
	by localhost with POP3 (fetchmail-5.9.11)
	for frodo@localhost (single-drop); Wed, 09 Apr 2003 15:40:05 +0200 (CEST)
Received: (qmail-ldap/ctrl 29278 invoked from network); 9 Apr 2003 13:26:08 -0000
Received: from unknown (HELO rumms.uni-mannheim.de) ([134.155.50.52]) (envelope-sender <schlicht@uni-mannheim.de>)
	         by dds.vsp.scarlet-internet.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 9 Apr 2003 13:26:08 -0000
Received: from bigboss.workgroup (pD9E4A9C6.dip.t-dialin.net [217.228.169.198])
	(authenticated bits=0)
	by rumms.uni-mannheim.de (8.12.9/8.12.9) with ESMTP id h39DPwnA009510;
	Wed, 9 Apr 2003 15:26:09 +0200 (MEST)
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: simon@tk.uni-linz.ac.at, frodol@dds.nl
Subject: [TRIVIAL PATCH 2.5.67] fix compilation error for various i2c-devices
Date: Wed, 9 Apr 2003 15:00:50 +0200
User-Agent: KMail/1.5
cc: linux-i2c@pelican.tk.uni-linz.ac.at, trivial@rustcorp.com.au
Message-ID: <200304091500.51031.schlicht@uni-mannheim.de>
X-Loop-Procmail: PreventLoop
Return-Path: <schlicht@uni-mannheim.de>

-- Start of PGP signed section.
Content-Description: body text

[ Charset ISO-8859-15 unsupported, converting... ]
Changed the i2c_adapter name definition to match the current interface.

   Thomas

[ text/x-diff is unsupported, treating like TEXT/PLAIN ]

[ Charset ISO-8859-15 unsupported, converting... ]
diff -ur linux-2.5.66/drivers/i2c/i2c-adap-ite.c linux-2.5.66-bk3/drivers/i2c/i2c-adap-ite.c
--- linux-2.5.66/drivers/i2c/i2c-adap-ite.c	Mon Mar 24 23:00:09 2003
+++ linux-2.5.66-bk3/drivers/i2c/i2c-adap-ite.c	Thu Mar 27 19:57:24 2003
@@ -196,9 +196,11 @@
 
 static struct i2c_adapter iic_ite_ops = {
 	.owner		= THIS_MODULE,
-	.name		= "ITE IIC adapter",
 	.id		= I2C_HW_I_IIC,
 	.algo_data	= &iic_ite_data,
+	.dev		= {
+		.name	= "ITE IIC adapter",
+	},
 };
 
 /* Called when the module is loaded.  This function starts the
diff -ur linux-2.5.66/drivers/i2c/i2c-frodo.c linux-2.5.66-bk3/drivers/i2c/i2c-frodo.c
--- linux-2.5.66/drivers/i2c/i2c-frodo.c	Mon Mar 24 22:59:46 2003
+++ linux-2.5.66-bk3/drivers/i2c/i2c-frodo.c	Thu Mar 27 19:57:28 2003
@@ -59,9 +59,11 @@
 
 static struct i2c_adapter frodo_ops = {
 	.owner			= THIS_MODULE,
-	.name			= "Frodo adapter driver",
 	.id			= I2C_HW_B_FRODO,
 	.algo_data		= &bit_frodo_data,
+	.dev			= {
+		.name		= "Frodo adapter driver",
+	},
 };
 
 static int __init i2c_frodo_init (void)
diff -ur linux-2.5.66/drivers/i2c/scx200_i2c.c linux-2.5.66-bk3/drivers/i2c/scx200_i2c.c
--- linux-2.5.66/drivers/i2c/scx200_i2c.c	Mon Mar 24 23:00:35 2003
+++ linux-2.5.66-bk3/drivers/i2c/scx200_i2c.c	Thu Mar 27 19:57:30 2003
@@ -82,9 +82,11 @@
 
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
-	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
+	.dev		   = {
+		.name      = "NatSemi SCx200 I2C",
+	},
 };
 
 int scx200_i2c_init(void)
@@ -110,7 +112,7 @@
 
 	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
 		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
-		       scx200_i2c_ops.name);
+		       scx200_i2c_ops.dev.name);
 		return -ENODEV;
 	}
 	
-- End of PGP section.
----- End of forwarded message from Thomas Schlichter -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
