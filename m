From: Nate Case <ncase@xes-inc.com>
Date: Fri, 13 Jun 2008 16:36:11 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: (lm90) Enhancements for ADT7461
Message-Id: <1213374973-3262-1-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These changes enable extended mode operation for the ADT7461 which will
allow temperature readings from -64..191 degC instead of the current
limited range of 0..127 degC.  I decided to split up the changes so
that the first patch doesn't affect functionality, but just makes
preparations needed to make the second patch easier to follow.

- Nate Case <ncase@xes-inc.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
