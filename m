From: Donggeun Kim <dg77.kim@samsung.com>
Date: Tue, 21 Jun 2011 01:35:11 +0000
Subject: Re: [lm-sensors] [PATCH v10] drivers/hwmon NTC Thermistor Initial
Message-Id: <4DFFF54F.30300@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308556099-26761-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308556099-26761-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 06월 21일 05:20, Guenter Roeck wrote:
> On Mon, 2011-06-20 at 03:48 -0400, Donggeun Kim wrote:
>> This patch adds support for NTC Thermistor series. In this release, the
>> following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
>> and NCP15WL333. This driver is based on the datasheet of MURATA.
>>
>> The driver in the patch does conversion from the raw ADC value
>> (either voltage or resistence) to temperature. In order to use
>> voltage values as input, the circuit schematics should be provided
>> with the platform data. A compensation table for each type of thermistor
>> is provided for the conversion.
>>
>> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
> 
> Applied to -next.
> 
> Thanks,
> Guenter
> 
> 
> 
Thanks for your thorough review.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
