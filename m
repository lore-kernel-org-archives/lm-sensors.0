From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 27 Sep 2011 22:33:49 +0000
Subject: [lm-sensors] [PATCH v2 0/2] hwmon: (coretemp) Add support for
Message-Id: <1317162831-30628-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

v2:
- ABI: temp[1-*]_threshold[1-*]_triggered now returns 1 whenever a temperature
  crossed the threshold in either direction, and is expected to stick until
  it is manually cleared. 
- Display value of THERM_LOG_THRESHOLD[01] instead of THERM_STATUS_THRESHOLD[01]
  for tempX_threshold[12]_triggered.
- Provide trigger write function to reset trigger.
- Use sensor_device_attribute_2 for struct sd_attrs, and attr->nr as index
  into threshold registers.
- tx -> thresh, and t -> thresh
- Fix range validation in store_thresh().

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
