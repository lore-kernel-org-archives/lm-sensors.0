From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 16 Apr 2011 14:58:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Change I2C detection class
Message-Id: <20110416145824.GA30992@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110416141713.333d6e51@endymion.delvare>
In-Reply-To: <20110416141713.333d6e51@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 16, 2011 at 08:17:13AM -0400, Jean Delvare wrote:
> While the JC42-compatible chips are temperature sensors, I2C_CLASS_SPD
> makes more sense because these chips always live on memory modules.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
> Guenter, what do you think?
> 
I don't know. Seems odd to define a device based on its location instead of its functionality.

What is the device class used for anyway ? I browsed through the code, but did not find it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
