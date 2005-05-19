From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: LM83 driver
Message-Id: <3F0AF329.1090405@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For no longer than the /proc standard is going to last (sysfs anyone) I think 
it would be much better to have a "dummy" value.

:v)

Mark D. Studebaker wrote:

> looks good.
> A couple of things I may have done differently -
> but that doesn't make the way you did it wrong :)
> 
> - You could have done one /proc callback function rather than 4
> - This is our first chip without two limits per sensor. To maintain our
>   /proc standard for temps we would need a 'dummy' second value between
>   the high limit and the reading. But if National did it, others will too,
>   so probably better to add to our /proc standard to say it could
>   be two values instead of three. Interesting.
> 
> 
> Jean Delvare wrote:
> 
>> If anyone could take a look at my code for the LM83, I'd appreciate it.
>> This is my first driver, as you must know. I followed the guidelines in
>> doc/developers/new_drivers, tried to follow the coding standards, but I
>> may have missed a few things.
>>
>> I propose the following changes to new_drivers file:
>>
>> - Change the recommended driver to use as a template. The writer should
>> use the driver that is the more similar to the chip he is writing a
>> driver for. I personally used much more the lm75 and adm1021 drivers
>> than the recommended lm78. And actually, using two different drivers as
>> templates was great.
>>
>> - Don't ask for testing with 2.2 kernels! Maybe we should add a line
>> about sending a 2.5 version (if possible) to Greg KH instead?
>>
> 

