From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <20040627104832.0b3307f9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Okay, I'm going to compose an email to them concerning what
> information is needed. What more is needed for proper temperature
> monitoring, if anything?

1* What are voltage pins monitoring (order and resistors used)?
2* CPU voltage?
3* Are thermal diodes or thermistors used (if any)?

And if you happen to be in contact with someone with more knowledge
and will to help:
4* If thermistors are used, we would need the Beta value if not the
   default 3435.
5* If the PC87366 fed with an external reference voltage, and if it
   is, which value is it?

About the output now:

> soekris1# dmesg -c
> pc87360.o version 2.8.8-CVS (2004xxxx)
> pc87360.o: Device 0x09 not activated
> pc87360.o: Using thermistors for temperature monitoring
> pc87360.o: Using internal reference voltage

This is great, means that the isaset sequence properly switched the "use
thermistors" configuration bit.

> soekris1# sensors -s
> soekris1# sensors

Please do not run "sensors -s" right after loading the driver. Running
"sensors" at least once before will show information that "sensors -s"
will overwrite.

> CPU0 Temp:    +0 C  (low  =    +0 C, high =   +70 C)
> CPU0 Crit:   +85 C
> CPU1 Temp:    +0 C  (low  =    +0 C, high =   +70 C)
> CPU1 Crit:   +85 C
> S-IO Temp:   +83 C  (low  =    +0 C, high =   +70 C)   ALARM
> S-IO Crit:   +85 C
> ERROR: Can't get TEMP4 data!
> ERROR: Can't get TEMP4 overtemperature data!
> ERROR: Can't get TEMP5 data!
> ERROR: Can't get TEMP5 overtemperature data!
> temp6:      -273 C  (low  =    +1 C, high =   +67 C)   ALARM
> ERROR: Can't get TEMP6 overtemperature data!

This is no good (I guess you knew that already).

Do the errors happen consistently?

Can you report the values found in files
/proc/sys/dev/sensors/pc87366-isa-6620/temp*?

I've attached a patch to be applied against the current CVS tree. I
didn't commit it because I don't want that much debugging in the driver
in the long run, but that might help in your case. I really feel like
I'm missing something obvious at some point, but can't seem to get what.
Please apply ("patch -p0 < pc87360-debug.diff" from the lm_sensors2
directory) and recompile (make sure you still have DEBUG=1 in the
Makefile), then reload the driver with init=2, and watch the logs. They
should contain much more information (or at least I hope so).

>   set temp1_min    0
>   set temp1_max   70
>   set temp1_crit  85
>   set temp2_min    0
>   set temp2_max   70
>   set temp2_crit  85

Please comment these lines out for now.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
Index: kernel/chips/pc87360.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/pc87360.c,v
retrieving revision 1.38
diff -u -r1.38 pc87360.c
--- kernel/chips/pc87360.c	25 Jun 2004 18:50:06 -0000	1.38
+++ kernel/chips/pc87360.c	27 Jun 2004 08:44:10 -0000
@@ -764,6 +764,12 @@
 	const u8 init_temp[3] = { 2, 2, 1 };
 	u8 reg;
 
+#ifdef DEBUG
+	printk(KERN_DEBUG "pc87360.o: Initializing chip (level %d)\n", init);
+	if (use_thermistors)
+		printk(KERN_DEBUG "pc87360.o: Prefering thermistors\n");
+#endif
+
 	if (init >= 3 && data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONVRATE);
@@ -802,6 +808,10 @@
 		reg = pc87360_read_value(data, LD_IN, i,
 					 PC87365_REG_TEMP_STATUS);
 		use_thermistors = use_thermistors || (reg & 0x01);
+#ifdef DEBUG
+		printk(KERN_DEBUG "pc87360.o: use_thermistors=%d, i=%d, "
+		       "reg=%u\n", use_thermistors, i, reg);
+#endif
 	}
 
 	i = use_thermistors ? 2 : 0;
@@ -823,14 +833,29 @@
 	}
 
 	if (use_thermistors) {
+#ifdef DEBUG
+		printk(KERN_DEBUG "pc87360.o: Will enable thermistors if "
+		       "needed\n");
+#endif
 		for (i; i<data->innr; i++) {
 			if (init >= init_in[i]) {
+#ifdef DEBUG
+				printk(KERN_DEBUG "pc87360.o: Will enable "
+				       "temp%d if needed and possible\n", i-7);
+#endif
+
 				/* The pin may already be used by thermal
 				   diodes */
 				reg = pc87360_read_value(data, LD_TEMP, (i-11)/2,
 							 PC87365_REG_TEMP_STATUS);
-				if (reg & 0x01)
+				if (reg & 0x01) {
+#ifdef DEBUG
+					printk(KERN_DEBUG "pc87360.o: Skipping, "
+					       "pin already in use by temp%d\n",
+					       (i-11)/2);
+#endif
 					continue;
+				}
 			
 				/* Forcibly enable thermistor channel */
 				reg = pc87360_read_value(data, LD_IN, i,
