From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 05 Jan 2006 08:12:40 +0000
Subject: [lm-sensors] hwmon-sensor-attr-array-2.patch
Message-Id: <43BCD4F8.70602@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43B306FB.9040301@gmail.com>
In-Reply-To: <43B306FB.9040301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jim Cromie wrote:
> Hans de Goede wrote:
> 
> 
> what the hey, Ill give it a cursory look.
> 

Thanks

> dont feel the need to ack whatever I say here (I havent started yet),
> unless you want to disagree.
> 
> I assume Jean will eventually get to it, but perhaps I can save him a 
> few words.
> Hopefully Im not so far off base that he spends them correcting me ;-)
> 
> 
> 1.  strip trailing whitespace :-O
>    Im just saying it preemptively.
> 

There shouldn't be any, I myself dislike it too.

> 
> 
> 
> strip macro eventually.
> 
>> /* This is needed untill this gets merged upstream */
>> #ifndef SENSOR_ATTR_2
>> #define SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)    \
>>     { .dev_attr = __ATTR(_name, _mode, _show, _store),    \
>>       .index = _index,                    \
>>       .nr = _nr }
>> #endif
>>
>>  
>>
> 

Once a mainstream kernel is released with this macro I will.

>> /* Debugging output level:
>>   0 no debug output
>>   1 log errors with printk
>>   2 also log sensors type probing info
>>   3 log retryable errors
>>   This is at 2 for now, since this driver is still in the testing fase */
>> #define ABIT_UGURU_DEBUG_LEVEL    2
>>  
>>
> make this a module-param ?
> how much object code does it add ?
> maybe a param, which is also gated by ifdefs
> (or a debug_() macro to hide ifdefs) ?
> 

A macro to hide all the ifdefs is a good idea, making it a param then is 
easy, the added objectcode will mostly be all the strings, there is a 
definite win in using to preprocessor to strip all these. Dunno if the 
win is worth it though, I don't know how important object size is these 
days.

