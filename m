From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Oct 2012 21:09:02 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (coretemp) List TjMax for Z650/670 and N550/570
Message-Id: <1349816943-17697-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

as per processor data sheets.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/coretemp |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index c86b50c..0cc4050 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -98,8 +98,10 @@ Process		Processor					TjMax(C)
 
 45nm		Atom Processors
 		D525/510/425/410				100
+		Z650/670					90
 		Z560/550/540/530P/530/520PT/520/515/510PT/510P	90
 		Z510/500					90
+		N550/570					100
 		N475/470/455/450				100
 		N280/270					90
 		330/230						125
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
