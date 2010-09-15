From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 15 Sep 2010 16:34:47 +0000
Subject: Re: [lm-sensors] [patch 01/36] hwmon: New driver for the
Message-Id: <20100915163447.GB10422@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Sep 15, 2010 at 09:40:27AM -0400, Jean Delvare wrote:
[...]
> +module_init(sensors_w83795_init);
> +module_exit(sensors_w83795_exit);
> +
Nitpick but causes a whitespace error when integrating (empty last line),
which is then retained through the entire series.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
