From: Chen Gong <gong.chen@linux.intel.com>
Date: Fri, 23 Jul 2010 02:09:25 +0000
Subject: [lm-sensors] hwmon: (coretemp) patches series V3
Message-Id: <1279850968-12154-1-git-send-email-gong.chen@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH V3 1/3] hwmon: (coretemp) update hotplug condition check
[PATCH V3 2/3] hwmon: (coretemp) enable coretemp device add operation failure
[PATCH V3 3/3] hwmon: (coretemp) documentation update and cleanup

V2 -> V3
patch 1/3: according to Jean's suggestion, delete _FROZEN bit from condition.
           Here is the reason: see commit id 561d9a96
patch 2/3: no update
patch 3/3: according to the suggestion from Guenter Roeck, clarify some stuff.

BTW, Hi Andrew, please apply this latest version if no further discussion.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
