From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Error loading lm93
Message-Id: <20050106223614.35cfcd43.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDA457.3040502@earthlink.net>
In-Reply-To: <41DDA457.3040502@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> have also verified that I have this same issue with the lm_sensors 
> version from CVS downloaded October 25, 2004.   This box has an LM87
> at i2c location lm87-i2c-0-2d and an lm93 at i2c location
> lm93-i2c-0-2e.
> 
> If I load the lm93 driver but not the lm87 driver, the following
> message  is logged by dmesg:
> lm93.o version 2.9.0 (20041228)
> lm93.o: disabled SMBus block data transactions
> lm93.o: detect failed, bad manufacturer id 0x02
> 
> When I run sensors, a message that no sensors are found is printed.
> 
> I can do an i2cdump of the lm93 and the manufacturer ID (at location 
> 0x3e) is 0x01.  A dump of the lm87 shows 0x02 at location 0x3e.
> 
> I unloaded the lm93 driver and loaded the lm87 driver.   Then the lm93
> 
> driver loads without incident and both drivers are happy.
> 
> Is this normal behavior?

It isn't.

See this ticket for a similar report:
http://secure.netroedge.com/~lm78/readticket.cgi?ticket07

Basically, the issue is caused by Mark Hoffman's drivers (asb100, lm93
in your case) returning an error (-ENODEV) on misdetection, while the
i2c core doesn't expect them. As a result, the core stops probing
greater addresses. In your case, the LM87 has the lowest address, so it
is scanned before the LM93. If the lm87 driver is loaded first, the low
address is marked busy and not probed the lm93 driver. However, if the
lm87 driver is not loaded, then the first address probed by the lm93
driver is the LM87's one, not the LM93's one, causing the bug to
trigger.

It can be discussed whether it is wise that the core interprets returned
values that way, but as a matter of fact, all other drivers work that
way. I personally think that this behavior shouldn't be changed in 2.4,
but it could be in 2.6.

The attached patch should solve the problem, but I'd like to hear Mark
Hoffman about this before I apply it. The asb100 driver would need a
similar patch.

-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
Index: kernel/chips/lm93.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/lm93.c,v
retrieving revision 1.17
diff -u -r1.17 lm93.c
--- kernel/chips/lm93.c	7 Dec 2004 15:32:19 -0000	1.17
+++ kernel/chips/lm93.c	6 Jan 2005 21:35:19 -0000
@@ -2187,7 +2187,7 @@
 static int lm93_detect(struct i2c_adapter *adapter, int address,
 		unsigned short flags, int kind)
 {
-	int err, func;
+	int err = 0, func;
 	struct lm93_data *data;
 	struct i2c_client *client;
 	void (*update)(struct lm93_data *, struct i2c_client *);
@@ -2196,7 +2196,6 @@
 	if (i2c_is_isa_adapter(adapter)) {
 		pr_debug("lm93.o: detect failed, "
 				"cannot attach to legacy adapter!\n");
-		err = -ENODEV;
 		goto ERROR0;
 	}
 
@@ -2213,7 +2212,6 @@
 	} else {
 		pr_debug("lm93.o: detect failed, "
 				"smbus byte and/or word data not supported!\n");
-		err = -ENODEV;
 		goto ERROR0;
 	}
 
@@ -2242,7 +2240,6 @@
 		if (mfr != 0x01) {
 			pr_debug("lm93.o: detect failed, "
 				"bad manufacturer id 0x%02x!\n", mfr);
-			err = -ENODEV;
 			goto ERROR1;
 		}
 	}
@@ -2258,7 +2255,6 @@
 			if (kind = 0)
 				pr_debug("lm93.o: "
 					"(ignored 'force' parameter)\n");
-			err = -ENODEV;
 			goto ERROR1;
 		}
 	}
