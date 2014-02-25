From: Wei Ni <wni@nvidia.com>
Date: Tue, 25 Feb 2014 06:21:39 +0000
Subject: [lm-sensors] [PATCH 0/2] expose lm90 to thermal fw
Message-Id: <1393309301-28337-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Expose lm90 to thermal framework via DT nodes.

The [PATCH 1/2] had reviewed in:
http://www.spinics.net/lists/linux-tegra/msg14108.html

Wei Ni (2):
  hwmon: (lm90) split set&show temp as common codes
  hwmon: lm90: expose to thermal fw via DT nodes

 drivers/hwmon/lm90.c |  228 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 173 insertions(+), 55 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
