From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Remove NULL client checks in rtc8564 driver
Message-Id: <11099685962988@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685963905@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2106, 2005/03/02 15:01:52-08:00, khali@linux-fr.org

[PATCH] I2C: Remove NULL client checks in rtc8564 driver

Several functions in your rtc8564 driver verify the non-NULLity of the
i2c client that is passed to them. It doesn't seem to be necessary, as I
can't think of any case where these functions could possibly be called
with a NULL i2c client. As a matter of fact, I couldn't find any similar
driver doing such checks.

My attention was brought on this by Coverity's SWAT which correctly
noticed that three of these functions contain explicit or hidden
dereferences of the i2c client pointer *before* the NULL check. I guess
it wasn't a problem because the NULL case cannot happen (unless I miss
something), but this still is confusing code.

Thus I propose the following changes:

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/rtc8564.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- a/drivers/i2c/chips/rtc8564.c	2005-03-04 12:23:48 -08:00
+++ b/drivers/i2c/chips/rtc8564.c	2005-03-04 12:23:48 -08:00
@@ -89,7 +89,7 @@
 
 	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, buf, len);
 
-	if (!buf || !client) {
+	if (!buf) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -111,7 +111,7 @@
 	struct i2c_msg wr;
 	int i;
 
-	if (!client || !data || len > 15) {
+	if (!data || len > 15) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -220,7 +220,7 @@
 
 	_DBG(1, "client=%p, dt=%p", client, dt);
 
-	if (!dt || !client)
+	if (!dt)
 		return -EINVAL;
 
 	memset(buf, 0, sizeof(buf));
@@ -254,7 +254,7 @@
 
 	_DBG(1, "client=%p, dt=%p", client, dt);
 
-	if (!dt || !client)
+	if (!dt)
 		return -EINVAL;
 
 	_DBGRTCTM(2, *dt);
@@ -293,7 +293,7 @@
 {
 	struct rtc8564_data *data = i2c_get_clientdata(client);
 
-	if (!ctrl || !client)
+	if (!ctrl)
 		return -1;
 
 	*ctrl = data->ctrl;
@@ -305,7 +305,7 @@
 	struct rtc8564_data *data = i2c_get_clientdata(client);
 	unsigned char buf[2];
 
-	if (!ctrl || !client)
+	if (!ctrl)
 		return -1;
 
 	buf[0] = *ctrl & 0xff;
@@ -318,7 +318,7 @@
 static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem)
 {
 
-	if (!mem || !client)
+	if (!mem)
 		return -EINVAL;
 
 	return rtc8564_read(client, mem->loc, mem->data, mem->nr);
@@ -327,7 +327,7 @@
 static int rtc8564_write_mem(struct i2c_client *client, struct mem *mem)
 {
 
-	if (!mem || !client)
+	if (!mem)
 		return -EINVAL;
 
 	return rtc8564_write(client, mem->loc, mem->data, mem->nr);

