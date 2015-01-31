From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Jan 2015 20:11:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <54CD36DF.7010602@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <54C79B87.8040607@roeck-us.net>	<4BEA3FF3CAA35E408EA55C7BE2E61D05943B6DD753@xmail3.se.axis.com>	<20150127200553.GA5689@roeck-us.net>	<20150127233455.0c62457e@endymion.delvare>	<54C86035.9080605@roeck-us.net> <54C87F3C.2020105@axis.com>	<54C8F73D.4040808@roeck-us.net> <54C9DA9D.3010802@axis.com>	<54C9DBD5.5030808@roeck-us.net> <54CA226E.6080505@axis.com> <20150129193040.GA21937@roeck-us.net>
In-Reply-To: <20150129193040.GA21937@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Rosengren <robert.rosengren@axis.com>
Cc: Johan Adolfsson <johana@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 01/29/2015 11:30 AM, Guenter Roeck wrote:
> On Thu, Jan 29, 2015 at 01:07:10PM +0100, Robert Rosengren wrote:
>>
>>>
>>> Is your hardware big endian or little endian ?
>> CONFIG_CPU_LITTLE_ENDIAN=y
>>
> Hi Robert,
>
> I have another question: What is your i2c controller type ?
>

Robert,

I now tried both 3.15 and 3.19-rc6. Both kernels require the byte swap code.

The only reason I can imagine why you don't need it in your code would be
that your i2c controller does not support i2c functionality but only SMBus.
This would be the case, for example, with the i801 controller. So it would
be quite helpful to know which controller your system uses to access the
ads7828.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
