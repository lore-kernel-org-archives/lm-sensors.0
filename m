From: pjkonweb@gmail.com (Prakash J K)
Date: Thu, 21 Sep 2006 17:07:55 +0000
Subject: [lm-sensors] lm_sensors trigger pc buzzer beeping continuously
Message-Id: <5251aaf50609210955n5426f164i306d90e0d0330e41@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
In-Reply-To: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
Thanks.below is the o/p of `sensors`
prakash at etch:~$ sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.31 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +2.61 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +3.28 V  (min =  +0.00 V, max =  +4.08 V)
+5V:       +5.03 V  (min =  +0.00 V, max =  +6.85 V)
+12V:     +11.97 V  (min =  +0.00 V, max = +16.32 V)
-12V:     -14.97 V  (min = -27.36 V, max =  +3.93 V)
-5V:       -5.26 V  (min = -13.64 V, max =  +4.03 V)
Stdby:     +6.85 V  (min =  +0.00 V, max =  +6.85 V)   ALARM
VBat:      +3.04 V
fan1:     1088 RPM  (min =  664 RPM, div = 8)
fan2:        0 RPM  (min =    0 RPM, div = 8)
fan3:        0 RPM  (min =    0 RPM, div = 8)
M/B Temp:    -55 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor
CPU Temp:    +34 C  (low  =  +127 C, high =   +70 C)   sensor = diode
Temp3:        -2 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor

.i tried "ignore temp" in /etc/sensors.conf;that doesnt helped. hope this
helps.
                                     regards,
                                  Prakash J K

On 9/21/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
>
> Hi,
>
> > hello all,
> > i use a gigabyte mobo(GA-8I915GV-MF)with i915GV chipset and only CPU
> > temperature sensor available.it <http://available.it> shows CPU temp
> > correctly.now i configure it with`sensors-detect` and it detected driver
> > `it87'.the problem is during booting itself after sometime it triggers
> > PC beeping continuously.am <http://continuously.am> quoting results
> below.
> > Driver `it87' (should be inserted):
>
> Maybe you have set up temp alarm in bios to too low level and it starts
> beep
> when booting because your CPU is hotter. Please provide output of
> "sensors" so
> we can check the levels.
>
> Thanks,
> regards
> Rudolf
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060921/7579c4e0/attachment-0001.html 
