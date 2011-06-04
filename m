From: Stijn Devriendt <sdevrien@cisco.com>
Date: Sat, 04 Jun 2011 10:37:10 +0000
Subject: [lm-sensors] [PATCH v2] Add support for the Philips SA56004
Message-Id: <1307183831-19627-1-git-send-email-sdevrien@cisco.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: guenter.roeck@ericsson.com

Changes since v1:
- Added documentation
- Replaced error trace with BUG_ON
- Renamed local_ext_offset to reg_local_ext
- Fixed style issues

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
