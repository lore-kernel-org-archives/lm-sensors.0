From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 18:38:05 +0000
Subject: [lm-sensors] [PATCH 0/4 resend] hwmon: (f753375s) Series of cleanup
Message-Id: <1323369489-26681-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix checkpatch errors and warnings, rename attributes to use standardized names,
fix rpm mode value range, and initialize pwm_mode and pwm_enable if there is not
platform data.

If we agree on this set of patches, the pending patches to add support for
F75383 should probably be applied on top of it.

[resent with maintainer added, and proper subject]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
