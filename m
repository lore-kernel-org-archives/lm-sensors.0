From: com.ea@tinet.org (com.ea)
Date: Fri, 01 Dec 2006 22:18:09 +0000
Subject: [lm-sensors] (fwd) testing w83627hf treiber?
Message-Id: <n5a1n2dg83f2kk7hseglaibuq19qh0rlbg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everybody

I received this message which explains a strange behaviour in a w83627hf that I never heard of.
It looks like the fans run until the bios loads and then they stop.
He also explains that he cant modify the monitor registers (as root) which always return 0.

On Wed, 29 Nov 2006 15:14:34 +0100, Thomas Dohl <Thomas.Dohl at gmx.de> wrote:

>>Hi Carlos,
>>
>>I've reed your article at 
>>http://lists.lm-sensors.org/pipermail/lm-sensors/2006-July/016942.html.
>>
>>Now I've got a short question to you.
>>
>>I've got the via epia ek-800 board. It's with the w83627hf chip.
>>
>>Now I want to control the fan-speed.
>>Here my problem:
>>
>>My kernel is 2.6.17-2.
>>
>>Loadet modules are i2c-viapro, i2c-isa, eeprom, w83627hf.
>>
>>I can see read the temperatur and I see the
>>fan devices under :
>>/sys/bus/i2c/devices/9191-0290/pwm1 and pwm2
>>
>>but I can't set values
>>echo 255 > pwm1
>>doesn't work.
>>cat pwm1 always returns 0
>>
>>Has anyone an idea?
>>
>>If I put the board on, the fan's runs for a short while.

> I dont understand what you mean by that, can you explain it in detail?

>>
>>I only tried to say, that the fan's are ok. I put on the power of the 
>>board. The BIOS runs through the memtest. In this time, the fan's are
>>running. After finishing this, grub starts and the fan's are of.

>Thats certainly a strange behaviour :/
>
>Im sending you the driver I modified to include two additional entries called pwmclk1 and pwmclk2,
>which are used to improve the control of the fan speed. Copy it to the kernel tree in the correct
>directory and then run the usual 'make modules && make modules_install' (I guess you compile
>lm-sensors drivers as modules...)
>
>Anyway I dont know if it will solve the problem. If you could give me more information, like the
>output of sensors-detect or any other hint which could explain why the fans are off before any
>driver is loaded... You should also consider writing to the lm-sensors mailing list, which I am
>forwarding this message
>
>Regards
>Carlos

>>
>>Do you have an idea?
>>
>>regards
>>Thomas
>>Sorry of my bad english, I'm from Germany.

