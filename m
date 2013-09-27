From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Sep 2013 16:38:59 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (gpio-fan) Include linux/of.h header
Message-Id: <20130927163859.GA11592@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380281160-7560-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380281160-7560-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 27, 2013 at 04:56:00PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
