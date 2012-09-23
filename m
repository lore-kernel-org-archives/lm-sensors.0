From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Sep 2012 18:41:23 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.6
Message-Id: <20120923204123.20edef90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.6 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/coretemp.c     |    5 +++++
 drivers/hwmon/fam15h_power.c |   15 +++++++++++++--
 drivers/hwmon/via-cputemp.c  |    5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

---------------

Andreas Herrmann (1):
      hwmon: (fam15h_power) Tweak runavg_range on resume

Silas Boyd-Wickizer (2):
      hwmon: (via-cputemp) Use get_online_cpus to avoid races involving CPU hotplug
      hwmon: (coretemp) Use get_online_cpus to avoid races involving CPU hotplug

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
