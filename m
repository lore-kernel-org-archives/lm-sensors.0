From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [TRIVIAL] trivial patch (fwd)
Message-Id: <200302060640.h166er732741@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rusty Trivial Russell wrote:
From rusty@rustcorp.com.au Thu Feb  6 06:40:07 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h165e4q31612 ; Thu, 6 Feb 2003 06:40:06 +0100
Return-Path: <rusty@rustcorp.com.au>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Thu, 06 Feb 2003 06:40:06 +0100 (CET)
Received: (qmail-ldap/ctrl 10373 invoked from network); 6 Feb 2003 05:38:21 -0000
Received: from dp.samba.org (HELO lists.samba.org) ([66.70.73.150]) (envelope-sender <rusty@samba.org>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 6 Feb 2003 05:38:21 -0000
Received: by lists.samba.org (Postfix, from userid 590)
	id 5FF8A2C2E5; Thu,  6 Feb 2003 05:38:21 +0000 (GMT)
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Simon Vogl <simon@tk.uni-linz.ac.at>, Frodo Looijaard <frodol@dds.nl>
Subject: [TRIVIAL] trivial patch
Date: Thu, 06 Feb 2003 14:15:41 +1100
Sender: rusty@rustcorp.com.au
Message-Id: <20030206053821.5FF8A2C2E5@lists.samba.org>
X-Loop-Procmail: PreventLoop

From:  T.Lukaszewski@elka.pw.edu.pl

  I don't know if it is a good address for that patch, but i hope that 
  it won't be lost.
  
  This patch adds KERN_INFO in two printk() calls (in i2c_core.c and
  i2c_algo_bit.c). 
  
  					Tomasz Lukaszewski
  					T.Lukaszewski@elka.pw.edu.pl

--- trivial-2.4.21-pre4/drivers/i2c/i2c-algo-bit.c.orig	2003-02-06 13:53:52.000000000 +1100
+++ trivial-2.4.21-pre4/drivers/i2c/i2c-algo-bit.c	2003-02-06 13:53:52.000000000 +1100
@@ -609,7 +609,7 @@
 
 int __init i2c_algo_bit_init (void)
 {
-	printk("i2c-algo-bit.o: i2c bit algorithm module\n");
+	printk(KERN_INFO "i2c-algo-bit.o: i2c bit algorithm module\n");
 	return 0;
 }
 
--- trivial-2.4.21-pre4/drivers/i2c/i2c-core.c.orig	2003-02-06 13:53:52.000000000 +1100
+++ trivial-2.4.21-pre4/drivers/i2c/i2c-core.c	2003-02-06 13:53:52.000000000 +1100
@@ -1264,7 +1264,7 @@
 
 static int __init i2c_init(void)
 {
-	printk("i2c-core.o: i2c core module\n");
+	printk(KERN_INFO "i2c-core.o: i2c core module\n");
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
 	adap_count=0;
-- 
  Don't blame me: the Monkey is driving
  File: T.Lukaszewski@elka.pw.edu.pl: trivial patch


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
