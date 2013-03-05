From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Mar 2013 06:43:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: mc13783-adc: Use module_platform_driver_probe macro
Message-Id: <20130305064302.GB10027@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362459560-13444-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1362459560-13444-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 05, 2013 at 10:29:20AM +0530, Sachin Kamat wrote:
> module_platform_driver_probe() eliminates the boilerplate and simplifies
> the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Hi Sachin,

The same patch was already submitted a couple of hours earlier....
so I applied that one.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
