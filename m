From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Aug 2006 13:53:41 +0000
Subject: [lm-sensors] [PATCH 0/5] Updates and fixes to the it87 driver
Message-Id: <20060808155341.0ceb1196.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here are 5 patches to the it87 driver, which I will push to -mm soon
and plan to have merged in 2.6.19.

 Documentation/hwmon/it87 |   40 +++++++---
 drivers/hwmon/Kconfig    |    4 
 drivers/hwmon/it87.c     |  185 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 171 insertions(+), 58 deletions(-)

Testers and comments welcome.

-- 
Jean Delvare

