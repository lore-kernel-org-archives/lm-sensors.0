From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 05 Dec 2008 17:44:40 +0000
Subject: [lm-sensors] [PATCH 0/4] hwmon: (k8temp) several minor fixes
Message-Id: <20081205174440.GA5581@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Following a series of minor fixes for k8temp.
Of course, I am cc-ing Rudolf - hoping that he will ack the stuff.

BTW, the last patch in the series should get rid of the strange
temperature values reported for several K8 RevG systems.

Patches are on top of Rudolf's patch "hwmon: (k8temp) Warn about fam F
rev F errata" which I've found in your quilt tree.

Please apply for .29.


Thanks,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
