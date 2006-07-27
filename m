From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 27 Jul 2006 22:07:05 +0000
Subject: [lm-sensors] 18-rc1-mm1  and unchecked return-codes
Message-Id: <44C93909.7030606@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44B3EEFD.5050209@gmail.com>
In-Reply-To: <44B3EEFD.5050209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Jim:
>   
Hi Mark,  thanks for taking an interest.

> * Jim Cromie <jim.cromie at gmail.com> [2006-07-11 12:33:33 -0600]:
>   
>> from the 18-rc1-mm1 announcement:
>>
>> - We're getting a relatively large number of crash reports coming out of the
>>   core sysfs/kobject/driver/bus code, and they're all really hard to diagnose.
>>
>>   I am suspecting that what's happening is that some registration functions
>>   are failing and the caller is ignoring that failure.  The code proceeds and
>>   crashes much later, in obscure ways.
>>
>>   All these functions return error codes, and we're not checking them.  We
>>   should.  So there's a patch which marks all these things as __must_check,
>>   which causes around 1,500 new warnings.
>>
>>   These are all bugs and they all need to be fixed.
>>
>>
>>
>> Many of these 1500 are from lm-sensors modules;
>> for example - a single function - device_create_file(),
>> is called 1027 times, and 'every' one is a void context return.
>>
>>      grep device_create_file drivers/hwmon/*.c
>>
>> So, what kinds of errors are possible here ?
>> and what should we do if they occur ?
>> does it ever happen that only 1 create fails ? 
>> do/would we care ? (not currently)
>>
>> These Qs are somewhat rhetorical, theyre at least a heads-up.
>>     
>
> I can't resist answering rhetorical questions. ;)
>
> At least in the context of what Andrew wrote, the calls to device_create_file()
> in the hwmon drivers are not the problem.  AFAICT, if one or more sysfs files
> fail to be created, the worst that might happen is that *maybe* sensors(1) could
> crash.  Offhand, I can't see how missing sysfs files could lead to a kernel crash.
>
> At any rate, yes, they're still bugs.
>
> OTOH, there is a real need to review some of the error checking in the I2C
> core - where ignoring status can and does cause kernel panics.  See some
> recent patches by both Jean and me for examples... and there are more.
>
>   
>> FWIW, device_remove_file() is only called 9 times.
>>     
8 from hwmon/ams.c
1 from hwmon/lm70.c

This compares rather sparsely against:
[jimc at harpo linux-2.6.18-rc2-mm1-sk]$ grep device_create_file 
drivers/hwmon/*.c |wc
   1027    3046   83340

Is it truly this optional ?

>> This doesnt seem to be a problem though, or we'd have heard it by now.
>> Specifically - hwmon/pc87360 appears to clean up after itself,
>> (or rather sysfs core code does), without any calls to device_remove_file()
>>
>> soekris:/sys/bus/i2c/devices# ls
>> 9191-6620@
>> soekris:/sys/bus/i2c/devices# rmmod pc87360
>> soekris:/sys/bus/i2c/devices# ls
>> soekris:/sys/bus/i2c/devices#
>>
>>
>> Ive gone ahead and worked up a patch against pc87360 to
>> count-errors-and-warn, which should suffice, at least for short term.
>>     
>
> (Hopefully) I'll take a look at this later today.
>
>   
dashed-hopes  ;-)
If you'd rather punt, I'll send it on to lkml, but I suppose Id like to 
keep it in-channel.

> Regards,
>
>   

thanks
-jimc

