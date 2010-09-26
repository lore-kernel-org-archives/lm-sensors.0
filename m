From: Chen Gong <gong.chen@linux.intel.com>
Date: Sun, 26 Sep 2010 05:59:58 +0000
Subject: [lm-sensors] [PATHC 0/2] update and cleanup patches for coretemp
Message-Id: <1285480800-14558-1-git-send-email-gong.chen@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: JBeulich@novell.com, linux-kernel@vger.kernel.org

[PATCH 1/2] hwmon: uniform the init style of pkgtemp
[PATCH 2/2] hwmon: cleanup some hotplug related macro definition

These 2 patches are no new functions, just unify the codes to avoid
potential issues and some cleanup work.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
