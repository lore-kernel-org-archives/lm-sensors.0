From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [TRIVIAL] make i2c-core driver_lock static (fwd)
Message-Id: <200302060641.h166f7h32765@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rusty Trivial Russell wrote:
From rusty@rustcorp.com.au Thu Feb  6 07:10:03 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h166A3q32167 ; Thu, 6 Feb 2003 07:10:03 +0100
Return-Path: <rusty@rustcorp.com.au>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Thu, 06 Feb 2003 07:10:03 +0100 (CET)
Received: (qmail-ldap/ctrl 31865 invoked from network); 6 Feb 2003 05:57:47 -0000
Received: from dp.samba.org (HELO lists.samba.org) ([66.70.73.150]) (envelope-sender <rusty@samba.org>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 6 Feb 2003 05:57:47 -0000
Received: by lists.samba.org (Postfix, from userid 590)
	id C4ED02C108; Thu,  6 Feb 2003 05:57:46 +0000 (GMT)
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Simon Vogl <simon@tk.uni-linz.ac.at>, Frodo Looijaard <frodol@dds.nl>
Subject: [TRIVIAL] make i2c-core driver_lock static
Date: Thu, 06 Feb 2003 16:49:02 +1100
Sender: rusty@rustcorp.com.au
Message-Id: <20030206055746.C4ED02C108@lists.samba.org>
X-Loop-Procmail: PreventLoop

From:  Muli Ben-Yehuda <mulix@mulix.org>

  The i2c driver_lock is needlessly exported. Attached is a patch to
  make it static. Compiles fine.
  
  # This is a BitKeeper generated patch for the following project:
  # Project Name: Linux kernel tree
  # This patch format is intended for GNU patch command version 2.5 or higher.
  # This patch includes the following deltas:
  #	           ChangeSet	1.931   -> 1.932  
  #	drivers/i2c/i2c-core.c	1.14    -> 1.15   
  #
  # The following is the BitKeeper ChangeSet Log
  # --------------------------------------------
  # 03/01/12	mulix@alhambra.mulix.org	1.932
  # make the driver_lock mutex static, to avoid polluting the global name space. 
  # --------------------------------------------
  #

--- trivial-2.5-bk/drivers/i2c/i2c-core.c.orig	2003-02-06 16:30:18.000000000 +1100
+++ trivial-2.5-bk/drivers/i2c/i2c-core.c	2003-02-06 16:30:18.000000000 +1100
@@ -57,7 +57,7 @@
 
 /**** lock for writing to global variables: the adapter & driver list */
 DECLARE_MUTEX(adap_lock);
-DECLARE_MUTEX(driver_lock);
+static DECLARE_MUTEX(driver_lock);
 
 /**** adapter list */
 static struct i2c_adapter *adapters[I2C_ADAP_MAX];
-- 
  Don't blame me: the Monkey is driving
  File: Muli Ben-Yehuda <mulix@mulix.org>: [PATCH] make i2c-core driver_lock static


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
