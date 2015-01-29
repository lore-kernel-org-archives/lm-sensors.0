From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 29 Jan 2015 07:05:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <54C9DBD5.5030808@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>	<54B92596.2040206@roeck-us.net>	<20150116183020.GA6262@roeck-us.net>	<54C74567.9020201@axis.com>	<54C79B87.8040607@roeck-us.net>	<4BEA3FF3CAA35E408EA55C7BE2E61D05943B6DD753@xmail3.se.axis.com>	<20150127200553.GA5689@roeck-us.net> <20150127233455.0c62457e@endymion.delvare> <54C86035.9080605@roeck-us.net> <54C87F3C.2020105@axis.com> <54C8F73D.4040808@roeck-us.net> <54C9DA9D.3010802@axis.com>
In-Reply-To: <54C9DA9D.3010802@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Rosengren <robert.rosengren@axis.com>, Jean Delvare <jdelvare@suse.de>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Johan Adolfsson <johana@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 01/28/2015 11:00 PM, Robert Rosengren wrote:
> On 01/28/2015 03:50 PM, Guenter Roeck wrote:
>> Can you possibly send me the output from i2cdump ? That might help figuring out what is going on.
> I don't have i2cdump (I suppose that you mean the lm-sensors tool) available for my hardware. I'll give it a go to compile it...
>

Ah, don't bother then. I should hopefully get the samples in a couple of days.

Is your hardware big endian or little endian ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
