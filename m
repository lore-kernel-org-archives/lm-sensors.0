From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:54:54 +0000
Subject: [lm-sensors] [PATCH 00/82] hwmon: Fix multi-line comments
Message-Id: <1327017376-20466-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series modifies all multi-line comments in drivers/hwmon to follow
the multi-line comment format suggested in Documentation/CodingStyle, chapter 8.

The patch series was generated automatically with some minor manual edits. The
patches apply on top of the previous series of patches fixing coding style
issues.

I will apply the patches to my linux-next branch for the time being. As I get
Acked-by or Reviewed-by feedback, I will move the affected patches to my hwmon
branch and submit to Linus for the next available release candidate.

Any remaining patches will be submitted upstream in the 3.4 commit window.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
