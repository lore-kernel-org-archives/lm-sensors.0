From: Chuan-kai Lin <cklin@cs.pdx.edu>
Date: Mon, 15 Dec 2008 18:03:00 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <20081215180300.GA6612@rho>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 15, 2008 at 04:32:09PM +0100, Hans de Goede wrote:
> I got your email address from Jean Delvare. I'm the f71882fg maintainer 
> and I've been working on adding f8000 support to the f71882fg driver. 
> That work is now finished.

Hi Hans,

Thank you for your great work!  The module builds and loads fine in
2.6.27.8 on my Dell Studio Slim 540s desktop computer, and sensors shows
fan speed, voltage, and temperature measurements.  Very cool!!  I have
attached two files showing the driver in action:

idle.txt - sysfs contents on an idle system right after bootup
loaded.txt - sysfs contents + sensors output on a loaded system

Here are some issues I found:

 1. There are only two fans in my system.  The driver reports 0 RPM for
    the third fan (which sounds right), and some absurdly high RPM for
    the fourth fan (which sounds wrong).

 2. When the driver loads into the kernel, it reports that there are
    three fans, and they are all in duty-cycle mode.  However, only the
    CPU fan (fan2) uses a 4-pin connector; the case fan (fan1) uses a
    3-pin connector.  I seem to recall that a fan on a 3-pin connector
    can be controlled through only DC voltage?

 3. The full-speed number seems to record the maximum measured fan speed
    instead of the maximum possible fan speed.

 4. I cannot change fan speed by altering tempX_auto_pointY_pwm values.
    However, both the CPU fan and the case fan do speed up when the
    system gets warm.

I am happy to provide more information to help you diagnose the
problems.

-- 
Chuan-kai Lin
http://web.cecs.pdx.edu/~cklin/

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="idle.txt"

fan1_alarm: 0
fan1_full_speed: 1597
fan1_input: 1583
fan2_alarm: 0
fan2_full_speed: 1940
fan2_input: 1702
fan3_alarm: 1
fan3_full_speed: 1466
fan3_input: 0
fan4_input: 34464
in0_input: 1680
in1_input: 1680
in2_input: 1624
pwm1: 102
pwm1_auto_channels_temp: 2
pwm1_enable: 2
pwm1_interpolate: 1
pwm2: 90
pwm2_auto_channels_temp: 2
pwm2_enable: 2
pwm2_interpolate: 1
pwm3: 166
pwm3_auto_channels_temp: 1
pwm3_interpolate: 0
temp1_alarm: 0
temp1_auto_point1_pwm: 255
temp1_auto_point1_temp: 60000
temp1_auto_point1_temp_hyst: 56000
temp1_auto_point2_pwm: 217
temp1_auto_point2_temp: 50000
temp1_auto_point2_temp_hyst: 46000
temp1_auto_point3_pwm: 166
temp1_auto_point3_temp: 40000
temp1_auto_point3_temp_hyst: 36000
temp1_auto_point4_pwm: 128
temp1_auto_point4_temp: 30000
temp1_auto_point4_temp_hyst: 26000
temp1_auto_point5_pwm: 102
temp1_input: 39000
temp1_max: 70000
temp1_max_hyst: 60000
temp2_alarm: 0
temp2_auto_point1_pwm: 255
temp2_auto_point1_temp: 72000
temp2_auto_point1_temp_hyst: 62000
temp2_auto_point2_pwm: 255
temp2_auto_point2_temp: 72000
temp2_auto_point2_temp_hyst: 62000
temp2_auto_point3_pwm: 255
temp2_auto_point3_temp: 72000
temp2_auto_point3_temp_hyst: 62000
temp2_auto_point4_pwm: 167
temp2_auto_point4_temp: 28000
temp2_auto_point4_temp_hyst: 18000
temp2_auto_point5_pwm: 102
temp2_input: 10000
temp2_max: 100000
temp2_max_hyst: 85000
temp2_type: 6
temp3_alarm: 0
temp3_auto_point1_pwm: 255
temp3_auto_point1_temp: 72000
temp3_auto_point1_temp_hyst: 62000
temp3_auto_point2_pwm: 255
temp3_auto_point2_temp: 72000
temp3_auto_point2_temp_hyst: 62000
temp3_auto_point3_pwm: 255
temp3_auto_point3_temp: 72000
temp3_auto_point3_temp_hyst: 62000
temp3_auto_point4_pwm: 160
temp3_auto_point4_temp: 28000
temp3_auto_point4_temp_hyst: 18000
temp3_auto_point5_pwm: 90
temp3_input: 52000
temp3_max: 100000
temp3_max_hyst: 85000

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loaded.txt"

