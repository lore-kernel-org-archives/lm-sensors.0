From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: [Fwd: [PATCH] video/saa5249.c, video/tuner-3036.c get rid of
Message-Id: <3F5E5D6D.3000406@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
From: 	- Tue Sep 9 16:08:05 2003
X-UIDL: 	5ac8251150262f72
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00000000
Return-Path: 	<shemminger@osdl.org>
Received: 	from mail.osdl.org (fw.osdl.org [65.172.181.6]) by 
Ren.netroedge.com (8.12.8p1/8.12.8) with ESMTP id h89MwlIP032597 for 
<phil@netroedge.com>; Tue, 9 Sep 2003 15:58:47 -0700
Received: 	from dell_ss3.pdx.osdl.net (dell_ss3.pdx.osdl.net 
[172.20.1.60]) by mail.osdl.org (8.11.6/8.11.6) with SMTP id 
h89N9ho19941; Tue, 9 Sep 2003 16:09:43 -0700
Date: 	Tue, 9 Sep 2003 16:09:26 -0700
From: 	Stephen Hemminger <shemminger@osdl.org>
To: 	Philip.Blundell@pobox.com, Frodo Looijaard <frodol@dds.nl>, Philip 
Edelbrock <phil@netroedge.com>, Greg KH <greg@kroah.com>
Cc: 	linux-kernel@vger.kernel.org
Subject: 	[PATCH] video/saa5249.c, video/tuner-3036.c get rid of 
MOD_INC/DEC
Message-Id: 	<20030909160926.09c5fa69.shemminger@osdl.org>
Organization: 	Open Source Development Lab
X-Mailer: 	Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: 	&@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4; 
D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$ 
/`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 	1.0
Content-Type: 	text/plain; charset=US-ASCII
Content-Transfer-Encoding: 	7bit
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	unsure; 0.42



Get rid of MOD_INC/DEC since ref count comes from owner field on I2C
for these drivers.

Not sure who is maintaining these, maybe no one because they haven't been
purged of MOD stuff  yet.

diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Tue Sep  9 16:04:52 2003
+++ b/drivers/media/video/saa5249.c	Tue Sep  9 16:04:52 2003
@@ -214,7 +214,6 @@
 	}
 	t->client = client;
 	i2c_attach_client(client);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -237,7 +236,6 @@
 	kfree(vd->priv);
 	kfree(vd);
 	kfree(client);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	Tue Sep  9 16:04:52 2003
+++ b/drivers/media/video/tuner-3036.c	Tue Sep  9 16:04:52 2003
@@ -135,7 +135,6 @@
 	printk("tuner: SAB3036 found, status %02x\n", tuner_getstatus(client));
 
         i2c_attach_client(client);
-	MOD_INC_USE_COUNT;
 
 	if (i2c_master_send(client, buffer, 2) != 2)
 		printk("tuner: i2c i/o error 1\n");
@@ -149,7 +148,6 @@
 static int 
 tuner_detach(struct i2c_client *c)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 


