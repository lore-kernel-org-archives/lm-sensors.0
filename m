From: lopemanc@swbell.net (Chris Lopeman)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Thanks and setup problem
Message-Id: <41BB54B2.2080707@swbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41AE99A2.8050402@swbell.net>
In-Reply-To: <41AE99A2.8050402@swbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark,

Thanks for your quick response.  I will modify the w83781d config to 
drop temp3 and drop the ADM1021 and run like that.  The w83781d gives me 
the fans and the 2 CPU temps, which will satisfy my needs.  But I did 
run some further tests on the ADM1021 and it is causing me a problem, so 
I wanted to get this information to you.

I loaded only the adm1021 and supporting i2c-piix4 module.  While at 
first glance it appears to work, I believe there are actually 2 related 
issues.  I let the machine cool down and then started sensord with 1 
second logging and stressed the processors.  The output produces 
temperature readings that are far too erratic.  The following is from 
the very start of the log.

    Dec 11 09:25:27 prod sensord: Adapter: SMBus PIIX4 adapter at 0440
    Dec 11 09:25:27 prod sensord: Algorithm: Non-I2C SMBus adapter
    Dec 11 09:25:27 prod sensord:   Board: 39 C (min = 20 C, max = 60 C)
    Dec 11 09:25:27 prod sensord:   CPU: 42 C (min = 20 C, max = 60 C)
    Dec 11 09:25:27 prod sensord:   die_code: 3
    Dec 11 09:25:27 prod sensord: Chip: adm1021-i2c-0-2b
    Dec 11 09:25:27 prod sensord: Adapter: SMBus PIIX4 adapter at 0440
    Dec 11 09:25:27 prod sensord: Algorithm: Non-I2C SMBus adapter
    Dec 11 09:25:27 prod sensord:   Board: 42 C (min = 20 C, max = 60 C)
    Dec 11 09:25:27 prod sensord:   CPU: 57 C (min = 20 C, max = 60 C)
    Dec 11 09:25:27 prod sensord:   die_code: 3
    Dec 11 09:25:28 prod sensord: Chip: adm1021-i2c-0-1a
    Dec 11 09:25:28 prod sensord: Adapter: SMBus PIIX4 adapter at 0440
    Dec 11 09:25:28 prod sensord: Algorithm: Non-I2C SMBus adapter
    Dec 11 09:25:28 prod sensord:   Board: 39 C (min = 20 C, max = 60 C)
    Dec 11 09:25:28 prod sensord:   CPU: 56 C (min = 20 C, max = 60 C)
    Dec 11 09:25:28 prod sensord:   die_code: 3
    Dec 11 09:25:28 prod sensord: Chip: adm1021-i2c-0-2b
    Dec 11 09:25:28 prod sensord: Adapter: SMBus PIIX4 adapter at 0440
    Dec 11 09:25:28 prod sensord: Algorithm: Non-I2C SMBus adapter
    Dec 11 09:25:28 prod sensord:   Board: 42 C (min = 20 C, max = 60 C)
    Dec 11 09:25:28 prod sensord:   CPU: 50 C (min = 20 C, max = 60 C)
    Dec 11 09:25:28 prod sensord:   die_code: 3

As you can see the first CPU jumps 14 Degrees in one second.  And the 
other drops 7 degrees in the same second.  This makes no sense.  The 
jumps are too far on a second by second basis and they go up and down.  
Now over a long period of time (minutes) you can see that as the 
temperatures go up and down they do seem to rise on the average.  So 
they are not completely bogus.  The temperatures rising, bring me to the 
second issue.  Within 5 minutes (and this is reproducible) my 
motherboard alarm sounds.  I think it happens when the CPU temp shows a 
reading of 61C (remember this reading is probably invalid) which is 
across the max of 60 that is displayed.   This is interesting since the 
log does not show any indication an alarm has sounded.  And I have 
change the ADM chips configuration to shut off the beep.  But I don't 
even think it is an option for this module.  I can stress the  CPU for a 
long time without this module loaded and never trigger the MB alarm.  
But less than 5 minutes with this in and it triggers all the time.

    Dec 11 09:28:52 prod sensord: Chip: adm1021-i2c-0-1a
    Dec 11 09:28:52 prod sensord: Adapter: SMBus PIIX4 adapter at 0440
    Dec 11 09:28:52 prod sensord: Algorithm: Non-I2C SMBus adapter
    Dec 11 09:28:52 prod sensord:   Board: 38 C (min = 20 C, max = 60 C)
    Dec 11 09:28:52 prod sensord:   CPU: 40 C (min = 20 C, max = 60 C)
    Dec 11 09:28:52 prod sensord: Chip: adm1021-i2c-0-2b
    Dec 11 09:28:52 prod sensord: Adapter: SMBus PIIX4 adapter at 0440
    Dec 11 09:28:52 prod sensord: Algorithm: Non-I2C SMBus adapter
    Dec 11 09:28:52 prod sensord:   Board: 44 C (min = 20 C, max = 60 C)
    Dec 11 09:28:52 prod sensord:   CPU: 61 C (min = 20 C, max = 60 C)

Just let me know if you need anything more.

Hope this helps,

Chris Lopeman


Mark M. Hoffman wrote:

>Hi Chris:
>
>* Chris Lopeman <lopemanc@swbell.net> [2004-12-01 22:27:14 -0600]:
>  
>
>>Output from sensors.  As you can see w83781d reports an odd looking 
>>temperature.  Specifically the +208.0?C.  Actually, I am not sure what 
>>temp1 and 2 are for.  I guess I expect the output to look more like the 
>>adm1021 module.   I am hoping I can get all readings from the 
>>w83781d-isa-0290 section.  I am a bit of a minimalist and I think the 
>>adm1021 module may be causing a problem.
>>    
>>
>
>Not sure what you mean by that.  The adm1021s are probably reading your
>CPUs, one each.  Run a CPU intensive task for a few minutes and see which
>temp sensors go up the quickest... those are attached to CPUs.  The others
>are probably reading a board temp somewhere.  Your board might not have
>anything at all connected to temp3 on the w83781d... so ignore it by 
>modifying sensors.conf.  (try 'man sensors.conf')
>
>Regards,
>
>  
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041211/b422af17/attachment.html
