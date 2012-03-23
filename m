From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Mar 2012 02:41:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: max6639: Convert to dev_pm_ops
Message-Id: <20120323024124.GA27711@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332447838-30632-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 22, 2012 at 04:23:58PM -0400, Mark Brown wrote:
> The I2C specific PM operations have been deprecated and printing a
> warning on boot for over a year now.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/hwmon/max6639.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
Applied, thanks.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