> see dev_dbg, for a start, though I think youll want to
> wrap it so that you can pass in a level 1,2,3,
> while keeping 1 ifdef to remove the debug-code entirely.
> 
> $ grep dev_dbg pc87360.c
>                dev_dbg(&new_client->dev, "Using %s reference voltage\n",
>                                dev_dbg(&client->dev, "Forcibly "
>                                dev_dbg(&client->dev, "Forcibly "
>                                        dev_dbg(&client->dev, "Skipping "
>                                        dev_dbg(&client->dev, "Forcibly "
> 
> 
> 
> 

I think using dev_dbg is an idea, wrapped with the debug level thingie I 
use.

> 
> 
>> /* For the Abit uGuru, we need to keep some data in memory.
>>   The structure is dynamically allocated, at the same time when a new
>>   abituguru client is allocated. */
>>  
>>
> do you foresee / have you tried  multiple chips ?
> 

No and no, but I wanted to:
-do things identical to other drivers for readability
-want to keep the option of multiple chips open for the future

> 
>> /* Put the uguru in ready for input state, this code assumes that
>>   the uguru is not already in this state.
>>   It is the callers responsibility to make sure it isn't! */
>>  
>>
> 
> what do you save by making this assumption ?
> yes its static, so less ripe for abuse, but if its 1 flag ..
> 

The problem is there is no way to ask the uGuru if its ready, I keep a 
ready flag which gets cleared when we're talking to it and set when 
we've successfully put it back in ready state, this function could check 
the flag, but it currently is never called when that flag is set.

Besides the flag there is no way to know thus the caller should know 
what it is doing, just like other functions should clear the ready flag 
as soon as they do something with the uGuru. The comment is there in an 
attempt to make people aware of this.

Also doing a ready cycle when the uGuru already is ready can't hurt.
(AFAIK remember this is a reverse engineered driver).

> 
> 
> 
> 
> 
>>         /* The first try the uguru normally will be ready for the first
>>            input and thus in ABIT_UGURU_STATUS_INPUT state. If however
>>            something went wrong previously it might not be, so then we
>>            try to force it into ready state.
>>  
>>
> 
> is this forcing something the user should have to explicitly enable ?
> 

No, normally after a successfull data exchange (read or write) with the 
uGuru the uGuru gets put back in ready state, so the first try to start 
a data transfer (which starts with sending the bank and sensor address) 
the ready flag will be one and the code below the comment:
             if (!data->uguru_ready && (abituguru_ready(client) != 0))
                         return -EIO;

Will do nothing, if sending the address fails and the caller of
abituguru_send_address has specified that he wants to retry the second 
and later tries the ready flag will be 0 and the uguru will be put back 
into ready state before retrying.

> 
> 
>> /* Following are the sysfs callback functions. These functions use
>>   sensor_device_attribute_2->nr and sensor_device_attribute_2->index
>>   in the following ways:
>>         nr selects             index selects
>> _value/pwm_*    NA                sensor/pwm *
>> _setting    auto/min/max       (offset)    sensor/pwm
>> _alarms/_mask    beep/shutdown/flag (bitmask)    sensor_type 
>> (volt/temp) **
>>
>>   *)  Except for pwm_setting which uses nr and index as _setting
>>   **) NA for bank2 as bank2 only contains fan sensors */
>>  
>>
> 
> following are nearly identical
> 
>> static ssize_t show_bank1_value(struct device *dev,
>>     struct device_attribute *devattr, char *buf)
>>
>> static ssize_t show_bank1_setting(struct device *dev,
>>     struct device_attribute *devattr, char *buf)
>>
>> static ssize_t show_bank2_value(struct device *dev,
>>     struct device_attribute *devattr, char *buf)
>>
>>  
>>

I've thought about merging these too, but there actually a number of 
subtile differences which when all added together make it easier to just 
keep 2 versions:
-bank1 and bank2 have a different address
-bank1 settings contain 3 bytes, bank2 settings 2
-bank1 contains both temp and volt sensors, when showing or storing a
  mask like beep_mask_in_low / shutdown_mask_temp, etc. We don't apply
  bit 0 of the mask to sensor 0 etc, but we do this indirectly addressed
  through data->bank1_address[attr->index][i] where attr->index selects
  the sensortype (in or temp) and i selects the i-th sensor, this makes
  bit 0 of shutdown_mask_temp correlate to temp1, bit 1 to temp2 etc,
  instead of the alarm mask is chip specific, use the chip specific
  defines hell other drivers have, also see sysfs-interface-proposal,
  which is all about this. Not having the define hell is the only way
  for the uGuru as what kinda sensor (in or temp) is attached to which
  address is determined on driver load and can change from mb to mb.

  bank2 otoh is straight, so bit 0 is fan1, bit1 fan2 etc, to use the
  same code for bank2 I would need to create an 1x6 2 dimensional array
  with bank2_address and just fill this with 0,1,2,3,4,5 . Which IMHO is
  ugly.
-bank1 has 1 alarm bit per sensor, and extra bits in the sensor settings
  bank which can be used to determine if its a in low or in high alarm,
  bank2 does not have these extra bits in its sensor settings bank

So they are not quite the same, some functions differ more between banks 
then others but for readability I've choosen to keep them all seperate.

> + others below I think.   it looks like attr->index, and bank 1,2  could 
> drive a constants & formula
> lookup to provide many calcs reachable by 1/few handers.
> 
> 
> Im beginning to think you could make good use of SENSOR_ATTR_4,
> which Jean blue-sky'd, but you could make concrete easily.
> 
> with it, you could squeeze these many handlers down to a few,
> doing scale and offset lookups and calcs, forex.
> 

I might be able todo that, but the objectsize would probably only grow 
since the remaining functions stand a good chance of getting more then 2 
times bigger, and the code would get much more complicated. The bank1 
code currently already is complicated with the dynamicly detecting 
senortype stuff and indirect addressing for masks, and I for one am all 
for KIS .

> 
> PS.  what boxes have this chip in them ?
> /me thinks it might be in comments.
> /me should just look myself, instead of asking :-O
> 

All rescent Abit motherboards, for an unannounced driver it actually 
already has quite a few users who all found it be actively looking for 
it and finding it on the mailinglist.

Thanks & Regards,

Hans

