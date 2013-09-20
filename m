From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Sep 2013 13:53:36 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm70) Remove redundant spi_set_drvdata
Message-Id: <20130920135336.GB32421@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379650002-13127-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379650002-13127-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 20, 2013 at 09:36:42AM +0530, Sachin Kamat wrote:
> Driver core sets driver data to NULL upon failure or remove.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Kaiwan N Billimoria <kaiwan@designergraphix.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
