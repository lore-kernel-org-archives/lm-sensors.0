From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 06:08:33 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53AA6761.3030300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403660391.31123.2.camel@phoenix>
In-Reply-To: <1403660391.31123.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/24/2014 10:57 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Tue, 24 Jun 2014 19:24:32 -0700, Guenter Roeck wrote:
>> On a side note, it appears the chip is long since obsolete, so I wonder
>> if anyone is still using it.
>
> It wasn't very popular back then either, so odds are indeed that the
> current user count is close to 0. However this isn't the only driver in
> that case, and I know of no policy to drop drivers just because of
> this. Being able to run on old hardware is a Linux feature.
>
> I think it only makes sense to drop drivers which have been heavily
> broken for a long time without nobody complaining, or which would
> require a major rework nobody is able to spend time on.
>

Agreed.

There was a discussion about deprecating old drivers a couple
of weeks ago on the kernel summit mailing list, but I don't think
people agreed on anything. Personally I am fine with keeping drivers
in the code base.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
