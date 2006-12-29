From: a@gaydenko.com (Andrew Gaydenko)
Date: Fri, 29 Dec 2006 03:01:04 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200612290601.04303@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

==== On Friday 29 December 2006 05:32, you wrote: ===>Hi Andrew,
>
>> I have applied the W83627DHG patch, all sensors works (THANKS!) except for +5V
>> (it shows something about 0.384V). So, I can stay with CPU temp from
>>  W83627DHG. But what does this sensor show? First CPU temp?
>> Second one? I mean Core 2 Duo.
>
>The w83627dhg has three temperature input pins. (SYSTIN, CPUTIN,
>AUXTIN) However, the motherboard manufacturer can wire the pins any
>way they want. When you discover what each pin is wired to, you can
>update your sensors.conf and send an email to us letting us know what
>your motherboard is and what customizations you did. The Core 2 Duo
>should have four sensors, if it's like my Athlon 64 X2. That is, there
>are two digital sensors (one per core) which the coretemp driver will
>read. And there are two analog sensors (one per core) which the
>motherboard might connect to the w83627dhg. Use cpuburn or something
>you prefer and see which temperatures increase.

AUX Temp doesn't change at all when both CPU are under heavy loading.
The sensor value is 119C always (it is for ASUS P5B-VM motherboard).

>
>> Another problem is, when I try pwmconfig, I get such error:
>>
>> Testing pwm control 9191-0290/pwm2 ...
>>   9191-0290/fan2_input ... speed was 1721 now 1713
>> /usr/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>>
>> It is for current SVN tree. So, I don't know a reason why pwm doesn't work - is
>> this disabled by BIOS, or is this the script error? I'm not shell guru :-)
>
>I'm going to pass on this one. Rudolf?
>
>David

I think script is correct. I have tried 'echo 0' > blablabla and got the same
error. Given pwm2_enable has content "1". 'echo 1' doesn't lead to error.

P.S. Must I use multiple "To:" in accordance with msg header, or must I answer
     to the mailing list only? (I use last variant now)


Andrew

