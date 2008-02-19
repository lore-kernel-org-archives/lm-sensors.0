From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 19 Feb 2008 03:06:02 +0000
Subject: Re: [lm-sensors] [PATCH v2] adt7473: New driver for Analog
Message-Id: <20080219030602.GA2859@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071219034116.GM6870@tree.beaverton.ibm.com> <20071219154759.7be5025c@hyperion.delvare> <20071219231437.GR6870@tree.beaverton.ibm.com> <20080217200250.GD2916@jupiter.solarsys.private> <20080218213322.GD5784@tree.beaverton.ibm.com>
In-Reply-To: <20080218213322.GD5784@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick:

* Darrick J. Wong <djwong@us.ibm.com> [2008-02-18 13:33:23 -0800]:
> adt7473: New driver for Analog Devices ADT7473 sensor chip
> 
> This driver reports voltage, temperature and fan sensor readings
> on an ADT7473 chip.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/adt7473 |   79 +++
>  drivers/hwmon/Kconfig       |   10 
>  drivers/hwmon/Makefile      |    1 
>  drivers/hwmon/adt7473.c     | 1157 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1247 insertions(+), 0 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
