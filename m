From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Fri, 10 Nov 2006 23:22:25 +0000
Subject: [lm-sensors] About fancontrol: I could not control the CPU fan
Message-Id: <200611110022.25729.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
In-Reply-To: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yongkui,

sorry for my late answering - I was out for a few days.

Since I do not have full insigight to neither the driver nor the internal connections of the board I need to guess. maybe the drivers author can give some more advice.

Please see table 12 in your motherboard spec. 

It says Processor fan and fan 2 can be monitored. The  LPC47M142-NC does not have more than 2 inputs to observe more fans. I guess you may see Processor fan speed on fan1_input and Fan2??s speed on fan2_input or vice versa. 
Please confirm.

The  LPC47M142-NC seem to have also only 2 pwm control outputs, pwm1 2nd 2.
As to table 12 you should be able to control fan 1 and fan2/3 where fan 2 and 3 receive the same voltage. 
So I gues you may be able to control Fan1 by pwm1 and Fan2/3 by pwm2 in manual mode - maybe vice versa.

Please confirm if you can control both Fan1 and Fan2 independently by pwm1 and pwm2 in manual mode.

Table 12 clearly says that the processor fan is not controllable. So I am surprised that you can at least switch it by setting pwm1 to zero.  This might be some extra logic or some extra pin which is just a on/off control. You need to study the data sheet and the driver to proceed here.

My Suggestions: 
How many fans you want to control in total indendently?
Maybe you change the CPU fan to MB-Fan2-pin because Fan2 is observable and controllable and use Fan1 or fan3 for a case fan?

If you do so please be careful to observe the fan to run when the cpu heats up so you don??t damage anything.

Best regards
	Christian


Am Sonntag, 5. November 2006 01:19 schrieb Yongkui Han:
> Hi Christian,
>
> Thank you very much for your reply!
>
> I answered your questions about my fan, they are after your questions in
> below.
>
> Could you give me some suggestions?
>
> Thanks!
> Yongkui
>
> On 11/4/06, Christian Mahr <christian.mahr.ulm at arcor.de > wrote:
> > Hi Yonkui,
> >
> > -is this a 3 or 4 pin fan?
> > -is this a 3 or 4 pin connector on MB?
>
> Mine is a 3 pin fan. There are 3 wires: Green, Yellow, and Black. It should
> be a 3pin connector on MB. I attached a picture of the fan connector for
> your reference.


