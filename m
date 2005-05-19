From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: [PATCH 2.6] Fix i2c-algo-bit for adapers that cannot read SCL back
Message-Id: <20031115154351.5bcbf36b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

Here follows a patch to i2c-algo-bit.c as found in linux-2.6.0-test9,
with two fixes for adapters that cannot read SCL back. Althouth real
adapters should be able to read SCL back, there are some that
cannot, for example the ADM1032 evaluation board I am using. Such
adapters where supposed to be already supported, but I found a probable
bug and improved support.

These changes were applied to our i2c CVS repository two weeks ago and
have been reviewed by Mark D. Studebaker.

List of changes:

* Fix sclhi() for adapters that do not have getscl().
* Enable bit_test for adapters that do not have getscl().
* Mostly rewrite test_bus(), cleaner and probably faster.

Thanks.

--- linux-2.6.0-test9/drivers/i2c/algos/i2c-algo-bit.c.orig	Sun Sep 28 17:43:37 2003
+++ linux-2.6.0-test9/drivers/i2c/algos/i2c-algo-bit.c	Sat Nov 15 15:42:51 2003
@@ -18,10 +18,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
-
-/* $Id: i2c-algo-bit.c,v 1.44 2003/01/21 08:08:16 kmalkki Exp $ */
+/* With some changes from Frodo Looijaard <frodol@dds.nl>, Ky?sti M?lkki
+   <kmalkki@cc.hut.fi> and Jean Delvare <khali@linux-fr.org> */
 
 /* #define DEBUG 1 */
 
@@ -87,8 +85,10 @@
 	setscl(adap,1);
 
 	/* Not all adapters have scl sense line... */
-	if (adap->getscl = NULL )
+	if (adap->getscl = NULL ) {
+		udelay(adap->udelay);
 		return 0;
+	}
 
 	start=jiffies;
 	while (! getscl(adap) ) {	
@@ -222,68 +222,72 @@
  */
 static int test_bus(struct i2c_algo_bit_data *adap, char* name) {
 	int scl,sda;
+
+	if (adap->getscl=NULL)
+		printk(KERN_INFO "i2c-algo-bit.o: Testing SDA only, "
+			"SCL is not readable.\n");
+
 	sda=getsda(adap);
-	if (adap->getscl=NULL) {
-		printk(KERN_WARNING "i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
-		return 0;		
-	}
-	scl=getscl(adap);
-	printk(KERN_INFO "i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
-	       name,getscl(adap),getsda(adap));
+	scl=(adap->getscl=NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (0) scl=%d, sda=%d\n",scl,sda);
 	if (!scl || !sda ) {
-		printk(KERN_INFO " i2c-algo-bit.o: %s seems to be busy.\n",name);
+		printk(KERN_WARNING "i2c-algo-bit.o: %s seems to be busy.\n", name);
 		goto bailout;
 	}
+
 	sdalo(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck high!\n",name);
-		sdahi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl=NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (1) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 != sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA stuck high!\n");
 		goto bailout;
 	}
-	if ( 0 = getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
-			name);
+	if ( 0 = scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL unexpected low "
+			"while pulling SDA low!\n");
 		goto bailout;
 	}		
+
 	sdahi(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 = getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck low!\n",name);
-		sdahi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl=NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (2) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 = sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA stuck low!\n");
 		goto bailout;
 	}
-	if ( 0 = getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
-		       name);
-	goto bailout;
+	if ( 0 = scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL unexpected low "
+			"while pulling SDA high!\n");
+		goto bailout;
 	}
+
 	scllo(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck high!\n",name);
-		sclhi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl=NULL?0:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (3) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 != scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL stuck high!\n");
 		goto bailout;
 	}
-	if ( 0 = getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
-			name);
+	if ( 0 = sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA unexpected low "
+			"while pulling SCL low!\n");
 		goto bailout;
 	}
+	
 	sclhi(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 = getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck low!\n",name);
-		sclhi(adap);
+	sda=getsda(adap);
+	scl=(adap->getscl=NULL?1:getscl(adap));
+	printk(KERN_DEBUG "i2c-algo-bit.o: (4) scl=%d, sda=%d\n",scl,sda);
+	if ( 0 = scl ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SCL stuck low!\n");
 		goto bailout;
 	}
-	if ( 0 = getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
-			name);
+	if ( 0 = sda ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: SDA unexpected low "
+			"while pulling SCL high!\n");
 		goto bailout;
 	}
 	printk(KERN_INFO "i2c-algo-bit.o: %s passed test.\n",name);

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
