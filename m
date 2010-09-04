From: Scott Shanafelt <sgshanaf@gmail.com>
Date: Sat, 04 Sep 2010 15:25:18 +0000
Subject: Re: [lm-sensors] SuperMicro X7SPE-HF configuration
Message-Id: <0594F4D9-6919-42E6-A449-2275EAAB1CF8@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <70021574-9260-4E1E-88F8-AE313D6A94B8@gmail.com>
In-Reply-To: <70021574-9260-4E1E-88F8-AE313D6A94B8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the feedback, I'll adjust my implementation accordingly.

Scott

On Sep 4, 2010, at 9:42 AM, Jean Delvare wrote:

> Hi Scott,
> 
> On Mon, 30 Aug 2010 16:55:53 -0400, Scott Shanafelt wrote:
>> chip "w83627dhg-*"
>> 
>> 	label in0 "Vcore"
>> 	label in1 "Vnbcore"
> 
> This is "+1.05V" in SuperMicro's configuration file.
> 
>> 	label in2 "AVCC"
>> 	label in3 "3VCC"
>> 		set in3_min 3.3 * 0.90
>> 		set in3_max 3.3 * 1.10
>> 	label in4 "VDIMM"
>> 	label in5 "+5V"
>> 		compute in5 @*4, @/4
>> 	label in6 "+12V"
>> 		compute in6 @*16, @/16
>> 		set in6_min 12 * 0.90
>> 		set in6_max 12 * 1.10
>> 	label in7 "VSB"
> 
> Better labelled as "3V3B".
> 
>> 	label in8 "Vbat"
>> 
>> 	label fan1 "fan1"
>> 		ignore fan1
>> 	label fan2 "fan2"
>> 		ignore fan2
>> 	label fan3 "fan3"
>> 		ignore fan3
>> 	label fan4 "Case Fan"
>> 	label fan5 "fan5"
>> 		ignore fan5
> 
> Most of these labels are pointless, they are double no-ops (once
> because they don't carry any meaning, twice because you end up ignoring
> the input anyway.) What we want is fan locations, like:
> 
> 	label fan2 "CPU Fan"
> 	label fan4 "Case Fan"
> 
> We also don't want to ignore a fan which exists on the board but you
> happen to not use. "ignore fan2" shouldn't be there.
> 
>> 
>> 	label temp1 "MB Temp"
>> 	label temp2 "CPU Temp"
>> 	label temp3 "Case Temp"
>> 
>> 	ignore cpu0_vid
> 
> I've added an updated configuration file here:
> http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X7SPA
> 
> Thanks for your contribution.
> 
> -- 
> Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
