From: Joakim Larsson <joakim@bildrulle.nu>
Date: Sun, 16 Mar 2008 23:05:36 +0000
Subject: Re: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <1205708736.10709.19.camel@montecristo>
List-Id: <lm-sensors.vger.kernel.org>
References: <1205271362.6571.9.camel@montecristo>
In-Reply-To: <1205271362.6571.9.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I got rid of all the Alarms now by tweaking the sensors3.conf

On Sun, 2008-03-16 at 10:53 +0100, Jean Delvare wrote:
> > Case Fan:      0 RPM  (min =  376 RPM, div = 64)  ALARM
> > CPU Fan:    2481 RPM  (min = 2109 RPM, div = 16)
> > Aux Fan:    1298 RPM  (min =  439 RPM, div = 16)
> > fan4:          0 RPM  (min = 8881 RPM, div = 4)  ALARM
> > fan5:          0 RPM  (min = 10227 RPM, div = 4)  ALARM
> 
> I guess that you have only 2 fans in this system, so you can add:

There are three including the one in the power supply. The big case fan
has a manual speed control that I have set to "low".

> These are very reasonable fan speeds and I have to admit that I am
> surprised the one the fans "sounds like your vacuum cleaner".

I have read about the motherboard that it has only speed control for the
CPU fan but so far I have not been able to find the control i/o for it
with pwmconfig (see output below), so I need to dig further.

Maybe I got a silent vacuum cleaner but there is a sustained/constant
noise when the computer is heated up. When the Smart Fan is enabled in
BIOS the computer is somewhat less noisy between 30 degrees and up with
2-3 distinctive steps in speeds for the CPU fan before it reaches
cruising temperature. 

I will try to
- upgrade BIOS (Need to boot into Window$!!!, Grrrr....)
- set the silent chassi fan to mid or high to help CPU fan
- check air flows including heat pipe from CPU fan
- turn off Smart Fan and try to get CPU fan control to work

Do you know where to find info on how to set the target temp for the
Smart Fan feature from Linux? I know there is no support in lm-sensors
yet but it would be fun to try it out.

BR

Joakim

> 
> > Sys Temp:    +37.0°C  (high =  +0.0°C, hyst = +16.0°C)  ALARM  sensor = thermistor
> > CPU Temp:    +18.0°C  (high = +110.0°C, hyst = +125.0°C)  sensor = diode
> > AUX Temp:    +64.0°C  (high = +120.0°C, hyst = +115.0°C)  sensor = thermistor
> 
> While temp1 and temp3 look reasonable, temp2 is way too low to be
> correct. What does the BIOS display? Maybe you need to add some
> arbitrary offset.

$ sudo pwmconfig 
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
   hwmon0/device is w83627dhg

Found the following PWM controls:
   hwmon0/device/pwm1
   hwmon0/device/pwm2
   hwmon0/device/pwm3
   hwmon0/device/pwm4

Giving the fans some time to reach full speed...
Found the following fan sensors:
   hwmon0/device/fan1_input     current speed: 0 ... skipping!
   hwmon0/device/fan2_input     current speed: 2410 RPM
   hwmon0/device/fan3_input     current speed: 1278 RPM
   hwmon0/device/fan4_input     current speed: 0 ... skipping!
   hwmon0/device/fan5_input     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue: 

Testing pwm control hwmon0/device/pwm1 ...
  hwmon0/device/fan2_input ... speed was 2410 now 2410
    no correlation
  hwmon0/device/fan3_input ... speed was 1278 now 1278
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm1,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? 

Testing pwm control hwmon0/device/pwm2 ...
  hwmon0/device/fan2_input ... speed was 2410 now 2343
    no correlation
  hwmon0/device/fan3_input ... speed was 1278 now 1259
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm2,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? 

Testing pwm control hwmon0/device/pwm3 ...
  hwmon0/device/fan2_input ... speed was 2410 now 2410
    no correlation
  hwmon0/device/fan3_input ... speed was 1278 now 1259
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? 

Testing pwm control hwmon0/device/pwm4 ...
  hwmon0/device/fan2_input ... speed was 2410 now 2343
    no correlation
  hwmon0/device/fan3_input ... speed was 1278 now 1259
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm4,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? 

Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)? 
What should be the path to your fancontrol config file
(/etc/fancontrol)? 
Loading configuration from /etc/fancontrol ...

Select fan output to configure, or other action:
1) Change INTERVAL     3) Save and quit
2) Just quit           4) Show configuration
select (1-n): 2
joakim@montecristo:~$ 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
