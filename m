From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Apr 2011 21:38:14 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (sht15) clean-up the probe
Message-Id: <1302817094.26780.579.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302636879-16615-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302636879-16615-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-04-12 at 15:34 -0400, Vivien Didelot wrote:
> * Move the creation of sysfs attributes after the end of the
>   initialization, and remove them in the error path.
> * Release regulator in the error path.
> * Add a soft reset command (need to wait 11ms before next command).
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
