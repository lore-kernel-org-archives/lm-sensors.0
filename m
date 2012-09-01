From: Francesco Turco <fturco@fastmail.fm>
Date: Sat, 01 Sep 2012 17:11:32 +0000
Subject: [lm-sensors] Some doubts with fancontrol
Message-Id: <504241C4.30701@fastmail.fm>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000809070004000000080304"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000809070004000000080304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I have a Lenovo Thinkpad R61 laptop and I'm trying to set up correctly 
fancontrol on it.

First of all, I loaded the thinkpad-acpi kernel module with the 
fan_control=1 option, otherwise the following steps don't work.

Then I ran pwmconfig in order to generate the /etc/fancontrol file.

Finally, I started fancontrol via "rc.d start fancontrol" (I'm running 
an Arch Linux system).

When idle, I get:
- fan1: 2604 RPM
- temp1: +40.0C

When busy, I get:
- fan1: 3176 RPM
- temp1: +65.0C

If now I stop fancontrol with "rc.d stop fancontrol" and wait some 
minutes, I get (system is stil busy):
- fan1: 4993 RPM
- temp1: +58.0C

That is, fan speed skyrocketed without any reason.

At http://www.kernel.org/doc/Documentation/laptops/thinkpad-acpi.txt I 
learned this is called "disengaged" mode, and it's not a safe mode to 
use. Let me quote:

 > There is also a "full-speed" level, also known as "disengaged" level.
In this level, the EC disables the speed-locked closed-loop fan control,
and drives the fan as fast as it can go, which might exceed hardware
limits, so use this level with caution.

I also noticed that while fancontrol is running, file 
/sys/class/hwmon/hwmon2/device/pwm1_enable is set to 1 (PWM manual), 
while when it quits that file is set to 0 (PWM disabled) instead of 2 
(PWM automatic). Why?

Beside this, I also tried manually setting PWM values in 
/sys/class/hwmon/hwmon2/device/pwm1, and I found that with values 
between 32 and 255 the fan runs, while with values between 0 and 31 the 
fan stops completely. My question is: MINSTART/MINSTOP should be both 32 
in my case?

Last thing. It seems the only values you can save into 
/sys/class/hwmon/hwmon2/device/pwm1 are: 255, 218, 182, 145, 109, 72, 36 
and 0. Other values get mapped to those previous values. Is this normal?

Thank you and sorry for the long message.

--------------000809070004000000080304
Content-Type: text/plain; charset=UTF-8;
 name="pwmconfig.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pwmconfig.txt"

# pwmconfig revision 5857 (2010-08-22)
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
   hwmon0 is acpitz
   hwmon1/device is coretemp
   hwmon2/device is thinkpad

Found the following PWM controls:
   hwmon2/device/pwm1
hwmon2/device/pwm1 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n) 
There are no usable PWM outputs.
[root@laptop ~]# pwmconfig 
# pwmconfig revision 5857 (2010-08-22)
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
   hwmon0 is acpitz
   hwmon1/device is coretemp
   hwmon2/device is thinkpad

Found the following PWM controls:
   hwmon2/device/pwm1
hwmon2/device/pwm1 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n) y

Giving the fans some time to reach full speed...
Found the following fan sensors:
   hwmon2/device/fan1_input     current speed: 2733 RPM

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue: 

Testing pwm control hwmon2/device/pwm1 ...
  hwmon2/device/fan1_input ... speed was 2733 now 0
    It appears that fan hwmon2/device/fan1_input
    is controlled by pwm hwmon2/device/pwm1
Would you like to generate a detailed correlation (y)? y
Note: If you had gnuplot installed, I could generate a graphical plot.
    PWM 255 FAN 2554
    PWM 240 FAN 2896
    PWM 225 FAN 3041
    PWM 210 FAN 3041
    PWM 195 FAN 3070
    PWM 180 FAN 3070
    PWM 165 FAN 2766
    PWM 150 FAN 2766
    PWM 135 FAN 2766
    PWM 120 FAN 2766
    PWM 105 FAN 2766
    PWM 90 FAN 2766
    PWM 75 FAN 2415
    PWM 60 FAN 2415
    PWM 45 FAN 2415
    PWM 30 FAN 0
    Fan Stopped at PWM = 30


Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)? y
What should be the path to your fancontrol config file (/etc/fancontrol)? 
Loading configuration from /etc/fancontrol ...

Select fan output to configure, or other action:
1) hwmon2/device/pwm1  3) Just quit	      5) Show configuration
2) Change INTERVAL     4) Save and quit
select (1-n): 4

Saving configuration to /etc/fancontrol...
Configuration saved

--------------000809070004000000080304
Content-Type: text/plain; charset=UTF-8;
 name="fancontrol.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fancontrol.txt"

# Configuration file generated by pwmconfig, changes will be lost
INTERVAL=10
DEVPATH=hwmon2=devices/platform/thinkpad_hwmon
DEVNAME=hwmon2=thinkpad
FCTEMPS=hwmon2/device/pwm1=hwmon2/device/temp1_input
FCFANS=hwmon2/device/pwm1=hwmon2/device/fan1_input
MINTEMP=hwmon2/device/pwm1=30
MAXTEMP=hwmon2/device/pwm1=60
MINSTART=hwmon2/device/pwm1=32
MINSTOP=hwmon2/device/pwm1=32

--------------000809070004000000080304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000809070004000000080304--
