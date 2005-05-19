From: empx@gmx.de (Mike)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: ASUS P4P800/W83627THF Fan Problems
Message-Id: <40006E9D.80801@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <40001A2D.5030007@gmx.de>
In-Reply-To: <40001A2D.5030007@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I'm using Kernel 2.6.1-rc2(2.6.0 gave the same results..) and the 
>>included i2c modules etc (w83781d driver).
>>The Temperature and Voltage Readings work, yet i cant read nor set the
>>the Fan speed of my CPUFan.
>> cat /sys/bus/i2c/devices/0-0290/fan_input[123] shows always 0,
>>    
>>
>
>See FAQ 4.1.1.
>http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section%204.1
>  
>
OK after changing the fan divisor from 2 to 4 it seems to work now, 
sorry, I guess I thought that dividing 0 is pointless and thus the 
divisor isnt the problem..

>>and changing pwm[12] doesn't change the fan speed, pwm_enable2 is set to 1
>>(there is no other pwm_enable).
>>I have disabled Asus QFan in the BIOS so it shouldn't interfere with
>>this.. Is this a known problem and will/can it be solved somehow?
>>    
>>
>
>PWM doesn't work on all systems, depends on how the chipset is wired by
>the motherboard manufacturer. You should read this document:
>http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fancontrol.txt
>And then try user-space tools from the prog/pwm directory. But in any
>case you want to fix the fan speed readings before, or you won't go
>anywhere.
>  
>
Well, the changing of the Fan's speed works in Windows with Speedfan on 
that Board, so its supported by the hardware.. About the user space 
tools, do they do anything different than changing the pwms?

>Note that we have another driver for the W83627THF but it hasn't been
>ported to Linux 2.6 yet... When it will be, you should get better
>results using it than the w83781d driver. If you're interested in
>porting it yourself, let me know and I'll tell you everything you need
>to know.
>  
>

Well I've read about that, but i guess im not suited for that job, i 
hardly know c++, i don't know anything about the internals of a lernel 
and drivers etc... and i hardly have the the next few months, I'll 
graduate from school..

Michael
