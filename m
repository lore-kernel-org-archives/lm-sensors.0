From: Guillaume.Millet@crans.org (Guillaume.Millet at crans.org)
Date: Sun, 02 Jul 2006 18:43:12 +0000
Subject: [lm-sensors]  w83627hf, fan speed always high, unchangeable?
Message-Id: <20060702204312.ia2ys4z7kw8s84g4@webmail.crans.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I use lm-sensors version 2.9.2-5ubuntu3 (I am on the last stable Ubunutu 6.06).
My chipset is a Winbond W83697HF and my mobo is a MSI K8T Neo-FIS2R (MS-6702).
I have the same problem :

Testing pwm control 9191-0290/pwm1 ...
  9191-0290/fan1_input ... speed was 2636 now 0
    It appears that fan 9191-0290/fan1_input
    is controlled by pwm 9191-0290/pwm1
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)?
    PWM 255 FAN 2678
    PWM 245 FAN 2596
    PWM 235 FAN 2596
    PWM 225 FAN 2596
    PWM 215 FAN 2636
    PWM 205 FAN 2596
[...]
    PWM 65 FAN 2636
    PWM 55 FAN 2556
    PWM 45 FAN 2556
    PWM 35 FAN 2596
    PWM 25 FAN 2556
    PWM 15 FAN 2556
    PWM 5 FAN 2518
    Hit return to continue...

However, I'm sure the fan is controllable in speed because under Windows (only
:( ), MSI provides a software (CoreCenter) that works perfectly (in "thermal"
or "speed cruise", speed regulated between 1500 and 2600 rpm). Still under
windows XP, I tested SpeedFan and I had the same problem than with pwmconfig.
The only way I succeeded in reducing the speed was to low the clock of PWM
clock frequency, which you propose.

I am relatively a beginner with linux (for 4 months only). Can fancontrol use
the pwm clock frequency to regulate fan speed ? Or could you explain how to do
what you propose ?

It seems to me that Ticket #1419 talks about this parameter PWMCLK but I didn't
see it in sensors.conf.

I didn't know if I had to respond to you or to the mailing-list, excuse me I am
mistaken.
Thanks for your help,

-- 
Guillaume Milet


On 2005-11-04, Rudolf Marek wrote:
> As the last resort you can try to change the base frequencies of PWM. All you
need is to look into the dataseet and find register
> 0x5C bank 0. Then you can use isaset command to modify the register. If you
need help with this just write back.

