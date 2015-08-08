From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 18:30:35 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: ina2xx: move binding docs to proper place
Message-Id: <1439058636-3082-4-git-send-email-wsa@the-dreams.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>

The I2C dir is not for I2C client devices! Move it to the proper folder.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt (100%)

diff --git a/Documentation/devicetree/bindings/i2c/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
similarity index 100%
rename from Documentation/devicetree/bindings/i2c/ina2xx.txt
rename to Documentation/devicetree/bindings/hwmon/ina2xx.txt
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