> The motherboard manual can be downloaded here:
> ftp://download.intel.com/design/motherbd/mv/A6514501.pdf
>
> > when you operate pwm1 manually,
> > - can you see the value with cat pwm1 you did write ther before?
>
> Yes, I can see the value of pwm1 with cat.
> [etc2 9191-0800]$ cat pwm1
> 252
> [etc2 9191-0800]$
>
> - are you sure to be in manual mode pwm_enable=1 ?
>
>
> Yes, I use the command "echo 1 > pwm1_enable" to set it.
> [root at etc2 9191-0800]#cat pwm1
> 252
> [root at etc2 9191-0800]# cat pwm1_enable
> 0
> [root at etc2 9191-0800]# echo 1 > pwm1_enable
> [root at etc2 9191-0800]# cat pwm1_enable
> 1
> [root at etc2 9191-0800]# cat pwm1
> 252
> [root at etc2 9191-0800]# echo 32 > pwm1
> [root at etc2 9191-0800]# cat pwm1
> 32
> [root at etc2 9191-0800]#
>
> - what do the other pwm1* register read?
>
> The following are all the files under the super I/O chip device directory:
> [yonhan at etc2 9191-0800]$ pwd
> /sys/bus/i2c/devices/9191-0800
> [yonhan at etc2 9191-0800]$ ls
> alarms  driver    fan1_input  fan2_div    fan2_min      name   pwm1
> pwm2         uevent
> bus     fan1_div  fan1_min    fan2_input  hwmon:hwmon1  power  pwm1_enable
> pwm2_enable
> [yonhan at etc2 9191-0800]$
>
> The pwm2 register is same as pwm1 register. The pwmconfig reports pwm1 is
> associated with fan1_input.
> [etc2 9191-0800]$ cat pwm2
> 252
> [etc2 9191-0800]$ cat pwm2_enable
> 0
> [etc2 9191-0800]$
>
> Thanks!
>
> Christian
>
> > Am Samstag, 4. November 2006 04:34 schrieb Yongkui Han:
> > > HI,
> > >
> > > Could anybody help me with this, or point me to somewhere?
> > >
> > > Thanks!
> > >
> > > Thanks.
> > > Yongkui
> > >
> > > On 10/30/06, Yongkui Han <hanyongkui99 at gmail.com> wrote:
> > > > Hi All,
> > > >
> > > > I just found the following information on page 43 of the motherboard
> > > > manual.
> > > > ftp://download.intel.com/design/motherbd/mv/A6514501.pdf
> > > >
> > > > --------------------------
> > > > 1.14.2.2 Fan Connectors
> > > > The D850MD and D850MV boards have two fan connectors with thermal
> >
> > control
> >
> > > > signals (fan 1
> > > > and fan 2) that are used to switch the fans on and off as determined
> >
> > by
> >
> > > > the thermal sensors.
> > > > The ambient temperature of a D850MD- or D850MV-based system is
> >
> > thermally
> >
> > > > monitored by
> > > > separate temperature sensors that control voltage to the fan 1 and
> > > > fan
> >
> > 2
> >
> > > > connectors. If the fans
> > > > attached to these connectors provide a tachometer signal, the sensor
> > > > reports the fan speed to the hardware monitor component.
> > > > The temperature sensors that control the fans are initialized by the
> >
> > BIOS
> >
> > > > at power-up to turn on only when the sensor reaches 36 oC (96.8 oF).
> >
> > The
> >
> > > > fans switch off when their respective sensors cool down to 31 oC
> > > > (87.8oF). This prevents the fans from turning off and on when the
> >
> > ambient
> >
> > > > air around the sensor fluctuates around 35???36 oC. When the fans
> > > > switch on, they may appear to rotate slowly because the fan's duty
> > > > cycle
> >
> > starts
> >
> > > > at 70 percent and rises to 100 percent when the sensor reaches 46 oC
> > > > (
> > > >
> > > > 114.8oF). Table 12 summarizes the functions of the four fan
> >
> > connectors.
> >
> > > > Table 12. Fan Connector Descriptions
> > > >
> > > > Feature                          Processor Fan       Fan 1
> > > >  Fan 2                       Fan 3
> > > > +12 V DC connection       Yes                      Yes
> > > > Yes                         Yes
> > > > Tachometer output           Yes
> > > > No                      Yes                         No
> > > > Controllable                     No
> > > > Yes                    Yes                         Yes
> > > > ----------------------------
> > > >
> > > > In the Table 12, It says the Processor Fan is not controllable,
> >
> > although
> >
> > > > the other fans are controllable.
> > > >
> > > > So this means that I cannot control the CPU fan speed. But it seems
> >
> > that
> >
> > > > we could do some tricks to make the system think the thermal sensor
> > > > is
> > > >
> > > > higher than 46C. Then the CPU fan speed should run at full speed.
> > > > Then this is what I want, a fixed CPU fan speed.
> > > >
> > > > Any suggestions?
> > > >
> > > > Thanks!
> > > > Yongkui
> > > >
> > > >  On 10/30/06, Yongkui Han <hanyongkui99 at gmail.com > wrote:
> > > > > Hi All,
> > > > >
> > > > > I am trying to control the speed of the CPU fan.  I would like to
> >
> > set
> >
> > > > > constant CPU fan spee d.
> > > > >
> > > > > My CPU fan is Intel Fan & Heatsink A65061-001, with 3 wires, green,
> > > > > yellow, and black.
> > > > >
> > > > > I run pwmconfig to see /sys/bus/i2c/devices/9191-0800/pwm1 is
> > > > > controling fan1_input, which is the CPU fan, and saved the default
> > > > > configuration into /etc/fancontrol file. The pwmconfig command
> >
> > didn't
> >
> > > > > report any errors but I noticed that when it reports the CPU fan
> >
> > speed
> >
> > > > > of 0, the CPU fan is actually still running. Also, the GNUPLOT
> > > > > graph
> >
> > of
> >
> > > > > the correlation between PWM and Fan Speed is very strange. The fan
> > > > > speed are 3233 for all PWM values 2--255, and the fan speed is 0
> > > > > for PWM=0. This is very weird.  The pdf file pwmtest.pdf is
> > > > > enclosed for your reference.
> > > > >
> > > > > Then I run fancontrol command. the command is running correctly
> >
> > without
> >
> > > > > reporting errors. Now the sensors command will only report a fan
> >
> > speed
> >
> > > > > of 0 RPM. But the problem is the CPU fan is still running, it never
> > > > > stops at all.
> > > > >
> > > > >
> > > > > I also tried not to use fancontrol. I use the command: echo 64 >
> > > > > /sys/bus/i2c/devices/9191-0800/pwm1, but still this had no effect
> > > > > on the CPU fan speed.
> > > > >
> > > > > Could some one help me with the CPU fan speed control?
> > > > >
> > > > > Thanks!
> > > > >
> > > > > BTW,
> > > > > I have an Intel D850MV motherboard. There is an ADM1025A sensor
> > > > > chip
> >
> > on
> >
> > > > > the motherboard. Also there is an LPC47M142-NC Super I/O chip on
> > > > > the
> > > > >
> > > > > motherboard. My CPU is a Pentium 4 CPU, 1.7GHz.
> > > > >
> > > > > The following is a sample output for my lm-sensors software.
> > > > > ---------------------------------
> > > > > $ sensors
> > > > > adm1025-i2c-0-2d
> > > > > Adapter: SMBus I801 adapter at efa0
> > > > >
> > > > > +2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
> > > > > VCore:     +1.68 V  (min =  +1.66 V, max =  +1.84 V)
> > > > > +3.3V:     +3.30 V  (min =  +2.97 V, max =  +3.63 V)
> > > > > +5V:       +5.13 V  (min =  +4.50 V, max =  +5.50 V)
> > > > > VCC:       +3.30 V  (min =  +2.97 V, max =  +3.63 V)
> > > > > CPU Temp:  +35.0??C  (low  =   +10??C, high =   +60??C)
> > > > > M/B Temp:  +34.0??C  (low  =   +10??C, high =   +45??C)
> > > > > vid:      +1.750 V  (VRM Version 9.0)
> > > > >
> > > > > smsc47m1-isa-0800
> > > > > Adapter: ISA adapter
> > > > > fan1:     3233 RPM  (min =  640 RPM, div = 8)
> > > > > fan2:        0 RPM  (min =  640 RPM, div = 8)
> > > > > --------------------------------------------------------------
> > > > >
> > > > >
> > > > > Regards,
> > > > > Yongkui
> >
> > ___________________________________________________________
> > Der fr???he Vogel f???ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail:
> > http://mail.yahoo.de
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061111/1ad7ee03/attachment-0001.html 
