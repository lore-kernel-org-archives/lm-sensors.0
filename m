From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 01 Sep 2006 19:17:26 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks (plus 2D
Message-Id: <44F88746.6090801@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>> once again with the email-harvesting / communication/coordination.
>>
>> <quoting Jean, I think>
>>
>> BTW, do you have any plan to convert the asb100 driver to use the
>> "dynamic" sysfs callbacks? This would kill some more macros, and shrink
>> the driver size even more.
>>
>>
>>     

Heres a shorter, more accurate list, it finds the macro-repeated functions.
They're the biggest opportunity for code-shrink; N->1 for function bodies.

[jimc at harpo hwmon-stuff]$ grep -n 'static ssize_t' 
w83-1/drivers/hwmon/*.c |grep '##' | cut -d: -f1 | sort -u

w83-1/drivers/hwmon/adm1021.c
w83-1/drivers/hwmon/adm1025.c
w83-1/drivers/hwmon/adm1031.c
w83-1/drivers/hwmon/asb100.c
w83-1/drivers/hwmon/ds1621.c
w83-1/drivers/hwmon/fscher.c
w83-1/drivers/hwmon/fscpos.c
w83-1/drivers/hwmon/gl518sm.c
w83-1/drivers/hwmon/gl520sm.c
w83-1/drivers/hwmon/lm75.c
w83-1/drivers/hwmon/lm77.c
w83-1/drivers/hwmon/lm78.c
w83-1/drivers/hwmon/lm80.c
w83-1/drivers/hwmon/lm85.c
w83-1/drivers/hwmon/lm87.c
w83-1/drivers/hwmon/lm92.c
w83-1/drivers/hwmon/max1619.c
w83-1/drivers/hwmon/sis5595.c
w83-1/drivers/hwmon/smsc47b397.c
w83-1/drivers/hwmon/smsc47m1.c
w83-1/drivers/hwmon/via686a.c
w83-1/drivers/hwmon/w83627ehf.c
w83-1/drivers/hwmon/w83627hf.c
w83-1/drivers/hwmon/w83781d.c
w83-1/drivers/hwmon/w83791d.c
w83-1/drivers/hwmon/w83792d.c




>> drivers/hwmon/adm1026.c	 - patch on hold, needs tester.
>>     
>
> I had to discard it from my stack, it no more applies after Mark M.
> Hoffman's patch fixing unchecked return values.
>
>   
Ack. 

> I do not consider the dynamic sysfs callbacks conversion as "must be
> done". Of course drivers are nicer and smaller when done, but this is a
> significant work, and it needs complete testing, contrary to the
> unchecked return values fixes.
>
> So I wouldn't bother converting a driver unless you can test it. See
> what happened with the adm1026 driver, you converted it long ago,
> nobody ever tested it, and now the patch is discarded as it conflicts
> with other changes.
>
>   
Indeed - Nobody knew the patch was there, and I just discovered a 
potential tester
for it on-list just last week.  Hence this email ;-) .. and happily, 
this conversation.


Im hoping (against experience) that by doing these:

- identify drivers using macro repeated function defns
- show how to find the lines to look at (the above grep)
- discuss the technique ( 'dynamic' doesnt explain it, at least for me)

.. that I/we can lower the barrier to participation.
The task is still somewhat harder than the average janitorial patch,
(which may attract would-be hackers), and of course there are the
testing / validation issues (must have hardware).

<aside>  Testing by personal invitation has worked for me, at least once.
Yuan Mu from Winbond took a compile-tested patch from me, and finished it.
I aint too proud to beg ;-)  ..  (cues up some Rolling Stones ..)


>> *Deeper 'dynamic's are possible*
>>
>> The above folds multiple callbacks on 1 dimension (index)
>> to reduce code footprint, but more are possible.
>>
>>
>>
>> following 2 steps above:
>>
>> 1. function now relys on being passed a struct sensor_device_attribute_2
>> which has 2 additional parameters; index, and nr.  This example uses
>> 2nd parameter to distinguish which attribute of the sensor is being
>> requested (index still chooses 1 of N sensors)
>>  
>> static ssize_t show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
>> {
>>         struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>>         int idx = attr->index;
>>         int func = attr->nr;
>>         struct pc87360_data *data = pc87360_update_device(dev);
>>         unsigned res = -1;
>>
>>         switch(func) {
>>         case FN_FAN_INPUT:
>>                 res = FAN_FROM_REG(data->fan[idx],
>>                                    FAN_DIV_FROM_REG(data->fan_status[idx]));
>>                 break;
>>         case FN_FAN_MIN:
>>                 res = FAN_FROM_REG(data->fan_min[idx],
>>                                    FAN_DIV_FROM_REG(data->fan_status[idx]));
>>                 break;
>>         case FN_FAN_STATUS:
>>                 res = FAN_STATUS_FROM_REG(data->fan_status[idx]);
>>                 break;
>>         case FN_FAN_DIV:
>>                 res = FAN_DIV_FROM_REG(data->fan_status[idx]);
>>                 break;
>>         default:
>>                 printk(KERN_ERR "unknown attr fetch\n");
>>         }
>>         return sprintf(buf, "%u\n", res);
>> }
>>     
>
> As I mentioned earlier during the vt1211 review, I'm no big fan of this
> approach. You end up aggregating many features which don't share much
> code. It's still reasonable in your example above, but I think it has
> gone to an extreme in one case in the vt1211 driver. Let's not jump
> from one extreme to the other.
>
>   
As with everything else, its a judgement call -  Juerg used it for
show_in, set_in, show_temp, set_temp, show_fan, set_fan, show|set_pwm
He did not for many others.  In most places he did so, the combo-callback
was still ~30 lines, a pretty good indicator of clarity.

Also, the 'assignment' of callbacks (by SENSOR_ATTR*) is hugely flexible;
one could use a combo-callback to handle show-ops, but stick with 
dedicated callbacks
for store-ops.  This is perhaps subtle at 1st, but a 2 line comment 
could address that.

> I do agree that having a single callback for displaying fanN_input and
> fanN_min makes full sense, and this suggests a second level of
> indexing. But beyond that point I think we have to be reasonable. I
> don't mind for new drivers, authors should stay relatively free,
> however I strongly object to converting all our perfectly working
> drivers to use that approach.
>
>   
Uhm .. "strongly object" ?
Is it your intent to discourage patches of this nature ?  ( and by 
inference, other minor improvements ?)
I know you've got bigger fish to fry ( conversion to platform, etc - 
todo list forthcoming ? ;-)
and that review of combo-callback conversions is a non-zero cost upon you,
but surely you want to give objective incentives for folks to get involved.

For my part, your acceptance of my previous work is a big factor in my
hanging around here, and Id hope you'd regard those reviews as a 
successful investment,
beyond the X kB trimmed from 1 driver.  Even half-baked reviews (such as 
the ones
Ive offered) can result in brush-clearing (something our president is 
good at ;-)

> Beyond the readability of the code, there are some performance issues
> to consider. For example I wonder how the code above interacts with the
> CPU cache, compared to 1-level-indexed callbacks, in the typical
> "sensors" scenario. I don't really have the time to investigate this,
> unfortunately. Switch/case is usually not recommended in performance
> terms, even though I'd expect gcc to optimize it relatively nicely if
> the "func" values are chosen wisely.
>
>   
>> NB - technique saves ~ 9% object code on 1 driver.
>>     
>
> It really depends on where you come from for a given driver. But yes
> there's definitely a size reduction.
>
>   
Just to clarify, for anyone else reading this far..
That 9% number is using *2D combo-callbacks*, on top of a driver (pc87360)
that already employed the *dynamic callbacks* technique (see list at top),
which, iirc, saved 30-40%.  Of course, thats enormously dependent upon the
driver, but I feel compelled to point it out, esp as "strongly object" could
be misconstrued to apply to both kinds of patches, not just 
2D-combo-callbacks.

> The 2-index variants may be a problem because not all callbacks need 2
> parameters and mixing 0, 1 and 2-indexes attributes can become a mess.
> Using sysfs_create_group may help in that respect, because it
> manipulates pointers rather than the attributes directly.
>
> I have been thinking of a "standard hwmon attribute" which would
> combine our current sensor and sensor_2 attributes. I'll think again
> about it after we are done with the unchecked return values.
>
>   

interesting.  I played briefly with enums, but couldnt figure out how to 
do it
as a specialization/derivation of struct sensor_device_attribute.
maybe anonymous unions have a place here..

Thanks Jean
jimc

