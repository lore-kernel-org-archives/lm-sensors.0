From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 20 May 2006 11:46:40 +0000
Subject: [lm-sensors] Question about the new sysfs alarm interface
Message-Id: <446F01A0.3060707@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <446D7AD5.2080405@hhs.nl>
In-Reply-To: <446D7AD5.2080405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean Delvare wrote:
> Hi Hans,
> 
>> I've finally made the time to convert the abituguru driver to the new
>> alarm sysfs interface however the uguru has 2 alarms for each voltage
>> input, a volt low and a volt low alarm, currently I create the following
>> for these:
>> in0_alarm_low
>> in0_alarm_high
> 
> Not correct, these should be in0_min_alarm and in0_max_alarm,
> respectively, according to the proposal we discussed some months ago.
> 
> Rudolf Marek is working on a documentation update covering this new
> interface, so hopefully it'll be official soon:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016131.html
> 

Yes, I used Rudolf's patch as a starting point because that was newer
and later I found your more complete patch (as already mailed). I've
implemented things as described in your patch (and above).

>> I was thinking that for compatibility with apps which just expect an
>> alarm file as documented in the new standard to add:
>> in0_alarm
>>
>> Which will contain an alarm if either of the 2 above alarms happens. I
>> personally find this a good idea of mine, but i just wanted to check to
>> make sure.
> 
> No, I don't think this is a good idea. No software application actually
> expects this file, as it is part of an interface specification which
> was just defined, isn't even properly documented yet, and isn't
> implemented by any driver.
> 
> I do agree that emulating a single alarm flag for channels with more
> than one alarm bit makes sense, as some applications may not want to
> bother with the exact alarm cause. However, implementing this emulation
> in every driver will be a lot of work and will also increase the
> drivers size. Instead, this would be the job of libsensors (current or
> future) to offer this facility to applications, so that we only have to
> write the code once for all drivers and all applications.
> 

I agree a driver should not offering a compatibility single alarm file
this is indeed a userspace issue.

Regards,

Hans

>> Also the uguru has the ability do disable alarms on a certain input.
>> This way you can silence a certain input and make it not report any
>> alarms which might upset monitoring scripts etc.
>>
>> I currently have added the following enntries for these:
>> in0_alarm_low_enable
>> in0_alarm_high_enable
>> temp1_alarm_enable
>> fan1_alarm_enable
> 
> Looks fine, except that alarm_{low,high} should be {min,max}_alarm.
> 
> This will need to be documented too (on top of Rudolf Marek's pending
> change.)
> 

I've added _enable versions of the new alarm names to export the enable
/ disabling of alarms altogether functionality the uguru offers. I'll
document this as soon as Rudolf's patch has been fixed & merged.

Regards,

Hans

