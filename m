From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 12 Sep 2013 15:18:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) remove unnecessary pci_set_drvdata()
Message-Id: <20130912151821.GA7126@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <001801ceaf83$d5633bb0$8029b310$%han@samsung.com>
In-Reply-To: <001801ceaf83$d5633bb0$8029b310$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 12, 2013 at 03:46:39PM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
