From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:09:40 +0000
Subject: Re: [lm-sensors] hwmon: (adm9240) Add individual alarm files
Message-Id: <20080131130940.GC8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154919.1290ac85@hyperion.delvare>
In-Reply-To: <20080106154919.1290ac85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-06 15:49:19 +0100]:
> The new libsensors needs these individual alarm files.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Grant Coady <gcoady.lk@gmail.com>
> ---
> Grant, could you please test and/or review this patch?
> 
>  drivers/hwmon/adm9240.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
