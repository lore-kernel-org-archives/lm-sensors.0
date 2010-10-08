From: Chen Gong <gong.chen@linux.intel.com>
Date: Fri, 08 Oct 2010 05:53:34 +0000
Subject: [lm-sensors] update and cleanup patches for core{pkg, via}temp etc.
Message-Id: <1286517216-15640-1-git-send-email-gong.chen@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: JBeulich@novell.com, guenter.roeck@ericsson.com, linux-kernel@vger.kernel.org

[PATCH V2 1/2] hwmon: uniform the init style of pkgtemp
[PATCH V2 2/2] hwmon: cleanup some hotplug related macro definition

These 2 patches don't supply new functions, just unify the codes to avoid
potential issues and some cleanup work.

V2: fix some compile errors.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
