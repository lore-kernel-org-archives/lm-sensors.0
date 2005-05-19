From: frank@vfx.to (Frank Hellmann)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Ticket 1834 Update
Message-Id: <41B6250E.7030505@vfx.to>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark!

Just a quick update. I am currently using the w83627hf module and append 
the force_w83697hf option.
After setting the PWM clock to 64 I get these pwmconfig correlation:

   It appears that fan 1-0290/fan1_input
    is controlled by pwm 1-0290/fan1_pwm
Would you like to generate a detailed correlation (y)? y
    PWM 255 FAN 4470
    PWM 240 FAN 4440
    PWM 225 FAN 4470
    PWM 210 FAN 4383
    PWM 195 FAN 4354
    PWM 180 FAN 4245
    PWM 165 FAN 4166
    PWM 150 FAN 4090
    PWM 135 FAN 4017
    PWM 120 FAN 4017
    PWM 105 FAN 3970
    PWM 90 FAN 3970
    PWM 75 FAN 3879
    PWM 60 FAN 3750
    PWM 45 FAN 3515
    PWM 30 FAN 3358
    PWM 15 FAN 3040
    PWM 0 FAN 0
    Fan Stopped at PWM = 0

It seems that this setting gives a much better (and quieter) result. 
Setting the fan1_pwm to 12 gets it down to ~2650RPM.

Also there seems to be an unknown i2c device on this board (MSI KT8 NEO 
- AMD64bit in pure 64bit mode). There are two additional fan connectors 
(four in all) on this board and I guess it could be a controller for 
these fans. Here the i2cdump:

sandman:/home/frank# i2cdump 0 0x2f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2f, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 12 0f 10 01 07 00 ff ff ff ff ff ff ff ff ff ff    ?????...........
10: ff ff ff ff 14 62 02 00 ff ff ff ff ff ff ff ff    ....?b?.........
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................


          Cheers,
                         Frank...


Mark Studebaker wrote:

> I'm quite surprised that changing the PWM clock worked, at least 
> sortof...
> (it only slowed the fan down 15% max even after the fix)
>
> But 125 kHz is a bad default (and my math and datasheet show a default 
> of 24 MHz / 256 = 93.75 kHz...
> Khali where did you get 125 kHz?)
> A typical PWM requirement for a fan is 20 - 50 kHz.
> It may be worth enhancing the driver to set the speed lower if the 
> BIOS doesn't.
>
>
>
> Jean Delvare wrote:
>
>>> Here the pwmconfig output:
>>>
>>> Testing pwm control 1-0290/fan1_pwm ...
>>>  1-0290/fan1_input ... speed was 2777 now 0
>>>    It appears that fan 1-0290/fan1_input
>>>    is controlled by pwm 1-0290/fan1_pwm
>>> Would you like to generate a detailed correlation (y)?
>>>    PWM 255 FAN 3245
>>>    PWM 240 FAN 3245
>>>    PWM 225 FAN 3214
>>>    PWM 210 FAN 3199
>>>    PWM 195 FAN 3183
>>>    PWM 180 FAN 3154
>>>    PWM 165 FAN 3139
>>>    PWM 150 FAN 3110
>>>    PWM 135 FAN 3082
>>>    PWM 120 FAN 3082
>>>    PWM 105 FAN 3040
>>>    PWM 90 FAN 3013
>>>    PWM 75 FAN 2960
>>>    PWM 60 FAN 2922
>>>    PWM 45 FAN 2824
>>>    PWM 30 FAN 2755
>>>    PWM 15 FAN 0
>>>    Fan Stopped at PWM = 15
>>
>>
>>
>> Wow. Glad it work, I didn't really expected it to. Are you using some
>> unconventional fan? You might want to try different clock values, since
>> the speed curve is still not perfect.
>>
>>
>>> What would be the "nicest" way of setting these values? I would
>>> suggest putting it into /etc/modules.conf:
>>>
>>> post-install w83627hf /usr/sbin/isaset -y 0x295 0x296 0 25 > /dev/null
>>>             2> /dev/null
>>>
>>> Ok? Or is there a better/safer way?
>>
>>
>>
>> The driver doesn't need to be loaded for it to work (and actually it
>> would probably be better to run isaset before it is) so I would do a
>> pre-install. Alternatively you can run the command from any init script,
>> it doesn't really matter.
>>
>> In cas you need it, the register for PWM 2 is 0x02 and works exactly the
>> same.
>>
>> I'll update and close ticket #1384 now.
>>
>>
>>> Thanks a lot. Cheers,
>>
>>
>>
>> You're welcome :)
>>
>
>
>
