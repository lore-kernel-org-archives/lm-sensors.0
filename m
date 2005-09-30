From: jamagallon@able.es (J.A. Magallon)
Date: Fri, 30 Sep 2005 01:09:58 +0000
Subject: [lm-sensors] Re: 2.6.14-rc2-mm2
Message-Id: <20050930010931.5beb174e@werewolf.able.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050929143732.59d22569.akpm@osdl.org>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 29 Sep 2005 14:37:32 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
> 
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> 

I still need this to make my sensors work. I collected it from the list, heard
people say it was not the proper solution, but without this it still doesn't work.
No sensors.

Another issue. Is there any divisor value for fans hardcoded intially ?
I have 3 fans in my mobo, and 2 report 0 RPM until I put the divisor at 8
This fans are two for the xeons, and one for the box. Strangely, the fans that
are misread are the one for the board and one of the xeons ?

And more, my board has 2 more fan sensors, but the driver can only see 3. Any idea ?
(Asus PC-DL Deluxe).

TIA

diff -urN linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c linux-2.6.13-5bca/drivers/hwmon/w83627hf.c
--- linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c     2005-09-06 13:50:03.000000000 +0200
+++ linux-2.6.13-5bca/drivers/hwmon/w83627hf.c  2005-09-07 19:54:08.000000000 +0200
@@ -142,12 +142,16 @@
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
 
-/* Length of ISA address segment */
-#define WINB_EXTENT 8
+/* Alignment of ISA address */
+#define WINB_ALIGNMENT		~7
 
-/* Where are the ISA address/data registers relative to the base address */
-#define W83781D_ADDR_REG_OFFSET 5
-#define W83781D_DATA_REG_OFFSET 6
+/* Offset & size of I/O region we are interested in */
+#define WINB_REGION_OFFSET	5
+#define WINB_REGION_SIZE	2
+
+/* Where are the ISA address/data registers relative to the region start */
+#define W83781D_ADDR_REG_OFFSET 0
+#define W83781D_DATA_REG_OFFSET 1
 
 /* The W83781D registers */
 /* The W83782D registers for nr=7,8 are in bank 5 */
@@ -981,7 +985,7 @@
 	superio_select(W83627HF_LD_HWM);
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
-	*addr = val & ~(WINB_EXTENT - 1);
+	*addr = val & WINB_ALIGNMENT;
 	if (*addr = 0 && force_addr = 0) {
 		superio_exit();
 		return -ENODEV;
@@ -998,11 +1002,13 @@
 	struct w83627hf_data *data;
 	int err = 0;
 	const char *client_name = "";
+	unsigned short addr;
 
 	if(force_addr)
-		address = force_addr & ~(WINB_EXTENT - 1);
+		address = force_addr & WINB_ALIGNMENT;
+	addr = address + WINB_REGION_OFFSET;
 
-	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
+	if (!request_region(addr, WINB_REGION_SIZE, w83627hf_driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
@@ -1049,7 +1055,7 @@
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
+	new_client->addr = addr;
 	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &w83627hf_driver;
@@ -1148,7 +1154,7 @@
       ERROR2:
 	kfree(data);
       ERROR1:
-	release_region(address, WINB_EXTENT);
+	release_region(addr, WINB_REGION_SIZE);
       ERROR0:
 	return err;
 }
@@ -1163,7 +1169,7 @@
 	if ((err = i2c_detach_client(client)))
 		return err;
 
-	release_region(client->addr, WINB_EXTENT);
+	release_region(client->addr, WINB_REGION_SIZE);
 	kfree(data);
 
 	return 0;


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (2006 rc2) for i586
Linux 2.6.13-jam7 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/843d5663/attachment.bin
