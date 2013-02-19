From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 16:45:07 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (ntc_thermistor): Fix sparse warnings
Message-Id: <20130219164507.GA19550@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361266654-25960-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1361266654-25960-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 19, 2013 at 01:35:52PM +0100, Jean Delvare wrote:
> On Tue, 19 Feb 2013 15:07:34 +0530, Sachin Kamat wrote:
> > Fixes the following sparse warnings:
> > drivers/hwmon/ntc_thermistor.c:46:31: warning:
> > symbol 'ncpXXwb473' was not declared. Should it be static?
> > drivers/hwmon/ntc_thermistor.c:82:31: warning:
> > symbol 'ncpXXwl333' was not declared. Should it be static?
> > 
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Guenter, it happens that I have exactly 0 patches in my hwmon queue for
> kernel 3.9. So I'll skip my turn on this one and let you handle all the
> hwmon patches which should go in 3.9.
> 
No problem.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
