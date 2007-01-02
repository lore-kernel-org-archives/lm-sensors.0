From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 02 Jan 2007 23:17:12 +0000
Subject: [lm-sensors] strange output values from W83627HG chip
Message-Id: <459AE7F8.5000604@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1167384671.4594e05f0a0df@www.inbox.lv>
In-Reply-To: <1167384671.4594e05f0a0df@www.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

>>> CPU1 Temp: +24.0?C (high = +75.0?C, hyst = +70.0?C)
>>> CPU2 Temp: +22.0?C (high = +75.0?C, hyst = +70.0?C)
>>> temp3: +30.5?C (high = +75.0?C, hyst = +70.0?C)
>>> temp4: -128.0?C (high = +75.0?C, hyst = +70.0?C)
>> Looks like temp4 is not connected.
>>
>>> temp5: +35?C (high = +50?C, hyst = +45?C)
>>> temp6: +16?C (high = +100?C, hyst = +95?C)
>>> cpu0_vid: +0.019 V (VRM Version 11.0)
>>> cpu1_vid: +0.019 V (VRM Version 11.0) 
>>>
>> Please provide the output so we know what is what
> 
> Ok.
> Here are results of `cat /sys/class/hwmon/hwmon0/device/temp?_type` :
> 
> 6
> 6
> 6
> 6

They are all PECI

> 4 is thermistor
> 0

Hmmm question is what to do in the driver when temperature channel is disabled
We may:

1) not create the tempX_input file
2) when disabled remove tempX_input file
3) do nothing

Now we do 3)

> Following kernel docs, temp6 is disabled, so I put ignore line in sensors.conf for it 
> now. Also, as I read manual for motherboard and tried to run superdoctor utility, I 
> found that temp5 is System Motherboard temperature (36C looks like true) 

Good. You have there Windows too? Or it runs linux?

> But why do you suggest to disable temp1-temp4? Yes, they are monitored through 
> PECI and I can use coretemp driver instead?

I do? Ah that was just a guess that there is 0 (multi choice enumeration) Sorry
for that

> These are values from coretemp drivers (I have 2 CPU with 2 cores)
> cat /sys/class/hwmon/hwmon[1,2,3,4]/device/temp1_input 
> 28000
> 28000
> 24000
> 27000

Hmm we should really push the driver to kernel :/

> Quote from Supermicro FAQ: 
> "Q: PECI 1 and 2 have correct readings of 34 and 38 but PECI 3 and 4 show 0 
> readings"
> "A: The reason is that the current Woodcrest CPU (Intel 51xx series CPU) only has 
> one PECI Agent for each CPU and that is why you see only two readings."


But we see 3 of them...  temp3 is not so bad... I don't know what happen with
the chip if PECI fails. (does not exist)

> This answer explains my strange values in temp3-temp4. 
> So, am I right to use coretemp driver values instead of temp1-temp4 ones?

Yes you may use them instead.

> Also, I can't found anywhere in docs how to show coretemp values from sensors 
> output! Now I can read them only from sysfs.

Please use latest SVN snapshot,

> Sorry for too many questions! :)

No problem.

Rudolf

