From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Sep 2013 13:53:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adcxx) Remove redundant spi_set_drvdata
Message-Id: <20130920135308.GA32421@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379650002-13127-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379650002-13127-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 20, 2013 at 09:36:41AM +0530, Sachin Kamat wrote:
> Driver core sets driver data to NULL upon failure or remove.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Marc Pignat <marc.pignat@hevs.ch>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
