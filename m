From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [TRIVIAL] 2.5.59 add two help texts to drivers_i2c_Kconfig (fwd)
Message-Id: <200302060641.h166fOi00310@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rusty Trivial Russell wrote:
From rusty@rustcorp.com.au Thu Feb  6 07:10:03 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h166A3q32164 ; Thu, 6 Feb 2003 07:10:03 +0100
Return-Path: <rusty@rustcorp.com.au>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Thu, 06 Feb 2003 07:10:03 +0100 (CET)
Received: (qmail-ldap/ctrl 30730 invoked from network); 6 Feb 2003 05:57:47 -0000
Received: from dp.samba.org (HELO lists.samba.org) ([66.70.73.150]) (envelope-sender <rusty@samba.org>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 6 Feb 2003 05:57:47 -0000
Received: by lists.samba.org (Postfix, from userid 590)
	id 6A6D62C0B2; Thu,  6 Feb 2003 05:57:46 +0000 (GMT)
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Simon Vogl <simon@tk.uni-linz.ac.at>, Frodo Looijaard <frodol@dds.nl>
Subject: [TRIVIAL] 2.5.59 add two help texts to drivers_i2c_Kconfig
Date: Thu, 06 Feb 2003 16:54:50 +1100
Sender: rusty@rustcorp.com.au
Message-Id: <20030206055746.6A6D62C0B2@lists.samba.org>
X-Loop-Procmail: PreventLoop

From:  Steven Cole <elenstev@mesatop.com>

  Here are some help texts from 2.4.21-pre3 Configure.help which are
  needed in 2.5.59 drivers/i2c/Kconfig.
  
  Steven
  

--- trivial-2.5-bk/drivers/i2c/Kconfig.orig	2003-02-06 16:30:22.000000000 +1100
+++ trivial-2.5-bk/drivers/i2c/Kconfig	2003-02-06 16:30:22.000000000 +1100
@@ -145,10 +145,26 @@
 config ITE_I2C_ALGO
 	tristate "ITE I2C Algorithm"
 	depends on MIPS_ITE8172 && I2C
+	help
+	  This supports the use of the ITE8172 I2C interface found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y for
+	  the ITE I2C peripheral driver support below.
+
+	  This support is also available as a module. If you want to compile
+	  it as a module, say M here and read Documentation/modules.txt.
+	  The module will be called i2c-algo-ite.o.
 
 config ITE_I2C_ADAP
 	tristate "ITE I2C Adapter"
 	depends on ITE_I2C_ALGO
+	help
+	  This supports the ITE8172 I2C peripheral found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y for
+	  the ITE I2C driver algorithm support above.
+
+	  This support is also available as a module. If you want to compile
+	  it as a module, say M here and read Documentation/modules.txt.
+	  The module will be called i2c-adap-ite.o.
 
 config I2C_ALGO8XX
 	tristate "MPC8xx CPM I2C interface"
-- 
  Don't blame me: the Monkey is driving
  File: Steven Cole <elenstev@mesatop.com>: [PATCH] 2.5.59 add two help texts to drivers_i2c_Kconfig


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
