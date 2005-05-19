From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [TRIVIAL] make i2c-core driver_lock static (fwd)
Message-Id: <200302101424.h1AEO9P7000477@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302060641.h166f7h32765@morannon.frodo.local>
In-Reply-To: <200302060641.h166f7h32765@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Rusty Trivial Russell -----

Received: by morannon.frodo.local (8.11.3/8.11.3) id h1A1t9408297 ; Mon, 10 Feb 2003 02:55:09 +0100
Return-path: <rusty@rustcorp.com.au>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Mon, 10 Feb 2003 02:55:09 +0100 (CET)
Received: (qmail-ldap/ctrl 6844 invoked from network); 10 Feb 2003 01:46:42 -0000
Received: from dp.samba.org (HELO lists.samba.org) ([66.70.73.150]) (envelope-sender <rusty@samba.org>)
	         by dds.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 10 Feb 2003 01:46:42 -0000
Received: by lists.samba.org (Postfix, from userid 590)
	id 90F282C262; Mon, 10 Feb 2003 01:46:41 +0000 (GMT)
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Simon G. Vogl <simon@tk.uni-linz.ac.at>, Frodo Looijaard <frodol@dds.nl>
Subject: [TRIVIAL] make i2c-core driver_lock static
Date: Mon, 10 Feb 2003 12:36:23 +1100
Sender: rusty@rustcorp.com.au
Message-ID: <20030210014641.90F282C262@lists.samba.org>
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

--- trivial-2.5.59-bk3/drivers/i2c/i2c-core.c.orig	2003-02-10 12:29:53.000000000 +1100
+++ trivial-2.5.59-bk3/drivers/i2c/i2c-core.c	2003-02-10 12:29:53.000000000 +1100
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

----- End of forwarded message from Rusty Trivial Russell -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
