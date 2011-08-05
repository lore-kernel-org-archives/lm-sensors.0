From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Aug 2011 16:55:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add caseopen detection to w83627ehf
Message-Id: <1312563350.9971.123.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312549243-7503-1-git-send-email-mad_soft@inbox.ru>
In-Reply-To: <1312549243-7503-1-git-send-email-mad_soft@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Ian Dobson <i.dobson@planet-ian.com>, Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2011-08-05 at 09:00 -0400, Dmitry Artamonow wrote:
> Export caseopen alarm status into userspace for
> Winbond w83627* chips and also implement alarm clear knob.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

[ ... ]

> +static ssize_t
> +store_caseopen_clear(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)

Another note: Please drop the "_clear" from the function name. It is
redundant with "store_". Another possible name would be
"clear_caseopen".

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
