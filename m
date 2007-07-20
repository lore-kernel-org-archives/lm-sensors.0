From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 20 Jul 2007 05:46:24 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] libsensors4: Optimize
Message-Id: <46A04C30.4090208@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070716152534.1755ba05@hyperion.delvare>
In-Reply-To: <20070716152534.1755ba05@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 16 Jul 2007 15:37:30 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Minor optimizations to sensors_feature_get_type():
>>> * We no longer support any single type, so no need to handle this case.
>>> * We can start looking for "_" at offset 3 rather than the beginning
>>>   of the string (the shortest valid prefix is "in0", 3 characters.)
>> Nice cleanup!
>>
>> I've checked the whole bunch of patches, and they look okay. Once you've 
>> applied them to svn I'll do some testing to see if there are any regressions, 
>> but I don't expect any,
> 
> Thanks for the review. I've committed the patches now. I hope to have
> time for more interface cleanups during the next week-end.
> 

As promised, I've done some testing of the current svn with these patches 
integrated, everything still seems to work fine.

> My next victim will probably be sensors_get_ignored(), I see no valid
> reason why each application has to care about ignore statements when
> libsensors itself could hide the ignored chip features to start with.
> I'm just not sure if the features should be skipped when the
> application asks for the feature list, or even earlier, not inserted in
> the feature list when walking the sysfs device directories.
> 

Since both the config file loading and the sysfs reading happens only once, 
there is no advantage to delaying the hiding to the moment the applications 
asks for the feature list (If sensors.conf would/could be rescanned at that 
moment, that would be an argument to delay the hiding).

Thus this then purely becomes a question of where can it be implemented the 
cleanest, assuming that the current sensors.conf parsing code skips sections 
for not detected chips, doing this when parsing sysfs creates a chicken and egg 
problem, thus I think it would be best to handle the ignores when the apps asks 
for the feature list.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
