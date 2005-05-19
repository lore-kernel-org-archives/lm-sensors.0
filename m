From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [BK PATCH] I2C update for 2.6.9
Message-Id: <dLpBLFBx.1098287861.7976600.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20041020001603.GA11393@kroah.com>
References: <20041020001603.GA11393@kroah.com>
In-Reply-To: <20041020001603.GA11393@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com


Hi Greg,

>Here are some i2c driver fixes and updates for 2.6.9.  There is a new
>chip and a new bus driver, as well as a bunch of minor fixes.  The
>majority of these patches have been in the past few -mm releases.

It looks like only three of these patches actually hit the lm_sensors
mailing-list, and I don't see any (not even this annoucement) on the
LKML. Could it be that your patch generator went bad somehow?

Thanks,
Jean
