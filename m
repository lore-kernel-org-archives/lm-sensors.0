From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 20:59:34 +0000
Subject: [lm-sensors] [PATCH 0/3] i2c rtc updates for 2.6.17
Message-Id: <20060331225934.999a5425.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here are three patches to i2c rtc drivers, which should go in 2.6.17.
They fix cases where tasklets are used when they shouldn't be, so we
have to replace them with workqueues. Last one is a simple cleanup
patch, which can go in too. Thanks.

Summary:

Jean Delvare:
 o i2c: convert ds1374 to use a workqueue

Mark A. Greer:
 o i2c: convert m41t00 to use a workqueue
 o i2c: cleanup m41t00

Statistics:

 drivers/i2c/chips/ds1374.c |   16 +++++++----
 drivers/i2c/chips/m41t00.c |   65 ++++++++++++++++++++------------------------
 2 files changed, 40 insertions(+), 41 deletions(-)

-- 
Jean Delvare

