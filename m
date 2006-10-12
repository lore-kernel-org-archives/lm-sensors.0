From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 12 Oct 2006 18:41:05 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min,
Message-Id: <452E8C41.8080204@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4529A56C.1030507@gmail.com>
In-Reply-To: <4529A56C.1030507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>>>> +static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
>>>>         
>>> Line too long, please fold. Same for all other callbacks you introduced.
>>>       
>> Ok.  I was under impression that fn-sigs were the sole exception
>> to the line-wrap rule, in that having the full sig on a single line is
>> good for grepping.
>>     
>
> No, there is no such exception. Line wrap indeed makes grep'ing more
> difficult in some cases, but Linus seems to care about the line length
> more than the grep'ability.
>
>   
Ok, thanks.
>> I'll guess that folding existing functions should be a separate patch ?
>> (combined with any other cosmetic changes, later)
>>     
>
> Yes, please.
>
>   
ok - Im thinking a full cosmetics patch, wrapping all long fn-sigs, 
dropping old comment,
>>> This callback is exactly the same as show_in_min_alarm above, so why
>>> don't you just reuse it? Same for show_therm_max_alarm below and
>>> show_in_max_alarm.
>>>
>>> Which made me check the current code, and it appears that
>>> show_therm_input, show_therm_min and show_therm_max are redundant with
>>> show_in_input, show_in_min and show_in_max, respectively, so the code
>>> could be simplified. And this is again true of "set" callbacks, unless
>>> I am overlooking something? The benefit is even bigger here as these
>>> callbacks are larger. Care to submit a patch?
>>>       
>> I was planning to fold them together in a 2D patch, like so:
>>
>> static ssize_t show_temp(struct device *dev, struct device_attribute 
>> *devattr, char *buf)
>> {
>>     struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>>     struct pc87360_data *data = pc87360_update_device(dev);
>>     int idx = attr->index;
>>     unsigned res = -1;
>>
>>     switch (attr->nr) {
>>     case FN_TEMP_INPUT:
>>         res = TEMP_FROM_REG(data->temp[idx]);
>>         break;
>>     
>>     default:
>>         dev_err(dev, "unknown attr fetch\n");
>>      }
>>      return sprintf(buf, "%u\n", res);
>>     
>
> How do you handle negative temperature values with a %u?
>
>   
Ahh, Id not noticed that b4..
To establish a true baseline, I went back to 2.6.13 (before I started 
hacking on this driver).
All of show_(in|therm)_<foo> use %u, which I also do in the 2D callbacks.
All the show_temp_<foo>s use /"%d\n" /in their respective formats, which 
I didnt do, but will.

FWIW show_temp_status also used %d rather than %u, the latter is better 
since status is flags.
Id prefer to ignore that preexisting sub-optimality (and use userspace 
bug-compatibility argument to support that)
rather than add a case-specific return sprintf() or fmt* indirection.



>> }
>>
>> This gets significant shrinkage..
>>   15902    5160      32   21094    5266 
>> 19rc1mm1-1/drivers/hwmon/pc87360.ko  --- this patch
>>     
>
> What is "this patch" exactly?
>   
the previously sent patch - adding separate alarms.

>   
>>   14011    5160      32   19203    4b03 
>> 19rc1mm1-2/drivers/hwmon/pc87360.ko  --- 2D patch
>>
>> This folding doesnt rely on thermistor measurements being done with voltage
>> hardware, which is an ideosyncrasy of this particular part, and doesnt 
>> work for the temp_ sensors (only the therm ones), so I think its clearer
>> and more general this way.
>>     
>
> Actually, thermistor measurements are always being done with voltage
> hardware, by design. What may be surprising is that the chip doesn't
> attempt to abstract this to make temperatures look more like
> temperatures.
>
> As said before, I'm not a fan of this switch/case approach, as it looks
> suboptimal from a performance point of view (unless you can prove me
> wrong with actual data). I did not object for the vt1211 driver because
> it was a new driver, and the author prefered it that way, so why not,
> but I see little benefit in converting a perfectly working driver to a
> different approach when both approaches have drawbacks and benefits.
>
>   
1st, the size arg:

[jimc at harpo hwmon-stuff]$ size 19rc1mm1-*/drivers/hwmon/pc87360.ko
   text    data     bss     dec     hex filename
  14474    3816      32   18322    4792 19rc1mm1-0/drivers/hwmon/pc87360.ko
  15902    5160      32   21094    5266 19rc1mm1-1/drivers/hwmon/pc87360.ko
  15046    5160      32   20238    4f0e 
19rc1mm1-1-fold/drivers/hwmon/pc87360.ko
  14011    5160      32   19203    4b03 19rc1mm1-2/drivers/hwmon/pc87360.ko

0 - virgin rc1-mm1
1 - separate alarms
1-fold - with in/therm redundancy folded out
2 - 2D callbacks

As is evident, 2D gives 2x the size reduction as in/therm folding,
and I think its clearer.  (also refactoring the status touching cases, 
and sharing
that across in/therm is possible, but of tiny benefit in size, and a 
loss of clarity imho)

As to performance (ie cache performance), the rule-of-thumb is that 
smaller is better
(consider that force_inline is needed, cuz gcc sometimes ignores inline, 
cuz its often a lose).

Beyond that, the access pattern from userspace is to read all the attrs 
from each sensor,
then move to next sensor.  For separate callbacks, this is the worst 
pattern - each separate
callback has opportunity to eject the previous from cache, whereas with 
2D callbacks,
the same function is re-called (more likely to still be in cache), and 
each case is likely to
have separate cache-lines (adjacent code --> adjacent cache-line)

I could derive some value from trying to prove this (and learn to wield 
oprofile well,
or cachegrind - but Im not set up to run a UML/xen-guest kernel, esp on 
my 586-266 8-)
but GregKH has dismissed the cache effects as unimportant, so for now, 
its *much* easier
to talk thru it.  Do you find the previous paragraph at all convincing ?
Is there another aspect of performance that Ive overlooked ?


>>>> -	/* include the few miscellaneous atts here */
>>>>         
>>> This comment can stay for now?
>>>       
>> Its less true than it once was - few is one, and not so miscellaneous -
>> temp-alarms belongs with temp_*, and comment implies that its something 
>> of a catch-all. 
>> At least that was my mis-thinking when I 1st added it.
>>
>> Or did you mean drop it *later* ?
>>     
>
> No, I'm fine with that. I thought it was a left over from the first
> patch attempt, but if you remove it on purpose it's OK.
>
> (Indeed it then becomes a cleanup change without direct relation with
> what the patch does. But nevermind.)
>   
Ok - I can restore it now, and pull it later - in a following 
cosmetics/rewrap patch.

Id rather get your provisional acceptance of this separate-alarms patch,
2- then send my 2D for review (which applies cleanly over this one),
3- then do the rewrap,
4- then add fan_alarms (which dont exist currently BTW - only in_alarms 
and temp_alarms do)
5- then do platform_driver (or maybe isa_driver, since is now in-core)

since 3,4,5 are dependent on how 2 goes, I havent touched them yet..



