From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 23 Oct 2007 03:50:14 +0000
Subject: Re: [lm-sensors] Kernel driver w83627dhg Question
Message-Id: <4dfa50520710222050g4418fe09wa47bfda0a9f73641@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Charles,

>  The sensors command seems to work ok.
>
>  x4:~/lm_sensors-3.0.0-rc2 # sensors3 -f
>  coretemp-isa-0000
>  Adapter: ISA adapter
>  Core 0:      +75.2=B0F  (crit =3D +212.0=B0F)
>
>  w83627dhg-isa-0290
>  Adapter: ISA adapter
>  VCore:       +1.31 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>  in1:        +11.88 V  (min =3D  +6.76 V, max =3D  +4.28 V)   ALARM
>  AVCC:        +3.34 V  (min =3D  +0.26 V, max =3D  +3.20 V)   ALARM
>  3VCC:        +3.34 V  (min =3D  +2.61 V, max =3D  +0.82 V)   ALARM
>  in4:         +1.81 V  (min =3D  +0.51 V, max =3D  +1.61 V)   ALARM
>  in5:         +0.10 V  (min =3D  +1.02 V, max =3D  +1.31 V)   ALARM
>  in6:         +4.97 V  (min =3D  +5.84 V, max =3D  +5.48 V)   ALARM
>  VSB:         +3.33 V  (min =3D  +1.54 V, max =3D  +2.42 V)   ALARM
>  VBAT:        +3.12 V  (min =3D  +2.58 V, max =3D  +1.55 V)   ALARM
>  Case Fan:      0 RPM  (min =3D 1757 RPM, div =3D 128)  ALARM
>  CPU Fan:    4326 RPM  (min =3D 1028 RPM, div =3D 8)
>  Aux Fan:       0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
>  fan4:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
>  Sys Temp:    +98.6=B0F  (high =3D +177.8=B0F, hyst =3D +219.2=B0F)  sens=
or > thermistor
>  CPU Temp:    +86.9=B0F  (high =3D +230.0=B0F, hyst =3D +167.0=B0F)  sens=
or =3D diode
>  AUX Temp:    +62.6=B0F  (high =3D +176.0=B0F, hyst =3D +167.0=B0F)  sens=
or > thermistor
>
>
>
>
>  Here are some things I've tried.
>
>
>  x4:/sys/devices/platform/w83627ehf.656 # cat pwm1_enable
>  1
>  x4:/sys/devices/platform/w83627ehf.656 # cat pwm2_enable
>  1
>  x4:/sys/devices/platform/w83627ehf.656 # cat pwm3_enable
>  1
>  x4:/sys/devices/platform/w83627ehf.656 # cat pwm4_enable
>  1
>
>  x4:/sys/devices/platform/w83627ehf.656 # cat pwm1
>  255
>  x4:/sys/devices/platform/w83627ehf.656 # echo 0 > pwm1
>  x4:/sys/devices/platform/w83627ehf.656 # cat pwm1
>  0
>  x4:/sys/devices/platform/w83627ehf.656 # echo 0 > pwm2
>  x4:/sys/devices/platform/w83627ehf.656 # echo 0 > pwm3
>  x4:/sys/devices/platform/w83627ehf.656 # echo 0 > pwm4

Good. It looks like you have all of the pwmN_enable set to manual mode
(1), and have turned off the corresponding pwmN outputs. The pwmconfig
script does the same thing.

