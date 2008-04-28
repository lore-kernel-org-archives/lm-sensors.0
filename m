From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 28 Apr 2008 17:33:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7473) Initialize
Message-Id: <20080428173336.GE16078@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080426163426.7684ce5d@hyperion.delvare>
In-Reply-To: <20080426163426.7684ce5d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 26, 2008 at 04:34:26PM +0200, Jean Delvare wrote:
> data->max_duty_at_overheat is not updated in adt7473_update_device,
> so it might be used before it is initialized (if the user reads from
> sysfs file max_duty_at_crit before writing to it.)
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Darrick J. Wong <djwong@us.ibm.com>

Thanks for catching this.  Looks/compiles/seems to run ok, so:
Acked-by: Darrick J. Wong <djwong@us.ibm.com>

As for !! vs (?:), I don't have any particular preference.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
