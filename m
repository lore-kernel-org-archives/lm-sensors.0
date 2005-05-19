From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Ticket 1834 Update
Message-Id: <41B5FE56.7080805@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm quite surprised that changing the PWM clock worked, at least sortof...
(it only slowed the fan down 15% max even after the fix)

But 125 kHz is a bad default (and my math and datasheet show a default of 24 MHz / 256 = 93.75 kHz...
Khali where did you get 125 kHz?)
A typical PWM requirement for a fan is 20 - 50 kHz.
It may be worth enhancing the driver to set the speed lower if the BIOS doesn't.



Jean Delvare wrote:

>>Here the pwmconfig output:
>>
>>Testing pwm control 1-0290/fan1_pwm ...
>>  1-0290/fan1_input ... speed was 2777 now 0
>>    It appears that fan 1-0290/fan1_input
>>    is controlled by pwm 1-0290/fan1_pwm
>>Would you like to generate a detailed correlation (y)?
>>    PWM 255 FAN 3245
>>    PWM 240 FAN 3245
>>    PWM 225 FAN 3214
>>    PWM 210 FAN 3199
>>    PWM 195 FAN 3183
>>    PWM 180 FAN 3154
>>    PWM 165 FAN 3139
>>    PWM 150 FAN 3110
>>    PWM 135 FAN 3082
>>    PWM 120 FAN 3082
>>    PWM 105 FAN 3040
>>    PWM 90 FAN 3013
>>    PWM 75 FAN 2960
>>    PWM 60 FAN 2922
>>    PWM 45 FAN 2824
>>    PWM 30 FAN 2755
>>    PWM 15 FAN 0
>>    Fan Stopped at PWM = 15
> 
> 
> Wow. Glad it work, I didn't really expected it to. Are you using some
> unconventional fan? You might want to try different clock values, since
> the speed curve is still not perfect.
> 
> 
>>What would be the "nicest" way of setting these values? I would
>>suggest putting it into /etc/modules.conf:
>>
>>post-install w83627hf /usr/sbin/isaset -y 0x295 0x296 0 25 > /dev/null
>>             2> /dev/null
>>
>>Ok? Or is there a better/safer way?
> 
> 
> The driver doesn't need to be loaded for it to work (and actually it
> would probably be better to run isaset before it is) so I would do a
> pre-install. Alternatively you can run the command from any init script,
> it doesn't really matter.
> 
> In cas you need it, the register for PWM 2 is 0x02 and works exactly the
> same.
> 
> I'll update and close ticket #1384 now.
> 
> 
>>Thanks a lot. Cheers,
> 
> 
> You're welcome :)
> 