fan1_alarm: 0
fan1_full_speed: 1758
fan1_input: 1726
fan2_alarm: 0
fan2_full_speed: 2086
fan2_input: 2024
fan3_alarm: 1
fan3_full_speed: 1466
fan3_input: 0
fan4_input: 34464
in0_input: 1672
in1_input: 1680
in2_input: 1624
pwm1: 117
pwm1_auto_channels_temp: 2
pwm1_enable: 2
pwm1_interpolate: 1
pwm2: 105
pwm2_auto_channels_temp: 2
pwm2_enable: 2
pwm2_interpolate: 1
pwm3: 166
pwm3_auto_channels_temp: 1
pwm3_interpolate: 0
temp1_alarm: 0
temp1_auto_point1_pwm: 255
temp1_auto_point1_temp: 60000
temp1_auto_point1_temp_hyst: 56000
temp1_auto_point2_pwm: 217
temp1_auto_point2_temp: 50000
temp1_auto_point2_temp_hyst: 46000
temp1_auto_point3_pwm: 166
temp1_auto_point3_temp: 40000
temp1_auto_point3_temp_hyst: 36000
temp1_auto_point4_pwm: 128
temp1_auto_point4_temp: 30000
temp1_auto_point4_temp_hyst: 26000
temp1_auto_point5_pwm: 102
temp1_input: 44000
temp1_max: 70000
temp1_max_hyst: 60000
temp2_alarm: 0
temp2_auto_point1_pwm: 255
temp2_auto_point1_temp: 72000
temp2_auto_point1_temp_hyst: 62000
temp2_auto_point2_pwm: 255
temp2_auto_point2_temp: 72000
temp2_auto_point2_temp_hyst: 62000
temp2_auto_point3_pwm: 255
temp2_auto_point3_temp: 72000
temp2_auto_point3_temp_hyst: 62000
temp2_auto_point4_pwm: 167
temp2_auto_point4_temp: 28000
temp2_auto_point4_temp_hyst: 18000
temp2_auto_point5_pwm: 102
temp2_input: 39000
temp2_max: 100000
temp2_max_hyst: 85000
temp2_type: 6
temp3_alarm: 0
temp3_auto_point1_pwm: 255
temp3_auto_point1_temp: 72000
temp3_auto_point1_temp_hyst: 62000
temp3_auto_point2_pwm: 255
temp3_auto_point2_temp: 72000
temp3_auto_point2_temp_hyst: 62000
temp3_auto_point3_pwm: 255
temp3_auto_point3_temp: 72000
temp3_auto_point3_temp_hyst: 62000
temp3_auto_point4_pwm: 160
temp3_auto_point4_temp: 28000
temp3_auto_point4_temp_hyst: 18000
temp3_auto_point5_pwm: 90
temp3_input: 54000
temp3_max: 100000
temp3_max_hyst: 85000




f8000-isa-0a00
Adapter: ISA adapter
in0:         +1.67 V
in1:         +1.68 V
in2:         +1.62 V
fan1:       1730 RPM
fan2:       2018 RPM
fan3:          0 RPM  ALARM
fan4:       34464 RPM
temp1:       +44.0??C  (high = +70.0??C, hyst = +60.0??C)  
temp2:       +39.0??C  (high = +100.0??C, hyst = +85.0??C)  sensor = Intel PECI
temp3:       +54.0??C  (high = +100.0??C, hyst = +85.0??C)  

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +58.0??C  (high = +74.0??C, crit = +100.0??C)  

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +49.0??C  (high = +74.0??C, crit = +100.0??C)  

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +55.0??C  (high = +74.0??C, crit = +100.0??C)  

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +53.0??C  (high = +74.0??C, crit = +100.0??C)  


--wac7ysb48OaltWcw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--wac7ysb48OaltWcw--
