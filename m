From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040609022122.GB3018@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

This patch applies on top of the previous one in the thread
(which applied to 2.6.7-rc2).  Please apply.

* * * * *

Pick a VRM (for VID interpretation) based on the VRM & OVT config,
if available.  Props to Jean Delvare <khali@linux-fr.org> for the
idea & code fragment.

--- linux-2.6.7-rc2/drivers/i2c/chips/w83627hf.c.1	2004-06-06 00:04:56.000000000 -0400
+++ linux-2.6.7-rc2/drivers/i2c/chips/w83627hf.c	2004-06-08 22:06:01.926908662 -0400
@@ -1275,12 +1275,15 @@
 	}
 
 	/* Read VRM & OVT Config only once */
-	if (w83627thf = data->type || w83637hf = data->type)
+	if (w83627thf = data->type || w83637hf = data->type) {
 		data->vrm_ovt = 
 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
+		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
+	} else {
+		/* Convert VID to voltage based on default VRM */
+		data->vrm = DEFAULT_VRM;
+	}
 
-	/* Convert VID to voltage based on default VRM */
-	data->vrm = DEFAULT_VRM;
 	if (type != w83697hf)
 		vid = vid_from_reg(vid, data->vrm);
 
-- 
Mark M. Hoffman
mhoffman@lightlink.com
