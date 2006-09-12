From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 12 Sep 2006 00:02:21 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <4505F90D.5030404@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>> as you can see, Vdd is lower than min, and ALARM is 'issued' by sensors
>>
>> here, I lower minimum, but alarm stays on, cuz its not (yet) explicitly 
>> cleared.
>>     
> It doesn't mean a thing at this point. Alarms stay as long as they
> haven't been read at least once, by design. You'd need to "cat in8*"
> again after a couple seconds, and my guess is that the alarm would
> actually be cleared, because the driver does take care of it:
>
>   

You are correct. The 2nd cat shows it cleared.  I'll yank that setter 
callback.
<backpedalling> Im a bit surprised that in the course of playing with 
it, I didnt run 2 cats
(iirc, the console stuff I pasted was a trim-down of what I did)
Anyway, thanks.

soekris:~# cd /sys/devices/platform/i2c-9191/9191-6620/
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8*
1477
1796
1501
147
soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1450 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8*
1477
1796
1453
147
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8*
1477
1796
1453
145


>
> Side note: bit 4 was set in the process, doesn't sound right to me.
>
>   
It happens w/o my separate-alarms hacks - the above listing is taken 
from unaltered rc6-mm1
rc5 shows same.  I'll poke at it some more.

>> <digressions>
>>
>> status = 145 = 0x91.
>> bit 7 = 1 means:  New data not yet read.
>> this suggests that the conversion thats been read is incomplete, and 
>> presumably inaccurate in the LSBs
>>     
>
> Where in the datasheet do you see this?
>
>   
in Winbond's PC87366.pdf, section 11.5.12, table 3  (page 189)
bit 7 is named "End of Conversion"

bit 4 is "Alarm Output Enable".
I dont understand what its enabling, I'll (get around to) add some 
temporary code to poke at it,
and see whats happening.

> To me, "new data not yet read" simply means that at least one sampling
> cycle was completed since our last read. There's nothing wrong with
> that, as the chip samples its inputs continuously and we only read the
> values from times to times.
>
>   
bit 7 is an RW1C bit, which means that the code you quoted above should 
clear it,
esp when I do: cat in8*; cat in8*
oddly, it does not reset the bit.
Im not seeing anything misbehaving because of it.

>> also,  in pc87360_detect, you set
>>         data->vrm = 90;
>>
>>
>>     
> It would be better to use the autodetection now that we have code doing
> that, you are right. Care to submit a patch doing this?
>
>   
just sent.


>> btw, 1s conversion period could be related to the "New data not yet read"
>>     
>
> I don't think so, but again this bit being set is not a problem as far
> as I can see.
>
>   

Again, Ive not seen any misbehavior, just poking around..

thanks Jean,
jimc

