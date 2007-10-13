From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 13 Oct 2007 16:50:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627hf) Fix setting fan min
Message-Id: <20071013165057.GH3994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071012215307.023857ff@hyperion.delvare>
In-Reply-To: <20071012215307.023857ff@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-10-12 21:53:07 +0200]:
> We need to read the fan clock dividers at initialization time,
> otherwise the code in store_fan_min() may use uninitialized values.
> That's pretty much the same bug and same fix as for the w83627ehf
> driver last month.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/w83627hf.c |   34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
