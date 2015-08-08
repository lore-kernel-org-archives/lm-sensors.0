From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 18:30:32 +0000
Subject: [lm-sensors] [PATCH 0/4] i2c: move client binding docs to proper place
Message-Id: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Wolfram Sang <wsa@the-dreams.de>

The I2C binding directory is for master controllers, muxes and alike. Not for
client drivers. Move those who slipped in to their proper places.

I'd like to take these patches via my tree, so it is promptly cleaned up in one
go. So, I am mainly asking for acks here.

Thanks,

   Wolfram

Wolfram Sang (4):
  rtc: bq32k: move binding docs to proper place
  hwmon: max6697: move binding docs to proper place
  hwmon: ina2xx: move binding docs to proper place
  hwmon: ina209: move binding docs to proper place

 Documentation/devicetree/bindings/{i2c => hwmon}/ina209.txt  | 0
 Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt  | 0
 Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt | 0
 Documentation/devicetree/bindings/{i2c => rtc}/ti,bq32k.txt  | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina209.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => rtc}/ti,bq32k.txt (100%)

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
