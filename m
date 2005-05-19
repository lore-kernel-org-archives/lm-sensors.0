From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <3F973CB1.D2CFA835@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the pwmconfig output.
looks like there are still some bugs in that program
that need work :)

Marc Rieffel wrote:
> 
> Yes, pwmconfig seems to confirm the cross-connection of fans.  The output is below.  On this particular system max6650/fan1 is disconnected, which is correctly detected.
> 
> It found that max6650/fan2 is controlled by w83627hf/pwm1, and that w83627hf/fan2 is controlled by w83627hf/pwm2, but it didn't detect that w83627hf/fan1 is also controlled by w83627hf/pwm2.  It may have gotten confused when the pwm setting was mysteriously modified by some other process (or the bios?).
> 
> Also, the fancontrol file doesn't seem to reflect the configuration that it detected.
> 
> ******************
> 
> [root@gb0007 lm_sensors-2.8.1]# prog/pwm/pwmconfig                              This program will search your sensors for pulse width modulation (pwm)
> controls, and test each one to see if it controls a fan on
> your motherboard. Note that many motherboards do not have pwm
> circuitry installed, even if your sensor chip supports pwm.
> 
> We will attempt to briefly stop each fan using the pwm controls.
> The program will attempt to restore each fan to full speed
> after testing. However, it is ** very important ** that you
> physically verify that the fans have been to full speed
> after the program has completed.
> 
> Found the following PWM controls:
>    w83627hf-isa-0290/pwm1
>    w83627hf-isa-0290/pwm2
> 
> Found the following fan sensors:
>    max6650-i2c-0-1b/fan1     current speed: 0 ... skipping!
>    max6650-i2c-0-1b/fan2     current speed: 3510 RPM
>    max6650-i2c-0-1b/fan3     current speed: 6570 RPM
>    max6650-i2c-0-1b/fan4     current speed: 6330 RPM
>    w83627hf-isa-0290/fan1     current speed: 3214 RPM
>    w83627hf-isa-0290/fan2     current speed: 3183 RPM
>    w83627hf-isa-0290/fan3     current speed: 3183 RPM
> 
> Warning!!! This program will stop your fans, one at a time,
> for approximately 5 seconds each!!!
> This may cause your processor temperature to rise!!!
> If you do not want to do this hit control-C now!!!
> Hit return to continue:
> 
> Testing pwm control w83627hf-isa-0290/pwm1 ...
>   max6650-i2c-0-1b/fan2 ... speed was 3510 now 1680
>     It appears that fan max6650-i2c-0-1b/fan2
>     is controlled by pwm w83627hf-isa-0290/pwm1
>     Would you like to generate a detailed correlation (y) ?
>     PWM 255 FAN 3540
>     PWM 240 FAN 3540
>     PWM 225 FAN 3540
>     PWM 210 FAN 3540
>     PWM 195 FAN 3510
>     PWM 180 FAN 3510
>     PWM 165 FAN 3540
>     PWM 150 FAN 3540
>     PWM 135 FAN 3540
>     PWM 120 FAN 3510
>     PWM 105 FAN 3510
>     PWM 90 FAN 3510
>     PWM 75 FAN 3510
>     PWM 60 FAN 3510
>     PWM 45 FAN 3540
>     PWM 30 FAN 3540
>     PWM 15 FAN 3510
>     PWM 0 FAN 2160
> 
>   max6650-i2c-0-1b/fan3 ... speed was 6570 now 6600
>     no correlation
>   max6650-i2c-0-1b/fan4 ... speed was 6330 now 6330
>     no correlation
>   w83627hf-isa-0290/fan1 ... speed was 3214 now 0
>     It appears that fan w83627hf-isa-0290/fan1
>     is controlled by pwm w83627hf-isa-0290/pwm1
>     Fan w83627hf-isa-0290/fan1 has not returned to speed, please investigate!
>   w83627hf-isa-0290/fan2 ... speed was 3183 now 0
>     It appears that fan w83627hf-isa-0290/fan2
>     is controlled by pwm w83627hf-isa-0290/pwm1
>     Fan w83627hf-isa-0290/fan2 has not returned to speed, please investigate!
>   w83627hf-isa-0290/fan3 ... speed was 3183 now 3183
>     no correlation
> 
> Testing pwm control w83627hf-isa-0290/pwm2 ...
>   max6650-i2c-0-1b/fan2 ... speed was 3510 now 3540
>     no correlation
>   max6650-i2c-0-1b/fan3 ... speed was 6570 now 6600
>     no correlation
>   max6650-i2c-0-1b/fan4 ... speed was 6330 now 6330
>     no correlation
>   w83627hf-isa-0290/fan1 ... speed was 3214 now 0
>     It appears that fan w83627hf-isa-0290/fan1
>     is controlled by pwm w83627hf-isa-0290/pwm2
>     Fan w83627hf-isa-0290/fan1 has not returned to speed, please investigate!
>   w83627hf-isa-0290/fan2 ... speed was 3183 now 0
>     It appears that fan w83627hf-isa-0290/fan2
>     is controlled by pwm w83627hf-isa-0290/pwm2
>     Would you like to generate a detailed correlation (y) ?
>     PWM 255 FAN 3169
>     PWM 240 FAN 3169
>     PWM 225 FAN 3169
>     PWM 210 FAN 3276
>     PWM 195 FAN 3183
>     PWM 180 FAN 3169
>     PWM 165 FAN 3169
>     PWM 150 FAN 3169
>     PWM 135 FAN 3260
>     PWM 120 FAN 3276
>     PWM 105 FAN 3169
>     PWM 90 FAN 3169
>     PWM 75 FAN 3154
>     PWM 60 FAN 3169
>     PWM 45 FAN 3169
>     PWM 30 FAN 3245
>     PWM 15 FAN 0
>     Fan Stopped at PWM = 15
> 
>   w83627hf-isa-0290/fan3 ... speed was 3183 now 3245
>     no correlation
> 
> Testing is complete.
> Please verify that all fans have returned to their normal speed.
> 
> The fancontrol script can automatically respond to temperature changes
> of your system by changing fanspeeds. Do you want to set up its
> configuration file now? (y)
> 
> What should be the path to your fancontrol config file? (/etc/fancontrol)
> 
> Loading configuration from /etc/fancontrol ...
> 
> Select fan output to configure:
> 1) w83627hf-isa-0290/pwm2  6) Change INTERVAL
> 2) w83627hf-isa-0290/pwm2  7) Just quit
> 3) w83627hf-isa-0290/pwm1  8) Save and quit
> 4) w83627hf-isa-0290/pwm1  9) Show configuration
> 5) w83627hf-isa-0290/pwm1
> #? 9
> 
> Common Settings:
> INTERVAL
> 
> Settings of w83627hf-isa-0290/pwm2:
>   Depends on
>   MINTEMP>   MAXTEMP>   MINSTART>   MINSTOP> 
> Settings of w83627hf-isa-0290/pwm2:
>   Depends on
>   MINTEMP>   MAXTEMP>   MINSTART>   MINSTOP> 
> Settings of w83627hf-isa-0290/pwm1:
>   Depends on
>   MINTEMP>   MAXTEMP>   MINSTART>   MINSTOP> 
> Settings of w83627hf-isa-0290/pwm1:
>   Depends on
>   MINTEMP>   MAXTEMP>   MINSTART>   MINSTOP> 
> Settings of w83627hf-isa-0290/pwm1:
>   Depends on
>   MINTEMP>   MAXTEMP>   MINSTART>   MINSTOP> 
> #? 8
> 
> Saving configuration to /etc/fancontrol...
> Configuration saved
> 
> > -----Original Message-----
> > From: Mark Studebaker [mailto:mds@paradyne.com]
> > Sent: Monday, October 20, 2003 5:23 PM
> > To: Marc Rieffel
> > Cc: sensors@stimpy.netroedge.com; John Morris; Bob Y. Hsin
> > Subject: Re: Issues with lm_sensors on Intel SE7501cw2
> >
> >
> > one program that may be helpful for you is prog/pwm/pwmconfig.
> > If it's working well it should confirm the motherboard setup
> > you documented below, including the 'cross-connection'.
> >
> >
> > Marc Rieffel wrote:
> > >
> > > > > [root@gb0007 lm_sensors-2.8.1]# rmmod w83781d
> > > >
> > > > That module isn't supposed to be loaded at this moment. There's
> > > > something unclear here, the rmmod command should return
> > an error. Can
> > > > you test that again, checking with lsmod which modules
> > are loaded each
> > > > time? Don't you have some kind of module auto-loading
> > making trouble
> > > > here? Taking a look at dmesg while loading/unloading the
> > modules could
> > > > help.
> > >
> > > I tried this again and it worked normally.  With 83781d
> > loaded, I get nothing.  With w83627hf loaded, I see the
> > sensors.  Maybe I cut and pasted the wrong thing in my initial email.
> > >
> > > >
> > > > > 2. The max6650 fan speed measurement seems to be all or
> > nothing.  If
> > > > > there's a (Sunon) fan connected and operational, it reports
> > > > 7650RPM.
> > > > > If there's no fan connected, it reports 0 RPM.  If I
> > physically slow
> > > > > the fan down, it still report 7650 RPM.  (The tachs on
> > the w83627hf
> > > > > sensor do show decreased rpm when I impede their fans).
> > >
> > > Any thoughts on this?
> > >
> > > > > 3. The fan speeds reported (7650 or 18,000-21,000) seem to be
> > > > > inconsistent with the advertised speeds.  Changing the divisors
> > > > > doesn't seem to affect the reported values.
> > >
> > > Or this?
> > >
> > > > > 4. The speed control on the max6650 doesn't seem to work.
> > > > See below.
> > > >
> > > > Strange. Could be because the driver assumes too much
> > conditions that
> > > > aren't correct for your system. The MAX6650 driver was
> > contributed by
> > > > John Morris. John, could you please take a look at Mark's problem?
> > > >
> > > > > 5. The w83627hf's "pwm1" setting seems to have no effect:
> > > >
> > > > I think that PWM needs special wiring on the motherboad
> > in order to
> > > > work. Could it be that your motherboard doesn't have it?
> > > >
> > >
> > > Well, I've figured out part of the answer to 4 & 5.  Here's
> > how my motherboard is set up.
> > >
> > > Fan             Controlled by           Monitored by
> > > J29/sys3        w83627hf pwm1           max6651 fan1
> > > J30/sys4        w83627hf pwm1           max6651 fan2
> > > J16/cpu1        n/a                             max6651 fan3
> > > J14/cpu2        n/a                             max6651 fan4
> > > J3/sys2 w83627hf pwm2           w83627hf fan1
> > > J1/sys1 w83627hf pwm2           w83627hf fan2
> > > J58/sys5        max6651 speed           w83627hf fan3
> > >
> > > I can't begin to imagine why they have these chips
> > cross-connected, with one chip controlling a fan and a
> > different chip monitoring it.  The Winbond has two pwm's,
> > each controlling two fans, and it only operates in "open
> > loop" mode.  I read the max6651 data sheet
> > (http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf), and
> > it supports four modes, always on, always off, open loop (use
> > pwm to achieve a desired voltage), and closed loop (use pwm
> > to achieve a desired fan1 speed).  Reading the configuration
> > register from the driver suggests that it's in closed loop mode.
> > >
> > > # cat /proc/sys/dev/sensors/max6650-i2c-0-1b/xdump
> > > 38 42 255 0 0 0 31 2
> > >
> > > Bits 5 and 4 of 42 are 1 and 0
> > >
> > > The fact that changing the "speed" setting affects the
> > speed of the J58 fan suggests that it's actually operating in
> > "open loop" mode.  Given that it isn't wired to monitor the
> > fan that it's controlling, I would think there's no way that
> > it could run in closed loop mode.
> > >
> > > Question: Am I interpreting the xdump values correctly?
> > >
> > > Request: How about making the xdump values easier to
> > interpret, and making the configuration register writable in
> > software, so that I can try things like setting it to always-off mode?
> > >
> > > > > 6. The w83627hf's "pwm2" setting is able to reduce the
> > > > speed of fans 1
> > > > > and 2, but only to about half.  I can hear them change
> > > > speed when I do
> > > > > this.  I can't get them to stop completely, though.
> > > >
> > > > This may be a feature more that a bug. Fully starting a
> > fan requires a
> > > > higher current. What's more, stopping a fan completely is somewhat
> > > > dangerous, isn't it? Same as for PWM1, I think that PWM2
> > > > works thank to
> > > > adequate wiring on your motherboard, but maybe the wiring and
> > > > electronics are such that the W83627HF isn't allowed to
> > lower the fan
> > > > speed below a given threshold.
> > >
> > > The max6651 data sheet says something about how lowering
> > the PWM and therefore the voltage on the fan may result in
> > odd behavior, like the fan stopping completely or the tach
> > signal not reporting at all or reporting too many times.  I
> > suppose that makes sense.  That doesn't explain why setting
> > PWM to zero doesn't stop the fan, though.  If my observations
> > are consistent with those of others, and there's no real way
> > to stop the fans, I can live with that.  I don't really need
> > to stop the fans.  I'm just trying to understand what's going
> > on.  So far everything I've tried has given me a result
> > different from what I've expected, and that makes it hard for
> > me to have much confidence that the system is doing what I
> > think it is.
> > >
> > > > > 7.  Changes to the "pwm2" setting seem to be transient.
> >  Something
> > > > > happens to change it back to 255.
> > > > >
> > > > > [root@oscarnode001 root]# cat
> > > > > /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     0 1
> > > > > [root@oscarnode001 root]# sleep 60
> > > > > [root@oscarnode001 root]# cat
> > > > > /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     255 1
> > > >
> > > > Don't you by any chance have a monitoring daemon running on
> > > > the machine?
> > >
> > > I'm not aware of any, but RH9 may have installed something
> > that I don't know about.  How can I tell?  What are the names
> > of some monitoring daemons that I could check for?
> > >
> > > >
> > > > > 8. Sometimes the "lm75" module loads and detects
> > something.  I'm not
> > > > > aware of there being any lm75's or compatible devices on
> > > > this system.
> > > > > (...)
> > > > > 9. The lm75's temperature readings are bogus.  At an
> > earlier point I
> > > > > got them to report reasonable values, but I can't get
> > back to that
> > > > > state.
> > > >
> > > > Could you provide the output of "i2cdetect 0"? I'd also be
> > > > interested in
> > > > the output of "i2cdump 0 0x1f" since you seem to have an
> > unknown chip
> > > > there.
> > > >
> > >
> > > ]# i2cdetect 0
> > >   WARNING! This program can confuse your I2C bus, cause
> > data loss and worse!
> > >   I will probe file /dev/i2c-0
> > >   You have five seconds to reconsider and press CTRL-C!
> > >
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > > 10: XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX 1f
> > > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > > 30: 30 31 XX XX 34 35 XX XX XX XX XX XX XX XX XX XX
> > > 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > > 50: UU UU XX XX UU UU XX XX XX XX XX XX XX XX XX XX
> > > 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> > > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > >
> > > > Strangely, sensors-detect didn't report any client found at these
> > > > addresses (0x48 and 0x49). Could you run sensors-detect
> > again (unload
> > > > all client drivers first) and see if it now does? These
> > LM75s could
> > > > actually be emulated by your w83627hf, although it's unusual
> > > > to see this
> > > > behavior when the w83627hf itself is on the ISA (as opposed
> > > > to I2C) bus.
> > > >
> > >
> > > I tried it again.  No lm75's.  Output below.
> > >
> > > > > 10.  The default value for the sensor type on the  w83627hf's
> > > > > temperature sensor, according to sensors.conf, is
> > > > thermistor (3435).
> > > > > But for me it seems to be defaulting to "1", PII/Celeron Diode.
> > > >
> > > > The "defaults" might be confusing, I agree. This refers
> > to power-up
> > > > default for the chip. The BIOS may then reconfigure the chip
> > > > during the
> > > > boot process. I believe that this is what has happened there.
> > > >
> > > > If you believe that we should say the things differently in the
> > > > configuration file, suggestions are welcome.
> > >
> > > It would be helpful if you included your clarification
> > about chip vs. bios defaults.
> > >
> > > >
> > > > Thanks for the long and detailed report. I doubt we'll be able to
> > > > quickly solve all the problems you encountered, since
> > there are many,
> > > > still this will help us if similar problems are reported in
> > > > the future,
> > > > plus I hope I clarified some points.
> > >
> > > Thanks for your help.
> > >
> > > This whole thing has turned out to be much more complicated
> > and difficult than I would have expected.  I've been at it
> > for over a week now, with thermometers, multimeters,
> > oscilliscopes, duct tape and bailing wire.  I finally have
> > the temperature information I want, and I can tell if my fans
> > are running or not, but I'm still not sure if sensors is
> > reporting the correct fan speed.
> > >
> > > On the positive side, when I first tried lm_sensors a year
> > or two ago, I got absolutely nowhere, so it's obviously come
> > a long way since then.  Keep up the good work!
> > >
> >
