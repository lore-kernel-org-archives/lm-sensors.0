From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 16 Feb 2007 06:35:45 +0000
Subject: [lm-sensors] [patch 2.6.20-git] hwmon should use subsys_init
Message-Id: <20070216073545.75916671.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200702151603.13810.david-b@pacbell.net>
In-Reply-To: <200702151603.13810.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 15 Feb 2007 16:03:13 -0800, David Brownell wrote:
> The hwmon subsystem registers itself excessively late when it's not linked
> as a module.  That can cause problems when multifunction chips, that happen
> to have hwmon capabilities and live outside the hwmon subdirectory, need to
> initialize earlier than on various platforms.
> 
> This patch makes the hwmon subsystem code register itself appropriately early:
> as a subsystem, like other subsystems.

This patch is already in my tree and planned for inclusion in kernel
2.6.21. I asked Linus to pull the hwmon updates (including this one)
from my tree two days ago but he did not yet. I'll ask him again
tomorrow if needed.

Thanks,
-- 
Jean Delvare

