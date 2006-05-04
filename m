From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 04 May 2006 03:23:09 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new vt1211 driver
Message-Id: <4459739D.6080705@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
In-Reply-To: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello again,
>
> This is the first time after a week or so I have relatively free evening...
> I'm sorry for the delay, but again, too much stuff around here lately.
>
> I was speaking with Jean to become a co-maintainer so I could accept the patches 
> too, but I'm bit worried if I know enough to do that...
>
> Please check my comments. Generally the -1 stuff should be fixed, the ----
> lines should be a bit shorter and ARRAY_SIZE macro can be used. And alarm
> stuff should use the mapping arrrays...
>
> I'm not sure if I like the "combo" callbacks, but I'm not strictly aginst it.
>
> Regards
> Rudolf
>
>   
>
>> +		/* temp registers */
>> +		for (ix = 1; ix <= 7; ix++) {
>>     
>
> And Jims proposal for the "get rid of -1" is a good one too. And of course on 
> other places too.
>
>   
Its cartainly your call, but a single comment where its 1st used (in the 
SENSOR_ATTR_2 initialization)
will clear it up for everyone - and yourself after its actually coded 
that way ;-)
Its faster too, though unmeasureably..

IOW, your code could become

/* the -1 in ix-1 adjusts the 1 based attr enumeration under /sys/*
   to match 0-based arrays in C */

+#define SENSOR_ATTR_IN(ix) \
> +	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_INPUT, ix-1), \
> +	SENSOR_ATTR_2(in##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MIN, ix-1), \



WRT combo callbacks,
> Jim wrote that he likes the idea, well I'm myself still not convinced.
>
>   
Preferences aside, it saved me about 10% of the module's object code.
'It' 
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-January/015126.html
IE, it combined :
4 FAN_FNs into 1 show_fan() accessor
2 PWM_FNs,
4 IN_FNs into 1 show_in() accessor
2 IN_FNs in 1 set_in() mutator
5 THERM_FNs into 1 show_therm() accessor
5 TEMP_FNs into 1 show_temp()
5 TEMP_FNs into 1 set_temp()

IOW, lots of functions disappeared by use of combining.
One could reasonably expect 10% bloat if Juerg were to de-combine them.


> The classic 2D array grouping is more elegant in term of function, but bit 
> strange on the hand of array mapping/dimension.
>
>   
Yes, I too like 1D for array of identical sensors, 2nd D for FN-specifier.
Seems like what SENSOR_ATTR_2 was invented for.
But then, I already had the separate arrays of identical sensors. ;-)

IIRC, I asked Juerg about that, and he answered in a sense. (or maybe Im 
remembering someone else :-/)
I didnt quite get the argument ( I think he gains other advantages by 
his grouping strategy)
but I hadnt reviewed that diligently.
(to misquote a marvel-ous Spiderman saying: with no power comes no 
responsibility :-D

BTW, theres also real attribute_group's, IIRC Jean wrote some code to 
demonstrate its use,
but I cant find it now.

> This case is vice-versa data structures are nice function is bit more 
> complicated. I'm not telling you to remove it, but please at least change
> the default case to error and nr to some better name.
>   

Well, he did take the name from the sensor-attr-2 field,
but 'func' or 'funcidx' does seem better.
IIRC the nr name was chosen to deliberately not imply a specific use.
We're using it, we must know what for ;-)

thanks
jimc

