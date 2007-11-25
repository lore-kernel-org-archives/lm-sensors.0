From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Use generic i2c reads	during
Message-Id: <20071125015358.GM13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071025000543.67dc6edb@hyperion.delvare>
In-Reply-To: <20071025000543.67dc6edb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-25 00:05:43 +0200]:
> As indirectly reported by Olof Johansson, the lm90 driver uses a
> custom i2c read function even during detection, at which point we
> don't know yet what device we're talking with. It would make more
> sense to only use the generic i2c read function at this point, so
> that we don't log irrelevant errors on misdetection.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm90.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
