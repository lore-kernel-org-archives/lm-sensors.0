From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 May 2011 16:07:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <1305043677.31666.523.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-05-10 at 10:46 -0400, Martin Hicks wrote:
> This is a new driver for the INA219 current and power monitor.  This
> device does require manual configuration via sysfs files in order to
> provide the current and power information.  By default it does provide
> voltage information for the monitored bus.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>

Please have a look into Documentation/hwmon/submitting-patches
(available in the latest kernel from kernel.org) and follow the
guidelines listed there.

One item to add to that list: Don't configure a chip using sysfs
entries. Use platform data.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
