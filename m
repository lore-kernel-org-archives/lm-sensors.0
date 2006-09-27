From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:55 +0000
Subject: [lm-sensors] [PATCH 24/30] i2c: Warn on i2c client creation failure
Message-Id: <11593190031746-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c: Warn on i2c client creation failure

Warn when an i2c client creation fails. If we don't, the user will
never know something wrong happened, as i2c client creation is
typically called through an attach_adapter callback, those return value
we currently ignore for technical reasons.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 88dd803..01233f0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -707,11 +707,16 @@ static int i2c_probe_address(struct i2c_
 
 	/* Finally call the custom detection function */
 	err = found_proc(adapter, addr, kind);
-
 	/* -ENODEV can be returned if there is a chip at the given address
 	   but it isn't supported by this chip driver. We catch it here as
 	   this isn't an error. */
-	return (err = -ENODEV) ? 0 : err;
+	if (err = -ENODEV)
+		err = 0;
+
+	if (err)
+		dev_warn(&adapter->dev, "Client creation failed at 0x%x (%d)\n",
+			 addr, err);
+	return err;
 }
 
 int i2c_probe(struct i2c_adapter *adapter,
-- 
1.4.2.1


