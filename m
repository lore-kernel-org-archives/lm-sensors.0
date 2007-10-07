From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 07 Oct 2007 15:42:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm87: Fix a division by zero
Message-Id: <20071007154245.GD3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070926221656.6442f1b2@hyperion.delvare>
In-Reply-To: <20070926221656.6442f1b2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-05 09:33:09 +0200]:
> Hi All,
> 
> In this post:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021288.html
> 
> Jean Delvare wrote:
> --------------------------------------------
> Missing parentheses in the definition of FAN_FROM_REG cause a division
> by zero for a specific register value.
> 
> Signed-off-by: Jean Delvare <khali at linux-fr.org>

(...)

> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
