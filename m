From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Jan 2012 18:04:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm87) Reorganize the code
Message-Id: <1327601075.2649.220.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120126154149.46793cc7@endymion.delvare>
In-Reply-To: <20120126154149.46793cc7@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-01-26 at 09:41 -0500, Jean Delvare wrote:
> Reorder functions and driver declaration to no longer need to
> forward-declare functions. Also rename new_client to just client
> everywhere for readability.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> This goes on top of Guenter's two lm87 patches:
> hwmon: (lm87) Fix checkpatch issues
> hwmon: (lm87) Fix: do not use assignment in if condition
> 
>  drivers/hwmon/lm87.c |  351 +++++++++++++++++++++++---------------------------
>  1 file changed, 165 insertions(+), 186 deletions(-)
> 
Applied to -next. I'll keep the lm87 patches there until 3.4 - too much
change after all for a rc.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
