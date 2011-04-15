From: wni@nvidia.com
Date: Fri, 15 Apr 2011 11:00:25 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon (lm90) add some function for lm90.
Message-Id: <1302865228-7185-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, guenter.roeck@ericsson.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, olofj@chromium.org, achew@nvidia.com, Wei Ni <wni@nvidia.com>

From: Wei Ni <wni@nvidia.com>

*** BLURB HERE ***

Wei Ni (3):
  hwmon: (lm90) Add suspend/resume support
  hwmon (lm90) Support to configure nct1008 from platform data
  hwmon (lm90) Add alarm function for nct1008

 drivers/hwmon/lm90.c    |  161 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nct1008.h |   39 +++++++++++
 2 files changed, 200 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/nct1008.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
