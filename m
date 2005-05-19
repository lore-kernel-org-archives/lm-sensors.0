From: domen@coderock.org (Domen Puncer)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [patch] it87: /proc/ioports fix
Message-Id: <20041210142715.GA16622@nd47.coderock.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

Trivial patch against 2.6.10-rc3-bk2.
When request_region is called name is set to "", use module name.

Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/drivers/i2c/chips/it87.c	2004-12-07 18:29:18.000000000 +0100
+++ a/drivers/i2c/chips/it87.c	2004-12-10 14:41:29.000000000 +0100
@@ -624,7 +624,7 @@ int it87_detect(struct i2c_adapter *adap
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, name))
+		if (!request_region(address, IT87_EXTENT, it87_driver.name))
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already
