From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040121214705.12a0a4a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10745567571488@kroah.com>
	<1074556757661@kroah.com>
	<20040120230322.24cbe005.khali@linux-fr.org>
	<20040120220750.GA3944@kroah.com>
In-Reply-To: <20040120220750.GA3944@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com, rusty@rustcorp.com.au

> Or just send me a patch, backing out your change, I'll apply that :)

Here you are. Sorry again for the noise.

--------------------------------

Undo a recent change to the i2c documentation. The change belongs to
2.7.

--- linux-2.6.2-rc1/Documentation/i2c/porting-clients.orig	Wed Jan 21 21:41:04 2004
+++ linux-2.6.2-rc1/Documentation/i2c/porting-clients	Wed Jan 21 21:41:12 2004
@@ -92,10 +92,7 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
-  by module_param(). Note that module_param has a third parameter,
-  that you should set to 0 by default. See include/linux/moduleparam.h
-  for details.
+  there is a MODULE_LICENSE() line.
 
 Coding policy:
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
