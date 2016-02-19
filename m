From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 19 Feb 2016 22:26:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Handle negative conversion values correctly
Message-Id: <20160219222624.GA11862@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1455800872-24431-1-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1455800872-24431-1-git-send-email-peda@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@lysator.liu.se>
Cc: Dirk Eibach <eibach@gdsys.de>, Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Thu, Feb 18, 2016 at 02:07:52PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Make the divisor signed as DIV_ROUND_CLOSEST is undefined for negative
> dividends when the divisor is unsigned.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/hwmon/ads1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
