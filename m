From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 04 Jul 2006 21:34:41 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <44AADEF1.1090808@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please always CC to mailing list.

> I use lm-sensors version 2.9.2-5ubuntu3 (I am on the last stable Ubunutu 6.06).
> My chipset is a Winbond W83697HF and my mobo is a MSI K8T Neo-FIS2R (MS-6702).
> I have the same problem :
> 
> However, I'm sure the fan is controllable in speed because under Windows (only
> :( ), MSI provides a software (CoreCenter) that works perfectly (in "thermal"
> or "speed cruise", speed regulated between 1500 and 2600 rpm). Still under
> windows XP, I tested SpeedFan and I had the same problem than with pwmconfig.
> The only way I succeeded in reducing the speed was to low the clock of PWM
> clock frequency, which you propose.

Hmm yes I remember I helped someone with this :)

> I am relatively a beginner with linux (for 4 months only). Can fancontrol use
> the pwm clock frequency to regulate fan speed ? Or could you explain how to do
> what you propose ?

Well not bad to 4 moths experience ;) What you will see bellow is not exactly
user friendly but it works.

By coincidence someone started to create a patch so you can change the frequency
with the "echo" command to special file in /sys filesystem.

I havent seen it yet.

So, the only way how to change the PWM frequency is reprogramming the hardware
on your own. You need datasheet = knowledge, power = utility ;)

1) datasheet http://www.winbond.com.tw/e-winbondhtm/partner/PDFresult.asp?Pname4
2) isaset utility (part of lm-sensors man isaset for manual)

output of sensors command should tell you the IO port.

I have w83627ehf-isa-0290

I assume for now that you will have -290 too. (io is then +5 and +6)
I assume you want to change fan1.

If so find in datasheet "FAN 1 Pre-Scale Register"
It resides in bank 0 offset 0 (page 55 printed)

PWM frequency = (Input Clock / Pre-scale) / 256

So you may change the pre-scaler or input clock frequency.

For example if you want to use the 24Mhz base frequency with divisor 4.
then you need to set bit 7 to 1. Bit 7 means that it is 128, divisor 4 is 4
so 128+4 is 132 and which is 0x84 in hex

1) rmmod w83627hf
   so the driver wont be confused
2) reprogram the chip to bank 0
    isaset 0x295 0x296 0x4e 0x00
3) reprogram the value
     isaset 0x295 0x296 0x0 0x84

For fan2 it would be in register 2 bank 0
     isaset 0x295 0x296 0x2 0x84

4) modprobe w83627hf
5) pwmconfig

So, you will need to put this sequence to some startup script so it is loaded
when machine boots. Blame the MSI that it did not program in some more usable
frequency...


> I didn't know if I had to respond to you or to the mailing-list, excuse me I am
> mistaken.
> Thanks for your help,

never mind, now you know ;)

I wont be here on Wednesday/Thursday so if you have further questions please
wait, or maybe someone else will help.

Thanks,
Regards
Rudolf