>  x4:~/lm_sensors-3.0.0-rc2/prog/pwm # ./pwmconfig
>  This program will search your sensors for pulse width modulation (pwm)
>  controls, and test each one to see if it controls a fan on
>  your motherboard. Note that many motherboards do not have pwm
>  circuitry installed, even if your sensor chip supports pwm.
>
>  We will attempt to briefly stop each fan using the pwm controls.
>  The program will attempt to restore each fan to full speed
>  after testing. However, it is ** very important ** that you
>  physically verify that the fans have been to full speed
>  after the program has completed.
>
>  Found the following devices:
>     hwmon0/device is coretemp
>     hwmon1/device is w83627dhg
>
>  Found the following PWM controls:
>     hwmon1/device/pwm1
>     hwmon1/device/pwm2
>     hwmon1/device/pwm3
>     hwmon1/device/pwm4
>
>  Found the following fan sensors:
>     hwmon1/device/fan1_input     current speed: 0 ... skipping!
>     hwmon1/device/fan2_input     current speed: 4326 RPM
>     hwmon1/device/fan3_input     current speed: 0 ... skipping!
>     hwmon1/device/fan4_input     current speed: 0 ... skipping!
>
>  Warning!!! This program will stop your fans, one at a time,
>  for approximately 5 seconds each!!!
>  This may cause your processor temperature to rise!!!
>  If you do not want to do this hit control-C now!!!
>  Hit return to continue:
>
>  Testing pwm control hwmon1/device/pwm1 ...
>    hwmon1/device/fan2_input ... speed was 4326 now 4440
>      no correlation
>
>  No correlations were detected.
>  There is either no fan connected to the output of hwmon1/device/pwm1,
>  or the connected fan has no rpm-signal connected to one of
>  the tested fan sensors. (Note: not all motherboards have
>  the pwm outputs connected to the fan connectors,
>  check out the hardware database on
> http://www.almico.com/forumindex.php)
>
>  Did you see/hear a fan stopping during the above test (n)?
>
>  Testing pwm control hwmon1/device/pwm2 ...
>    hwmon1/device/fan2_input ... speed was 4326 now 4326
>      no correlation
>
>  No correlations were detected.
>  There is either no fan connected to the output of hwmon1/device/pwm2,
>  or the connected fan has no rpm-signal connected to one of
>  the tested fan sensors. (Note: not all motherboards have
>  the pwm outputs connected to the fan connectors,
>  check out the hardware database on
> http://www.almico.com/forumindex.php)
>
>  Did you see/hear a fan stopping during the above test (n)?
>
>  Testing pwm control hwmon1/device/pwm3 ...
>    hwmon1/device/fan2_input ... speed was 4326 now 4440
>      no correlation
>
>  No correlations were detected.
>  There is either no fan connected to the output of hwmon1/device/pwm3,
>  or the connected fan has no rpm-signal connected to one of
>  the tested fan sensors. (Note: not all motherboards have
>  the pwm outputs connected to the fan connectors,
>  check out the hardware database on
> http://www.almico.com/forumindex.php)
>
>  Did you see/hear a fan stopping during the above test (n)?
>
>  Testing pwm control hwmon1/device/pwm4 ...
>    hwmon1/device/fan2_input ... speed was 4326 now 4440
>      no correlation
>
>  No correlations were detected.
>  There is either no fan connected to the output of hwmon1/device/pwm4,
>  or the connected fan has no rpm-signal connected to one of
>  the tested fan sensors. (Note: not all motherboards have
>  the pwm outputs connected to the fan connectors,
>  check out the hardware database on
> http://www.almico.com/forumindex.php)
>
>  Did you see/hear a fan stopping during the above test (n)?
>
>  Testing is complete.
>  Please verify that all fans have returned to their normal speed.
>
>  The fancontrol script can automatically respond to temperature changes
>  of your system by changing fanspeeds.
>  Do you want to set up its configuration file now (y)?
>  What should be the path to your fancontrol config file (/etc/fancontrol)?
>  /etc/fancontrol does not exist, shall I create it now (y)?
>  Loading configuration from /etc/fancontrol ...
>
>  Select fan output to configure, or other action:
>  1) Change INTERVAL     3) Save and quit
>  2) Just quit           4) Show configuration
>  select (1-n): 2
>  x4:~/lm_sensors-3.0.0-rc2/prog/pwm #
>
>  I compiled the kernel with the attached .config file.    Have I left out=
 a
> 1-wire bus or something?
>
>  Any direction you can provide would be appreciated.
>
>  --
>  Thanks
>  Charles Wright

I would suggest looking at the motherboard. Does it have additional
fan headers? Can you connect the CPU fan to another header and see if
one of the additional headers is successfully controlled by one of the
pwm[1-4] outputs? I'm not suggesting this as a permanent solution, but
it would answer the question mentioned in the fancontrol script:

Does your motherboard have the circuitry needed to drive PWM fans?

Another possibility is that the fan is controlled by the intel
chipset. The PWM outputs from the W83627DHG-B may not be wired up.

The only way to verify this is to contact Intel. However, they provide
fairly good support for open source software. There may be a specific
contact person we can identify.

Please determine if there are any other PWM fan plugs on the
motherboard first. Then let's look at contacting Intel.

Other LM-Sensors developers might also have a better idea.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
