From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: bug in as99127f
Message-Id: <3F1C9B68.5000508@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we're fairly certain that PWM doesn't work in the as99127f driver (same old story, no datasheet).
On some chips a PWM output pin is shared with something else, perhaps that's what is affecting temp2?
Or more likely we are just hitting the wrong bit in the wrong register...

Jean Delvare wrote:
> 
>>The first value can take 0-255 giving the fan speed, the second one
>>sould AFAIK be 0 or 1, for on/off, actually I didn't code that cleanly
>>in fancontrol and pwmconfig. What happens to your temps when doing:
>>
>>echo 0 0 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1
> 
> 
> Nothing. Still reads "0 1", temperatures OK.
> 
> 
>>echo 255 1 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1
> 
> 
> Reads "255 1", temperatures dead broken (see previous mail). Echo 0 0
> makes them back to normal.
> 
> 
>>echo 0 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1
> 
> 
> Very same as echo 0 0.
> 
> 
>>echo 255 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1
> 
> 
> Very same as echo 255 1.
> 
> I noticed that echo 100 1 destroys temp3 but not temp1 nor temp2. 200
> destroys temp2 only. 50 destroys temp1 and temp3. 10 destroys temp1 and
> temp2. 2 or 3 destroy temp1 only... OK, I get it. Bit 1 (starting with
> LSB=0) breaks temp1. Bit 3 breaks temp2. Bit 5 breaks temp3. Echo 42 1
> breaks the three of them. Echo 213 1 breaks nothing. This simply means
> that this register is not a PWM. It's more likely a temperature sensor
> type selector.
> 
> Note that the pwm2 file does not break anything (not at first sight at
> least). It's only pwm1.
> 
