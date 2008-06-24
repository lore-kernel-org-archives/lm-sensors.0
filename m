From: Nate Case <ncase@xes-inc.com>
Date: Tue, 24 Jun 2008 20:49:04 +0000
Subject: [lm-sensors] [PATCH v3 0/2] hwmon: (lm90) Enhancements for ADT7461
Message-Id: <1214340546-18208-1-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is the third revision of this patch which converts the conversion
macros into functions and adds support for extended temperature ranges
on the ADT7461.

Changes from v2:
- Use int instead of long for tempX_from_* functions and use %d instead
  of %ld for the relevant sprintf() statements to get rid of compiler
  warning.

--
Nate Case <ncase@xes-inc.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
