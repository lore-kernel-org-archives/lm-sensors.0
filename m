From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: piix4 fails to reset? (ticket #1078)
Message-Id: <Pine.OSF.4.50.0212202038260.3699-200000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040328325.1738.165.camel@albatross.yyz.somanetworks.com>
In-Reply-To: <1040328325.1738.165.camel@albatross.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 20 Dec 2002, Joe Drew wrote:

> I can't speak to how this would affect long-term reliability, but in an
> attempt to un-crap the SMBus on this card, I've tried adding the KILL
> flag bit to before the host busy wait in piix4_transaction().
> Unfortunately, it doesn't work - I get "KILL failed."

I would like to see if the KILL mechanism works in the first place, on
an un-crapped bus. Maybe we must keep KILL flag set for some time to let
host issue Stop condition on bus. Should not hurt to try.

> In addition, when the sensor modules were running, they returned all
> (binary) ones in values, too. Is that a common occurrence when the bus
> is locked up?

The return code -1 is cast to all binary ones. This is unfortunate
standard behaviour on some (if not all) sensors, and means there
was a SMBus transaction error, not necessarily bus lockup.


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
-------------- next part --------------
--- i2c-piix4.c.orig	Sat Oct 12 15:43:13 2002
+++ i2c-piix4.c	Sat Dec 21 11:17:54 2002
@@ -353,28 +353,29 @@
 #endif
 
 	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+	while ( ((temp = inb_p(SMBHSTSTS)) != 0x00) && (timeout++ < 5)) {
 #ifdef DEBUG
-		printk(KERN_DEBUG "i2c-piix4.o: SMBus busy (%02x). Resetting... \n",
+		printk(KERN_DEBUG "i2c-piix4.o: SMBus busy (%02x). Waiting... \n",
 		       temp);
 #endif
-		outb_p(temp, SMBHSTSTS);
-		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		piix4_do_pause(HZ/10);
+	}
+	if (timeout >= 5) {
 #ifdef DEBUG
-			printk(KERN_ERR "i2c-piix4.o: Failed! (%02x)\n", temp);
+		printk(KERN_ERR "i2c-piix4.o: SMBus busy timeout! (%02x)\n", temp);
 #endif
-			return -1;
-		} else {
+		return -1;
+	} else if (timeout) {
 #ifdef DEBUG
-			printk(KERN_DEBUG "i2c-piix4.o: Successfull!\n");
+		printk(KERN_DEBUG "i2c-piix4.o: SMBus released after %d attempts\n", timeout);
 #endif
-		}
 	}
 
 	/* start the transaction by setting bit 6 */
 	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
 
 	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
+	timeout=0;
 	do {
 		piix4_do_pause(1);
 		temp = inb_p(SMBHSTSTS);
@@ -413,6 +414,30 @@
 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+		printk
+		    (KERN_ERR "i2c-piix4.o: Trying KILL at end of transaction (%02x)\n",
+		     temp);
+#endif
+		/* KILL */
+		outb_p(inb(SMBHSTCNT) | 0x02, SMBHSTCNT);
+		timeout = 0;
+		while ( !(temp = inb_p(SMBHSTSTS) & 0x10) && (timeout++ < 5)) {
+#ifdef DEBUG
+			printk(KERN_DEBUG "i2c-piix4.o: SMBus busy (%02x). Waiting... \n",
+			       temp);
+#endif
+			piix4_do_pause(HZ/10);
+		}
+		outb_p(temp = inb_p(SMBHSTSTS), SMBHSTSTS);
+#ifdef DEBUG
+		if (temp)
+		    printk(KERN_ERR "i2c-piix4.o: KILL failed (%02x)\n", temp);
+#endif
+		/* UNKILL */
+		outb_p(inb(SMBHSTCNT) &~ 0x02, SMBHSTCNT);
+	}
 #ifdef DEBUG
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
 		printk
