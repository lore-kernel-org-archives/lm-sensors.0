From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 19 Jun 2010 17:59:35 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add JZ4740 ADC driver
Message-Id: <4C1D0587.7030308@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276924111-11158-24-git-send-email-lars@metafoo.de>        <1276958820-8862-1-git-send-email-lars@metafoo.de> <20100619182410.171856ae@hyperion.delvare>
In-Reply-To: <20100619182410.171856ae@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi

Jean Delvare wrote:
> Hi Lars-Peter,
>
> On Sat, 19 Jun 2010 16:47:00 +0200, Lars-Peter Clausen wrote:
>   
>> This patch adds support for reading the ADCIN pin of ADC unit on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: lm-sensors@lm-sensors.org
>>
>> --
>> Changes since v1
>> - Move ADC core access synchronizing from the HWMON driver to a MFD driver. The
>>   ADC driver now only reads the adcin value.
>> Changes since v2
>> - Add name sysfs attribute
>> - Report adcin in value in millivolts
>>     
>
> Changes look good. A few more comments below; other than these, your
> driver look good, and I can add it to my hwmon tree and schedule it for
> 2.6.36 if you want.
>   
Great thanks :)
As written in the introduction mail to this thread it would be good if
the majority of the patches could go through Ralfs tree. So if you don't
see any problems doing this, it would be nice if you could give your
Acked-By once I sent a updated patch.

- Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
