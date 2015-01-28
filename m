From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Jan 2015 14:50:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <54C8F73D.4040808@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>	<54B92596.2040206@roeck-us.net>	<20150116183020.GA6262@roeck-us.net>	<54C74567.9020201@axis.com>	<54C79B87.8040607@roeck-us.net>	<4BEA3FF3CAA35E408EA55C7BE2E61D05943B6DD753@xmail3.se.axis.com>	<20150127200553.GA5689@roeck-us.net> <20150127233455.0c62457e@endymion.delvare> <54C86035.9080605@roeck-us.net> <54C87F3C.2020105@axis.com>
In-Reply-To: <54C87F3C.2020105@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Rosengren <robert.rosengren@axis.com>, Jean Delvare <jdelvare@suse.de>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Johan Adolfsson <johana@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 01/27/2015 10:18 PM, Robert Rosengren wrote:

>>
> I tested the driver on 3.15 version of the kernel. Having looked in the git log of regmap.c and regmap-i2c.c, there has been some endianess-related patches going into the kernel in newer versions. Maybe that is the reason for me seeing this problem? I will try to look into that further.
>
> I my test I only disabled following two lines of code
>
> +	if (data->byte_swap)
> +		regval = swab16(regval);
>
Can you possibly send me the output from i2cdump ? That might help figuring out what is going on.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
