From: "Piotr Czepek" <piotr.czepek@gmail.com>
Date: Tue, 14 Aug 2007 18:18:23 +0000
Subject: Re: [lm-sensors] #2179: Treat strange fan speed (like 675 000 rpm)
Message-Id: <2ecba3930708141118t4486af7bo425e1f89a7a1f72e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

2007/8/13, lm-sensors <lm-sensors-notify@lm-sensors.org>:
> #2179: Treat strange fan speed (like 675 000 rpm) as "0"
> -------------------------------------+--------------------------------------
>   Reporter:  piotr.czepek@gmail.com  |       Owner:  khali
>       Type:  enhancement             |      Status:  assigned
>   Priority:  minor                   |   Milestone:
>  Component:  fancontrol              |     Version:
> Resolution:                          |    Keywords:

> -------------------------------------+--------------------------------------
> Changes (by khali):
>
>   * status:  new => assigned
>   * reporter:  ticket => piotr.czepek@gmail.com
>  * cc: piotr.czepek@gmail.com (removed)
>   * component:  misc => fancontrol
>   * priority:  trivial => minor
>   * owner:  somebody => khali
>   * keywords:  fan speed  driver =>
>
> Comment:
>
>  What driver are you using? I can't remember seeing a driver report high
>  speeds for stopped fans.
>
>  I don't much like the idea of arbitrarily discarding some reported fan
>  speed values. You should probably simply avoid using low duty cycle PWM if
>  it results in bad speed readings. You may get better results by using a
>  lower base frequency for the PWM.
>
> --
> Ticket URL: <http://lm-sensors.org/ticket/2179#comment:1>
> lm-sensors <http://lm-sensors.org/>
> Linux hardware monitoring

Hi,

I use w83627hf driver.
I agree, discarding some fan speed values is bad idea.
But, AFAIK there is no way to change base frequency for PWM output.
I use fancontrol to control fan speed, so I think I need to patch
fancontrol to make some duty cycle limits.

Anyway, problem is caused by low duty PWM and  I can't find good
solution for this hardware problem.

sensors output:

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.76 V  (min =  +1.54 V, max =  +1.95 V)
VCore 2:   +1.52 V  (min =  +1.54 V, max =  +1.95 V)       ALARM
+3.3V:     +3.25 V  (min =  +2.82 V, max =  +3.79 V)
+5V:       +4.78 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
+12V:     +12.40 V  (min =  +7.78 V, max =  +0.61 V)       ALARM
-12V:     -12.28 V  (min = -13.59 V, max =  -9.65 V)
-5V:       -5.50 V  (min =  -7.31 V, max =  -7.71 V)       ALARM
V5SB:      +5.48 V  (min =  +0.00 V, max =  +0.86 V)       ALARM
VBat:      +3.09 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 21093 RPM, div = 2)              ALARM
fan3:     675000 RPM  (min =   -1 RPM, div = 2)              ALARM
temp1:       +40°C  (high =    +0°C, hyst =  -128°C)   sensor thermistor   ALARM
temp2:     +46.0°C  (high =   +66°C, hyst =   +61°C)   sensor = diode
         (beep)
temp3:     +42.5°C  (high =   +66°C, hyst =   +61°C)   sensor thermistor           (beep)
vid:      +1.750 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm enabled

-- 
Best regards piotr
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
