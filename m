From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 16 Feb 2010 11:09:26 +0000
Subject: [lm-sensors] [PATCH V2 1/6] lis3: Add missing constants for 8bit
Message-Id: <1266318571-31083-2-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: eric.piel@tremplin-utc.net
Cc: pavel@ucw.cz, daniel@caiaq.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Definitions for click were missing.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
Tested-by: Daniel Mack <daniel@caiaq.de>
---
 drivers/hwmon/lis3lv02d.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index e6a01f4..692e244 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -196,6 +196,16 @@ enum lis3lv02d_dd_src {
 	DD_SRC_IA	=3D 0x40,
 };
=20
+enum lis3lv02d_click_src_8b {
+	CLICK_SINGLE_X	=3D 0x01,
+	CLICK_DOUBLE_X	=3D 0x02,
+	CLICK_SINGLE_Y	=3D 0x04,
+	CLICK_DOUBLE_Y	=3D 0x08,
+	CLICK_SINGLE_Z	=3D 0x10,
+	CLICK_DOUBLE_Z	=3D 0x20,
+	CLICK_IA	=3D 0x40,
+};
+
 struct axis_conversion {
 	s8	x;
 	s8	y;
--=20
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
