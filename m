From: Heiko Schocher <hs@denx.de>
Date: Tue, 17 Jun 2014 11:01:39 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for TI TMP103 temperature sensor
Message-Id: <53A02013.1060403@denx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402992713-22711-1-git-send-email-hs@denx.de> <53A01CE6.4010608@roeck-us.net>
In-Reply-To: <53A01CE6.4010608@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Hello Guenter

Am 17.06.2014 12:48, schrieb Guenter Roeck:
> On 06/17/2014 01:11 AM, Heiko Schocher wrote:
>> Driver for the TI TMP103.
>>
>> The TI TMP103 is similar to the TMP102. It differs from the TMP102
>> by having only 8 bit registers.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
> [ ... ]
>> +#define TMP103_CONF_SD (TMP103_CONF_M0 | TMP103_CONF_M1)
>
> Hello Heiko,
>
> I thought this needs to be TMP103_CONF_M1, but from the datasheet it looks
> like it does not matter if M0 is set if M1 is set as well. Did you test it,
> though, to make sure that it works ? I feel slightly uncomfortable with it.

Yes, i tested it on an imx6 based board. I see no issues ... but I can
test it with "#define TMP103_CONF_SD TMP103_CONF_M1" and post a v5 with
this setting if it works ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
