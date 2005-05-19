From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I2C MAINTAINERS entry seems outdated (fwd)
Message-Id: <200304152142.h3FLg2NI001272@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi folks,

didn't you change the entry? Or is that part not yet merged?
The i2c list seems to be defunct.

Thanks,
  Frodo

----- Forwarded message from Adrian Bunk -----

Received: from localhost (frodo@localhost [127.0.0.1])
	by morannon.frodo.local (8.12.3/8.12.3/Debian-6.3) with ESMTP id h3FLP5i0014779
	for <frodo@localhost>; Tue, 15 Apr 2003 23:25:05 +0200
Received: from pop3.dds.nl [213.204.195.153]
	by localhost with POP3 (fetchmail-5.9.11)
	for frodo@localhost (single-drop); Tue, 15 Apr 2003 23:25:05 +0200 (CEST)
Received: (qmail-ldap/ctrl 32209 invoked from network); 15 Apr 2003 21:03:24 -0000
Received: from unknown (HELO hermes.fachschaften.tu-muenchen.de) ([129.187.202.12]) (envelope-sender <bunk@fs.tum.de>)
	         by dds.vsp.scarlet-internet.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 15 Apr 2003 21:03:24 -0000
Received: (qmail 13971 invoked from network); 15 Apr 2003 21:03:20 -0000
Received: from mimas.fachschaften.tu-muenchen.de (129.187.202.58)
	 by hermes.fachschaften.tu-muenchen.de with QMQP; 15 Apr 2003 21:03:20 -0000
Date: Tue, 15 Apr 2003 23:03:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>, simon@tk.uni-linz.ac.at, frodol@dds.nl
Subject: I2C MAINTAINERS entry seems outdated
Message-ID: <20030415210317.GW9640@fs.tum.de>
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Loop-Procmail: PreventLoop
Return-Path: <bunk@fs.tum.de>

Hi,

MAINTAINERS in both 2.4.21-pre7 and 2.5.67 says:

I2C DRIVERS
P:      Simon Vogl
M:      simon@tk.uni-linz.ac.at
P:      Frodo Looijaard
M:      frodol@dds.nl
L:      linux-i2c@pelican.tk.uni-linz.ac.at
W:      http://www.tk.uni-linz.ac.at/~simon/private/i2c
S:      Maintained


Both the web page and the mailing list are not reachable. Could you send 
an patch that updates this information to Linus and Marcelo?



----- Forwarded message from MAILER-DAEMON@hermes.fachschaften.tu-muenchen.de -----

Date: 15 Apr 2003 12:37:50 -0000
From: MAILER-DAEMON@hermes.fachschaften.tu-muenchen.de
To: bunk@fs.tum.de
Subject: failure notice

Hi. This is the qmail-send program at hermes.fachschaften.tu-muenchen.de.
I'm afraid I wasn't able to deliver your message to the following addresses.
This is a permanent error; I've given up. Sorry it didn't work out.

<linux-i2c@pelican.tk.uni-linz.ac.at>:
Sorry, I wasn't able to establish an SMTP connection. (#4.4.1)
I'm not going to try again; this message has been in the queue too long.

--- Below this line is a copy of the message.

Return-Path: <bunk@fs.tum.de>
Received: (qmail 19089 invoked from network); 8 Apr 2003 11:36:47 -0000
Received: from mimas.fachschaften.tu-muenchen.de (129.187.202.58)
  by hermes.fachschaften.tu-muenchen.de with QMQP; 8 Apr 2003 11:36:47 -0000
Date: Tue, 8 Apr 2003 13:36:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christer Weinigel <wingel@nano-system.com>,
  linux-i2c@pelican.tk.uni-linz.ac.at
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] fix drivers/i2c/scx200_i2c.c compilation
Message-ID: <20030408113646.GE5046@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i

I got the following compile error in 2.5.67:

<--  snip  -->

..
  gcc -Wp,-MD,drivers/i2c/.scx200_i2c.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=scx200_i2c -DKBUILD_MODNAME=scx200_i2c 
-c -o drivers/i2c/scx200_i2c.o drivers/i2c/scx200_i2c.c
drivers/i2c/scx200_i2c.c:85: unknown field `name' specified in initializer
drivers/i2c/scx200_i2c.c:85: warning: initialization makes integer from 
pointer without a cast
drivers/i2c/scx200_i2c.c: In function `scx200_i2c_init':
drivers/i2c/scx200_i2c.c:113: structure has no member named `name'
make[2]: *** [drivers/i2c/scx200_i2c.o] Error 1


<--  snip  -->


The following patch is needed:

--- linux-2.5.67-notfull/drivers/i2c/scx200_i2c.c.old	2003-04-08 13:04:22.000000000 +0200
+++ linux-2.5.67-notfull/drivers/i2c/scx200_i2c.c	2003-04-08 13:07:14.000000000 +0200
@@ -82,9 +82,11 @@
 
 static struct i2c_adapter scx200_i2c_ops = {
 	.owner		   = THIS_MODULE,
-	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
+	.dev		   = {
+		.name	   = "NatSemi SCx200 I2C",
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
 	


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

----- End forwarded message -----

----- End of forwarded message from Adrian Bunk -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
