From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Jun 2014 16:07:43 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (tmp103) Add missing i2c_set_clientdata call in tmp103_probe
Message-Id: <53AD96CF.60909@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403880569.12833.1.camel@phoenix>
In-Reply-To: <1403880569.12833.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/27/2014 07:49 AM, Axel Lin wrote:
> Add missing i2c_set_clientdata() call in tmp103_probe, this makes the
> dev_get_drvdata() call in tmp103_suspend/tmp103_resume return correct
> address.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Good one. Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
