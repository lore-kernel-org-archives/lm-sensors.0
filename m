From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Nov 2011 20:39:57 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: More LM63 enhancements
Message-Id: <1321994400-29295-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for unsigned temperatures on LM96163
Add support for writing remote T_CRIT limit
Add support for writing conversion rate register

Question:
  Calculations are currently along the line of "/ 125 * 32", causing loss of accuracy.
  Ok to change to "* 32 / 125" ?

v2 [unsigned temp patch]: Improved rounding for TEMP11U_TO_REG

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
