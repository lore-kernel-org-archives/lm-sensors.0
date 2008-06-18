From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Wed, 18 Jun 2008 19:14:58 +0000
Subject: Re: [lm-sensors] [PATCH] thmc50: extend numbers of handled
Message-Id: <20080618211458.6620601b.krzysztof.h1@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080614134129.ea9f896a.krzysztof.h1@poczta.fm>
In-Reply-To: <20080614134129.ea9f896a.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 15 Jun 2008 14:28:20 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Krzysztof,

> On Sat, 14 Jun 2008 13:41:29 +0200, Krzysztof Helt wrote:
>> From: Krzysztof Helt <krzysztof.h1 at wp.pl>
>> 
>> This patch extends number of handled temperatures
>> from 1 to 3. It is needed for upcoming support of
>> the thmc51 sensor.

> This wording is a bit confusing. It makes the reader believe that your
> driver was originally supporting 1 temperature and that it now supports
> 3 temperatures. That's not the case. Maybe you can rephrase this
> comment a bit to make it clearer what the patch really does.

I'll do.

>> diff -urp linux-old/drivers/hwmon/thmc50.c linux-new/drivers/hwmon/thmc50.c
>> --- linux-old/drivers/hwmon/thmc50.c	2008-06-11 22:28:55.205753933 +0200
>> +++ linux-new/drivers/hwmon/thmc50.c	2008-06-11 22:29:44.973748412 +0200
>> @@ -69,7 +69,7 @@ struct thmc50_data {
>>  	struct mutex update_lock;
>>  	enum chips type;
>>  	unsigned long last_updated;	/* In jiffies */
>> -	char has_temp3;		/* !=0 if it is ADM1022 in temp3 mode */
>> +	char temp_num;		/* THMC51 = 1, ADM1022 = 2 or 3, otherwise 2 */
>>  	char valid;		/* !=0 if following fields are valid */
>>  
>>  	/* Register values */

>This works, but I don't think this is the right strategy. This assumes
>that, when a chip has N temperatures, they are always the same ones.

Not exactly. It assumes that temperatures are sequential (1-2 or 2-3 or 1-3 or
a single one).

> And seeing the code below:

>> @@ -446,13 +448,12 @@ static struct thmc50_data *thmc50_update
>>  	if (time_after(jiffies, data->last_updated + timeout)
>>  	    || !data->valid) {
>>  
>> -		int temps = data->has_temp3 ? 3 : 2;
>>  		int i;
>>  		int prog = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
>>  
>>  		prog &= THMC50_REG_CONF_PROGRAMMED;
>>  
>> -		for (i = 0; i < temps; i++) {
>> +		for (i = 0; i < data->temp_num; i++) {
>>  			data->temp_input[i] = i2c_smbus_read_byte_data(client,
>>  						THMC50_REG_TEMP[i]);
>>  			data->temp_max[i] = i2c_smbus_read_byte_data(client,

>it also assumes that temp1 is always there, which we already know is
>not the case of the THMC51, which has temp2 but no temp1. Unless you
>renumber the input for this one chip, but then you lose most of the
>benefit of having a single driver supporting many chips.

This patch does not bring the full thmc51 support. It only changes
one thing to make it easier later.

You don't see the rest of the patch for thmc51 support. A simple 
change like this:

+       int temp_start = (data->type = thmc51) ? 1 : 0;
-       for (i = 0; i < data->temp_num; i++) {
+       for (i = temp_start; i < temp_start + data->temp_num; i++) {

does support all four chips (thmc51, thmc50, adm1022, adm1028).

> So I would like to suggest a different strategy which we already use in
> many drivers: have a data->has_temp bitfield. Each bit set corresponds
> to one temperature channel present. So, value would be 0x03 for the
> THMC50 and ADM1022 (temp1 and temp2), 0x07 for the ADM1022 in 3-temp
> mode (temp1, temp2 and temp3), and 0x02 for the THMC51 (temp2 only.)
> The code will be longer.

Much longer as the reading loop has to be unrolled then. A simpler solution
is to use a table (e.g. byte table) and set 1 for index with available temperature.
It won't require to unroll the loop, but it will make other parts of code longer
(when sensors are detected). I don't think it is worth effort for the thmc51 only.

> The advantage of this approach is that it's very flexible. You can
> support any combination of temperature channels, so adding support for
> new chips is straightforward.

It is always possible to switch to another approach if any unknown sensor
requires this (say thmc52).

I will redo description for this patch.

Regards,
Krzysztof

----------------------------------------------------------------------
Wylicytuj bilet i spotkanie z The Police!
kliknij >>> http://link.interia.pl/f1e3c


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
