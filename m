From: hanyongkui99@gmail.com (Yongkui Han)
Date: Sat, 04 Nov 2006 03:34:29 +0000
Subject: [lm-sensors] About fancontrol: I could not control the CPU fan
Message-Id: <2ca62ec0611031934l7c2781a8i513ff6cd8814f022@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
In-Reply-To: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

HI,

Could anybody help me with this, or point me to somewhere?

Thanks!

Thanks.
Yongkui


On 10/30/06, Yongkui Han <hanyongkui99 at gmail.com> wrote:
>
> Hi All,
>
> I just found the following information on page 43 of the motherboard
> manual.
> ftp://download.intel.com/design/motherbd/mv/A6514501.pdf
>
> --------------------------
> 1.14.2.2 Fan Connectors
> The D850MD and D850MV boards have two fan connectors with thermal control
> signals (fan 1
> and fan 2) that are used to switch the fans on and off as determined by
> the thermal sensors.
> The ambient temperature of a D850MD- or D850MV-based system is thermally
> monitored by
> separate temperature sensors that control voltage to the fan 1 and fan 2
> connectors. If the fans
> attached to these connectors provide a tachometer signal, the sensor
> reports the fan speed to the hardware monitor component.
> The temperature sensors that control the fans are initialized by the BIOS
> at power-up to turn on only when the sensor reaches 36 oC (96.8 oF). The
> fans switch off when their respective sensors cool down to 31 oC (87.8oF). This prevents the fans from turning off and on when the ambient air
> around the sensor fluctuates around 35?36 oC. When the fans switch on, they
> may appear to rotate slowly because the fan's duty cycle starts at 70
> percent and rises to 100 percent when the sensor reaches 46 oC ( 114.8oF).
> Table 12 summarizes the functions of the four fan connectors.
> Table 12. Fan Connector Descriptions
>
> Feature                          Processor Fan       Fan 1
>  Fan 2                       Fan 3
> +12 V DC connection       Yes                      Yes
> Yes                         Yes
> Tachometer output           Yes
> No                      Yes                         No
> Controllable                     No
> Yes                    Yes                         Yes
> ----------------------------
>
> In the Table 12, It says the Processor Fan is not controllable, although
> the other fans are controllable.
>
> So this means that I cannot control the CPU fan speed. But it seems that
> we could do some tricks to make the system think the thermal sensor is
> higher than 46C. Then the CPU fan speed should run at full speed. Then this
> is what I want, a fixed CPU fan speed.
>
> Any suggestions?
>
> Thanks!
> Yongkui
>
>
>
>  On 10/30/06, Yongkui Han <hanyongkui99 at gmail.com > wrote:
> >
> > Hi All,
> >
> > I am trying to control the speed of the CPU fan.  I would like to set
> > constant CPU fan spee d.
> >
> > My CPU fan is Intel Fan & Heatsink A65061-001, with 3 wires, green,
> > yellow, and black.
> >
> > I run pwmconfig to see /sys/bus/i2c/devices/9191-0800/pwm1 is controling
> > fan1_input, which is the CPU fan, and saved the default configuration into
> > /etc/fancontrol file. The pwmconfig command didn't report any errors but I
> > noticed that when it reports the CPU fan speed of 0, the CPU fan is actually
> > still running. Also, the GNUPLOT graph of the correlation between PWM and
> > Fan Speed is very strange. The fan speed are 3233 for all PWM values 2--255,
> > and the fan speed is 0 for PWM=0. This is very weird.  The pdf file
> > pwmtest.pdf is enclosed for your reference.
> >
> > Then I run fancontrol command. the command is running correctly without
> > reporting errors. Now the sensors command will only report a fan speed of 0
> > RPM. But the problem is the CPU fan is still running, it never stops at all.
> >
> >
> > I also tried not to use fancontrol. I use the command: echo 64 >
> > /sys/bus/i2c/devices/9191-0800/pwm1, but still this had no effect on the
> > CPU fan speed.
> >
> > Could some one help me with the CPU fan speed control?
> >
> > Thanks!
> >
> > BTW,
> > I have an Intel D850MV motherboard. There is an ADM1025A sensor chip on
> > the motherboard. Also there is an LPC47M142-NC Super I/O chip on the
> > motherboard. My CPU is a Pentium 4 CPU, 1.7GHz.
> >
> > The following is a sample output for my lm-sensors software.
> > ---------------------------------
> > $ sensors
> > adm1025-i2c-0-2d
> > Adapter: SMBus I801 adapter at efa0
> >
> > +2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
> > VCore:     +1.68 V  (min =  +1.66 V, max =  +1.84 V)
> > +3.3V:     +3.30 V  (min =  +2.97 V, max =  +3.63 V)
> > +5V:       +5.13 V  (min =  +4.50 V, max =  +5.50 V)
> > VCC:       +3.30 V  (min =  +2.97 V, max =  +3.63 V)
> > CPU Temp:  +35.0?C  (low  =   +10?C, high =   +60?C)
> > M/B Temp:  +34.0?C  (low  =   +10?C, high =   +45?C)
> > vid:      +1.750 V  (VRM Version 9.0)
> >
> > smsc47m1-isa-0800
> > Adapter: ISA adapter
> > fan1:     3233 RPM  (min =  640 RPM, div = 8)
> > fan2:        0 RPM  (min =  640 RPM, div = 8)
> > --------------------------------------------------------------
> >
> >
> > Regards,
> > Yongkui
> >
> >
> >
> >
> >
> >
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061103/9875db8a/attachment-0001.html 
