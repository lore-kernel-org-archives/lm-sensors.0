From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 21 Sep 2006 15:39:21 +0000
Subject: [lm-sensors] [patch] hwmon/pc87360: update vrm-setting-code to call
Message-Id: <4512B229.1080901@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pc87360 currently hardcodes vrm = 90 (2.4 vintage).  Update it to use
newer code in hwmon-vid which reads cpuid to determine the correct vid.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---

pc87360.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.vrm-auto
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060921/524d28e4/attachment.pl 
