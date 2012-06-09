From: =?UTF-8?B?VG9yYmrDtnJuIMOWc3RlcmRhaGw=?= <torbjorn@ultra-marine.org>
Date: Sat, 09 Jun 2012 18:35:18 +0000
Subject: Re: [lm-sensors] ASUS Sabertooth Z77 / nct6775.ko report
Message-Id: <CAG=BXvSdT36dxHe0PoKY=M91QF-J-SR573ing=hMAS-TgBDGqg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2939261459262428703=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20120523123730.6f2d7e36@desktop>
In-Reply-To: <20120523123730.6f2d7e36@desktop>
To: lm-sensors@vger.kernel.org

--===============2939261459262428703==
Content-Type: multipart/alternative; boundary=e89a8ff25680eb777704c20e6053

--e89a8ff25680eb777704c20e6053
Content-Type: text/plain; charset=UTF-8

I have got a Asus P8Z77-M PRO and have similar experiences.

- The standard lm-sensors package that comes with my distribution,
(i:3.3.1/Ubuntu), does not include support for setting PWM fan speeds.
- By downloading and compiling the nct6775 module from
https://github.com/groeck/nct6775 these things work to statisfaction.
- Temperatures as read from the chipset is low. Compared to temperatures
measured by a thermometer in the case they are lower and does not go up as
quickly when they system load increases. I.e. my idle system have a chipset
temperature of 28 Degrees - they temperature in the case is meassured to
32. The loaded system reports a chipset temperature of 32 but the
thermometer in the case reports 44!
- Case temperature as read from the acpiz module are identical though.
- hysteresis values, i.e. pwm3_auto_point1_temp_hyst, behave strange. It is
depenant on the corresponding temp field and often takes negative values.
- In Thermal Cruise mode it sometimes stops the fan completely which I
consider unnecessary. I was not able to prevent this.
- Otherwise I was successful in setting up proper regulation of my pwm case
fans depending on the case temprature. Some examples follows

# 'Manual mode' (1) setting pwm duty cycle explicityly:
echo "1" > /sys/devices/platform/nct6775.656/pwm3_enable
echo "130" > /sys/devices/platform/nct6775.656/pwm3


# 'Thermal Cruise' (2) mode. The fan is regulated to maintain a target
temperature
echo "2" > /sys/devices/platform/nct6775.656/pwm3_enable
echo "1" > /sys/devices/platform/nct6775.656/pwm3_mode
echo "100" > /sys/devices/platform/nct6775.656/pwm3_start_output
echo "100" > /sys/devices/platform/nct6775.656/pwm3_step_down_time
echo "100" > /sys/devices/platform/nct6775.656/pwm3_step_up_time
echo "90" > /sys/devices/platform/nct6775.656/pwm3_stop_output
echo "6000" > /sys/devices/platform/nct6775.656/pwm3_stop_time
echo "28000" > /sys/devices/platform/nct6775.656/pwm3_target
echo "1" > /sys/devices/platform/nct6775.656/pwm3_temp_sel
echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_duty_base
echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_duty_step
echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_enable
echo "1" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_sel
echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_step
echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_step_base
echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_step_tol


# 'Smart Fan IV' (5) mode. The fan is regulated to maintain a target
temperature.
echo "100" > /sys/devices/platform/nct6775.656/pwm4_auto_point1_pwm
echo "28000" > /sys/devices/platform/nct6775.656/pwm4_auto_point1_temp
echo "120" > /sys/devices/platform/nct6775.656/pwm4_auto_point2_pwm
echo "34000" > /sys/devices/platform/nct6775.656/pwm4_auto_point2_temp
echo "150" > /sys/devices/platform/nct6775.656/pwm4_auto_point3_pwm
echo "38000" > /sys/devices/platform/nct6775.656/pwm4_auto_point3_temp
echo "200" > /sys/devices/platform/nct6775.656/pwm4_auto_point4_pwm
echo "42000" > /sys/devices/platform/nct6775.656/pwm4_auto_point4_temp
echo "255" > /sys/devices/platform/nct6775.656/pwm4_auto_point5_pwm
echo "46000" > /sys/devices/platform/nct6775.656/pwm4_auto_point5_temp
echo "5" > /sys/devices/platform/nct6775.656/pwm4_enable
echo "1" > /sys/devices/platform/nct6775.656/pwm4_mode
echo "100" > /sys/devices/platform/nct6775.656/pwm4_start_output
echo "100" > /sys/devices/platform/nct6775.656/pwm4_step_down_time
echo "100" > /sys/devices/platform/nct6775.656/pwm4_step_up_time
echo "90" > /sys/devices/platform/nct6775.656/pwm4_stop_output
echo "6000" > /sys/devices/platform/nct6775.656/pwm4_stop_time
echo "28000" > /sys/devices/platform/nct6775.656/pwm4_target
echo "1" > /sys/devices/platform/nct6775.656/pwm4_temp_sel


# Output of sensors -u before customizations.
acpitz-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 27.800
  temp1_crit: 104.000
temp2:
  temp2_input: 29.800
  temp2_crit: 104.000

nct6779-isa-0290
Adapter: ISA adapter
in0:
  in0_input: 1.040
  in0_min: 0.000
  in0_max: 1.744
  in0_alarm: 0.000
in1:
  in1_input: 1.008
  in1_min: 0.000
  in1_max: 0.000
  in1_alarm: 1.000
in2:
  in2_input: 3.392
  in2_min: 0.000
  in2_max: 0.000
  in2_alarm: 1.000
in3:
  in3_input: 3.392
  in3_min: 0.000
  in3_max: 0.000
  in3_alarm: 1.000
in4:
  in4_input: 1.024
  in4_min: 0.000
  in4_max: 0.000
  in4_alarm: 1.000
in5:
  in5_input: 2.040
  in5_min: 0.000
  in5_max: 0.000
  in5_alarm: 1.000
in6:
  in6_input: 0.272
  in6_min: 0.000
  in6_max: 0.000
  in6_alarm: 1.000
in7:
  in7_input: 3.392
  in7_min: 0.000
  in7_max: 0.000
  in7_alarm: 1.000
in8:
  in8_input: 3.296
  in8_min: 0.000
  in8_max: 0.000
  in8_alarm: 1.000
in9:
  in9_input: 1.056
  in9_min: 0.000
  in9_max: 0.000
  in9_alarm: 1.000
in10:
  in10_input: 0.216
  in10_min: 0.000
  in10_max: 0.000
  in10_alarm: 1.000
in11:
  in11_input: 0.168
  in11_min: 0.000
  in11_max: 0.000
  in11_alarm: 1.000
in12:
  in12_input: 0.168
  in12_min: 0.000
  in12_max: 0.000
  in12_alarm: 1.000
in13:
  in13_input: 0.152
  in13_min: 0.000
  in13_max: 0.000
  in13_alarm: 1.000
in14:
  in14_input: 0.176
  in14_min: 0.000
  in14_max: 0.000
  in14_alarm: 1.000
fan1:
  fan1_input: 0.000
  fan1_min: 0.000
  fan1_alarm: 0.000
fan2:
  fan2_input: 1021.000
  fan2_min: 0.000
  fan2_alarm: 0.000
fan3:
  fan3_input: 1616.000
  fan3_min: 0.000
  fan3_alarm: 0.000
fan4:
  fan4_input: 1646.000
  fan4_min: 0.000
  fan4_alarm: 0.000
fan5:
  fan5_input: 0.000
  fan5_min: 0.000
  fan5_alarm: 0.000
SYSTIN:
  temp1_input: 26.000
  temp1_max: 0.000
  temp1_max_hyst: 0.000
  temp1_alarm: 1.000
  temp1_type: 4.000
  temp1_offset: 0.000
CPUTIN:
  temp2_input: 38.000
  temp2_max: 80.000
  temp2_max_hyst: 75.000
  temp2_alarm: 0.000
  temp2_type: 4.000
  temp2_offset: 0.000
AUXTIN0:
  temp3_input: 105.000
  temp3_alarm: 0.000
  temp3_type: 4.000
  temp3_offset: 0.000
AUXTIN1:
  temp4_input: 106.000
  temp4_type: 4.000
  temp4_offset: 0.000
AUXTIN2:
  temp5_input: 106.000
  temp5_type: 4.000
  temp5_offset: 0.000
AUXTIN3:
  temp6_input: 17.000
  temp6_type: 3.000
  temp6_offset: 0.000
PCH_CHIP_CPU_MAX_TEMP:
  temp7_input: 0.000
PCH_CHIP_TEMP:
  temp8_input: 0.000
PCH_CPU_TEMP:
  temp9_input: 0.000
PCH_MCH_TEMP:
  temp10_input: 0.000
cpu0_vid:
  cpu0_vid: 0.000
intrusion0:
  intrusion0_alarm: 1.000
intrusion1:
  intrusion1_alarm: 1.000


# output of: grep . /sys/devices/platform/nct6775.656/pwm*
/sys/devices/platform/nct6775.656/pwm1:255
/sys/devices/platform/nct6775.656/pwm1_auto_point1_pwm:255
/sys/devices/platform/nct6775.656/pwm1_auto_point1_temp:0
/sys/devices/platform/nct6775.656/pwm1_auto_point1_temp_hyst:0
/sys/devices/platform/nct6775.656/pwm1_auto_point2_pwm:255
/sys/devices/platform/nct6775.656/pwm1_auto_point2_temp:0
/sys/devices/platform/nct6775.656/pwm1_auto_point2_temp_hyst:0
/sys/devices/platform/nct6775.656/pwm1_auto_point3_pwm:255
/sys/devices/platform/nct6775.656/pwm1_auto_point3_temp:0
/sys/devices/platform/nct6775.656/pwm1_auto_point3_temp_hyst:0
/sys/devices/platform/nct6775.656/pwm1_auto_point4_pwm:255
/sys/devices/platform/nct6775.656/pwm1_auto_point4_temp:0
/sys/devices/platform/nct6775.656/pwm1_auto_point4_temp_hyst:0
/sys/devices/platform/nct6775.656/pwm1_auto_point5_pwm:255
/sys/devices/platform/nct6775.656/pwm1_auto_point5_temp:75000
/sys/devices/platform/nct6775.656/pwm1_auto_point5_temp_hyst:73000
/sys/devices/platform/nct6775.656/pwm1_enable:5
/sys/devices/platform/nct6775.656/pwm1_mode:1
/sys/devices/platform/nct6775.656/pwm1_start_output:1
/sys/devices/platform/nct6775.656/pwm1_step_down_time:100
/sys/devices/platform/nct6775.656/pwm1_step_up_time:100
/sys/devices/platform/nct6775.656/pwm1_stop_output:1
/sys/devices/platform/nct6775.656/pwm1_stop_output_enable:0
/sys/devices/platform/nct6775.656/pwm1_stop_time:6000
/sys/devices/platform/nct6775.656/pwm1_target:0
/sys/devices/platform/nct6775.656/pwm1_temp_sel:0
/sys/devices/platform/nct6775.656/pwm1_weight_duty_base:0
/sys/devices/platform/nct6775.656/pwm1_weight_duty_step:0
/sys/devices/platform/nct6775.656/pwm1_weight_enable:0
/sys/devices/platform/nct6775.656/pwm1_weight_temp_sel:1
/sys/devices/platform/nct6775.656/pwm1_weight_temp_step:0
/sys/devices/platform/nct6775.656/pwm1_weight_temp_step_base:0
/sys/devices/platform/nct6775.656/pwm1_weight_temp_step_tol:0
/sys/devices/platform/nct6775.656/pwm2:86
/sys/devices/platform/nct6775.656/pwm2_auto_point1_pwm:51
/sys/devices/platform/nct6775.656/pwm2_auto_point1_temp:20000
/sys/devices/platform/nct6775.656/pwm2_auto_point1_temp_hyst:20000
/sys/devices/platform/nct6775.656/pwm2_auto_point2_pwm:178
/sys/devices/platform/nct6775.656/pwm2_auto_point2_temp:70000
/sys/devices/platform/nct6775.656/pwm2_auto_point2_temp_hyst:70000
/sys/devices/platform/nct6775.656/pwm2_auto_point3_pwm:255
/sys/devices/platform/nct6775.656/pwm2_auto_point3_temp:75000
/sys/devices/platform/nct6775.656/pwm2_auto_point3_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm2_auto_point4_pwm:255
/sys/devices/platform/nct6775.656/pwm2_auto_point4_temp:75000
/sys/devices/platform/nct6775.656/pwm2_auto_point4_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm2_auto_point5_pwm:255
/sys/devices/platform/nct6775.656/pwm2_auto_point5_temp:75000
/sys/devices/platform/nct6775.656/pwm2_auto_point5_temp_hyst:73000
/sys/devices/platform/nct6775.656/pwm2_enable:5
/sys/devices/platform/nct6775.656/pwm2_mode:1
/sys/devices/platform/nct6775.656/pwm2_start_output:1
/sys/devices/platform/nct6775.656/pwm2_step_down_time:100
/sys/devices/platform/nct6775.656/pwm2_step_up_time:100
/sys/devices/platform/nct6775.656/pwm2_stop_output:1
/sys/devices/platform/nct6775.656/pwm2_stop_output_enable:0
/sys/devices/platform/nct6775.656/pwm2_stop_time:6000
/sys/devices/platform/nct6775.656/pwm2_target:50000
/sys/devices/platform/nct6775.656/pwm2_temp_sel:0
/sys/devices/platform/nct6775.656/pwm2_weight_duty_base:0
/sys/devices/platform/nct6775.656/pwm2_weight_duty_step:0
/sys/devices/platform/nct6775.656/pwm2_weight_enable:0
/sys/devices/platform/nct6775.656/pwm2_weight_temp_sel:1
/sys/devices/platform/nct6775.656/pwm2_weight_temp_step:0
/sys/devices/platform/nct6775.656/pwm2_weight_temp_step_base:0
/sys/devices/platform/nct6775.656/pwm2_weight_temp_step_tol:0
/sys/devices/platform/nct6775.656/pwm3:162
/sys/devices/platform/nct6775.656/pwm3_auto_point1_pwm:153
/sys/devices/platform/nct6775.656/pwm3_auto_point1_temp:30000
/sys/devices/platform/nct6775.656/pwm3_auto_point1_temp_hyst:30000
/sys/devices/platform/nct6775.656/pwm3_auto_point2_pwm:255
/sys/devices/platform/nct6775.656/pwm3_auto_point2_temp:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point2_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point3_pwm:255
/sys/devices/platform/nct6775.656/pwm3_auto_point3_temp:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point3_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point4_pwm:255
/sys/devices/platform/nct6775.656/pwm3_auto_point4_temp:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point4_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point5_pwm:255
/sys/devices/platform/nct6775.656/pwm3_auto_point5_temp:75000
/sys/devices/platform/nct6775.656/pwm3_auto_point5_temp_hyst:73000
/sys/devices/platform/nct6775.656/pwm3_enable:5
/sys/devices/platform/nct6775.656/pwm3_mode:1
/sys/devices/platform/nct6775.656/pwm3_start_output:1
/sys/devices/platform/nct6775.656/pwm3_step_down_time:100
/sys/devices/platform/nct6775.656/pwm3_step_up_time:100
/sys/devices/platform/nct6775.656/pwm3_stop_output:1
/sys/devices/platform/nct6775.656/pwm3_stop_output_enable:0
/sys/devices/platform/nct6775.656/pwm3_stop_time:6000
/sys/devices/platform/nct6775.656/pwm3_target:0
/sys/devices/platform/nct6775.656/pwm3_temp_sel:0
/sys/devices/platform/nct6775.656/pwm3_weight_duty_base:0
/sys/devices/platform/nct6775.656/pwm3_weight_duty_step:0
/sys/devices/platform/nct6775.656/pwm3_weight_enable:0
/sys/devices/platform/nct6775.656/pwm3_weight_temp_sel:1
/sys/devices/platform/nct6775.656/pwm3_weight_temp_step:0
/sys/devices/platform/nct6775.656/pwm3_weight_temp_step_base:0
/sys/devices/platform/nct6775.656/pwm3_weight_temp_step_tol:0
/sys/devices/platform/nct6775.656/pwm4:162
/sys/devices/platform/nct6775.656/pwm4_auto_point1_pwm:153
/sys/devices/platform/nct6775.656/pwm4_auto_point1_temp:30000
/sys/devices/platform/nct6775.656/pwm4_auto_point1_temp_hyst:30000
/sys/devices/platform/nct6775.656/pwm4_auto_point2_pwm:255
/sys/devices/platform/nct6775.656/pwm4_auto_point2_temp:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point2_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point3_pwm:255
/sys/devices/platform/nct6775.656/pwm4_auto_point3_temp:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point3_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point4_pwm:255
/sys/devices/platform/nct6775.656/pwm4_auto_point4_temp:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point4_temp_hyst:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point5_pwm:255
/sys/devices/platform/nct6775.656/pwm4_auto_point5_temp:75000
/sys/devices/platform/nct6775.656/pwm4_auto_point5_temp_hyst:73000
/sys/devices/platform/nct6775.656/pwm4_enable:5
/sys/devices/platform/nct6775.656/pwm4_mode:1
/sys/devices/platform/nct6775.656/pwm4_start_output:1
/sys/devices/platform/nct6775.656/pwm4_step_down_time:100
/sys/devices/platform/nct6775.656/pwm4_step_up_time:100
/sys/devices/platform/nct6775.656/pwm4_stop_output:1
/sys/devices/platform/nct6775.656/pwm4_stop_output_enable:0
/sys/devices/platform/nct6775.656/pwm4_stop_time:6000
/sys/devices/platform/nct6775.656/pwm4_target:0
/sys/devices/platform/nct6775.656/pwm4_temp_sel:0
/sys/devices/platform/nct6775.656/pwm4_weight_duty_base:0
/sys/devices/platform/nct6775.656/pwm4_weight_duty_step:0
/sys/devices/platform/nct6775.656/pwm4_weight_enable:0
/sys/devices/platform/nct6775.656/pwm4_weight_temp_sel:1
/sys/devices/platform/nct6775.656/pwm4_weight_temp_step:0
/sys/devices/platform/nct6775.656/pwm4_weight_temp_step_base:0
/sys/devices/platform/nct6775.656/pwm4_weight_temp_step_tol:0
/sys/devices/platform/nct6775.656/pwm5:255
/sys/devices/platform/nct6775.656/pwm5_auto_point1_pwm:140
/sys/devices/platform/nct6775.656/pwm5_auto_point1_temp:25000
/sys/devices/platform/nct6775.656/pwm5_auto_point1_temp_hyst:25000
/sys/devices/platform/nct6775.656/pwm5_auto_point2_pwm:170
/sys/devices/platform/nct6775.656/pwm5_auto_point2_temp:35000
/sys/devices/platform/nct6775.656/pwm5_auto_point2_temp_hyst:35000
/sys/devices/platform/nct6775.656/pwm5_auto_point3_pwm:200
/sys/devices/platform/nct6775.656/pwm5_auto_point3_temp:45000
/sys/devices/platform/nct6775.656/pwm5_auto_point3_temp_hyst:45000
/sys/devices/platform/nct6775.656/pwm5_auto_point4_pwm:230
/sys/devices/platform/nct6775.656/pwm5_auto_point4_temp:55000
/sys/devices/platform/nct6775.656/pwm5_auto_point4_temp_hyst:55000
/sys/devices/platform/nct6775.656/pwm5_auto_point5_pwm:255
/sys/devices/platform/nct6775.656/pwm5_auto_point5_temp:60000
/sys/devices/platform/nct6775.656/pwm5_auto_point5_temp_hyst:60000
/sys/devices/platform/nct6775.656/pwm5_enable:0
/sys/devices/platform/nct6775.656/pwm5_mode:1
/sys/devices/platform/nct6775.656/pwm5_start_output:1
/sys/devices/platform/nct6775.656/pwm5_step_down_time:1000
/sys/devices/platform/nct6775.656/pwm5_step_up_time:1000
/sys/devices/platform/nct6775.656/pwm5_stop_output:1
/sys/devices/platform/nct6775.656/pwm5_stop_output_enable:0
/sys/devices/platform/nct6775.656/pwm5_stop_time:6000
/sys/devices/platform/nct6775.656/pwm5_target:0
/sys/devices/platform/nct6775.656/pwm5_temp_sel:3
/sys/devices/platform/nct6775.656/pwm5_weight_duty_base:0
/sys/devices/platform/nct6775.656/pwm5_weight_duty_step:0
/sys/devices/platform/nct6775.656/pwm5_weight_enable:0
/sys/devices/platform/nct6775.656/pwm5_weight_temp_sel:1
/sys/devices/platform/nct6775.656/pwm5_weight_temp_step:0
/sys/devices/platform/nct6775.656/pwm5_weight_temp_step_base:0
/sys/devices/platform/nct6775.656/pwm5_weight_temp_step_tol:0

--e89a8ff25680eb777704c20e6053
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have got a Asus P8Z77-M PRO and have similar experiences.<br><br>- The st=
andard lm-sensors package that comes with my distribution, (i:3.3.1/Ubuntu)=
, does not include support for setting PWM fan speeds. <br>
- By downloading and compiling the nct6775 module from <a href=3D"https://g=
ithub.com/groeck/nct6775" target=3D"_blank">https://github.com/groeck/nct67=
75</a> these things work to statisfaction. <br>- Temperatures as read from =
the chipset is low. Compared to temperatures measured by a thermometer in t=
he case they are lower and does not go up as quickly when they system load =
increases. I.e. my idle system have a chipset temperature of 28 Degrees - t=
hey temperature in the case is meassured to 32. The loaded system reports a=
 chipset temperature of 32 but the thermometer in the case reports 44!<br>
- Case temperature as read from the acpiz module are identical though. <br>
- hysteresis values, i.e. pwm3_auto_point1_temp_hyst, behave strange. It is=
 depenant on the corresponding temp field and often takes negative values. =
<br>- In Thermal Cruise mode it sometimes stops the fan completely which I =
consider unnecessary. I was not able to prevent this. <br>
- Otherwise I was successful in setting up proper regulation of my pwm case=
 fans depending on the case temprature. Some examples follows<br><br># &#39=
;Manual mode&#39; (1) setting pwm duty cycle explicityly:<br>echo &quot;1&q=
uot; &gt; /sys/devices/platform/nct6775.656/pwm3_enable<br>
echo &quot;130&quot; &gt; /sys/devices/platform/nct6775.656/pwm3<br><br><br=
># &#39;Thermal Cruise&#39; (2) mode. The fan is regulated to maintain a ta=
rget temperature<br>echo &quot;2&quot; &gt; /sys/devices/platform/nct6775.6=
56/pwm3_enable<br>
echo &quot;1&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_mode<br>echo=
 &quot;100&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_start_output<b=
r>echo &quot;100&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_step_dow=
n_time<br>
echo &quot;100&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_step_up_ti=
me<br>echo &quot;90&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_stop_=
output<br>echo &quot;6000&quot; &gt; /sys/devices/platform/nct6775.656/pwm3=
_stop_time<br>
echo &quot;28000&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_target<b=
r>echo &quot;1&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_temp_sel<b=
r>echo &quot;0&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_weight_dut=
y_base<br>
echo &quot;0&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_weight_duty_=
step<br>echo &quot;0&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_weig=
ht_enable<br>echo &quot;1&quot; &gt; /sys/devices/platform/nct6775.656/pwm3=
_weight_temp_sel<br>
echo &quot;0&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_weight_temp_=
step<br>echo &quot;0&quot; &gt; /sys/devices/platform/nct6775.656/pwm3_weig=
ht_temp_step_base<br>echo &quot;0&quot; &gt; /sys/devices/platform/nct6775.=
656/pwm3_weight_temp_step_tol<br>
<br><br># &#39;Smart Fan IV&#39; (5) mode. The fan is regulated to maintain=
 a target temperature.<br>echo &quot;100&quot; &gt; /sys/devices/platform/n=
ct6775.656/pwm4_auto_point1_pwm<br>echo &quot;28000&quot; &gt; /sys/devices=
/platform/nct6775.656/pwm4_auto_point1_temp<br>
echo &quot;120&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_auto_point=
2_pwm<br>echo &quot;34000&quot; &gt; /sys/devices/platform/nct6775.656/pwm4=
_auto_point2_temp<br>echo &quot;150&quot; &gt; /sys/devices/platform/nct677=
5.656/pwm4_auto_point3_pwm<br>
echo &quot;38000&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_auto_poi=
nt3_temp<br>echo &quot;200&quot; &gt; /sys/devices/platform/nct6775.656/pwm=
4_auto_point4_pwm<br>echo &quot;42000&quot; &gt; /sys/devices/platform/nct6=
775.656/pwm4_auto_point4_temp<br>
echo &quot;255&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_auto_point=
5_pwm<br>echo &quot;46000&quot; &gt; /sys/devices/platform/nct6775.656/pwm4=
_auto_point5_temp<br>echo &quot;5&quot; &gt; /sys/devices/platform/nct6775.=
656/pwm4_enable<br>
echo &quot;1&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_mode<br>echo=
 &quot;100&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_start_output<b=
r>echo &quot;100&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_step_dow=
n_time<br>
echo &quot;100&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_step_up_ti=
me<br>echo &quot;90&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_stop_=
output<br>echo &quot;6000&quot; &gt; /sys/devices/platform/nct6775.656/pwm4=
_stop_time<br>
echo &quot;28000&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_target<b=
r>echo &quot;1&quot; &gt; /sys/devices/platform/nct6775.656/pwm4_temp_sel<b=
r><br><br># Output of sensors -u before customizations. <br>acpitz-virtual-=
0<br>
Adapter: Virtual device<br>temp1:<br>=C2=A0 temp1_input: 27.800<br>=C2=A0 t=
emp1_crit: 104.000<br>temp2:<br>=C2=A0 temp2_input: 29.800<br>=C2=A0 temp2_=
crit: 104.000<br><br>nct6779-isa-0290<br>Adapter: ISA adapter<br>in0:<br>=
=C2=A0 in0_input: 1.040<br>
=C2=A0 in0_min: 0.000<br>=C2=A0 in0_max: 1.744<br>=C2=A0 in0_alarm: 0.000<b=
r>in1:<br>=C2=A0 in1_input: 1.008<br>=C2=A0 in1_min: 0.000<br>=C2=A0 in1_ma=
x: 0.000<br>=C2=A0 in1_alarm: 1.000<br>in2:<br>=C2=A0 in2_input: 3.392<br>=
=C2=A0 in2_min: 0.000<br>=C2=A0 in2_max: 0.000<br>
=C2=A0 in2_alarm: 1.000<br>in3:<br>=C2=A0 in3_input: 3.392<br>=C2=A0 in3_mi=
n: 0.000<br>=C2=A0 in3_max: 0.000<br>=C2=A0 in3_alarm: 1.000<br>in4:<br>=C2=
=A0 in4_input: 1.024<br>=C2=A0 in4_min: 0.000<br>=C2=A0 in4_max: 0.000<br>=
=C2=A0 in4_alarm: 1.000<br>in5:<br>=C2=A0 in5_input: 2.040<br>
=C2=A0 in5_min: 0.000<br>=C2=A0 in5_max: 0.000<br>=C2=A0 in5_alarm: 1.000<b=
r>in6:<br>=C2=A0 in6_input: 0.272<br>=C2=A0 in6_min: 0.000<br>=C2=A0 in6_ma=
x: 0.000<br>=C2=A0 in6_alarm: 1.000<br>in7:<br>=C2=A0 in7_input: 3.392<br>=
=C2=A0 in7_min: 0.000<br>=C2=A0 in7_max: 0.000<br>
=C2=A0 in7_alarm: 1.000<br>in8:<br>=C2=A0 in8_input: 3.296<br>=C2=A0 in8_mi=
n: 0.000<br>=C2=A0 in8_max: 0.000<br>=C2=A0 in8_alarm: 1.000<br>in9:<br>=C2=
=A0 in9_input: 1.056<br>=C2=A0 in9_min: 0.000<br>=C2=A0 in9_max: 0.000<br>=
=C2=A0 in9_alarm: 1.000<br>in10:<br>=C2=A0 in10_input: 0.216<br>
=C2=A0 in10_min: 0.000<br>=C2=A0 in10_max: 0.000<br>=C2=A0 in10_alarm: 1.00=
0<br>in11:<br>=C2=A0 in11_input: 0.168<br>=C2=A0 in11_min: 0.000<br>=C2=A0 =
in11_max: 0.000<br>=C2=A0 in11_alarm: 1.000<br>in12:<br>=C2=A0 in12_input: =
0.168<br>=C2=A0 in12_min: 0.000<br>=C2=A0 in12_max: 0.000<br>
=C2=A0 in12_alarm: 1.000<br>in13:<br>=C2=A0 in13_input: 0.152<br>=C2=A0 in1=
3_min: 0.000<br>=C2=A0 in13_max: 0.000<br>=C2=A0 in13_alarm: 1.000<br>in14:=
<br>=C2=A0 in14_input: 0.176<br>=C2=A0 in14_min: 0.000<br>=C2=A0 in14_max: =
0.000<br>=C2=A0 in14_alarm: 1.000<br>fan1:<br>
=C2=A0 fan1_input: 0.000<br>=C2=A0 fan1_min: 0.000<br>=C2=A0 fan1_alarm: 0.=
000<br>fan2:<br>=C2=A0 fan2_input: 1021.000<br>=C2=A0 fan2_min: 0.000<br>=
=C2=A0 fan2_alarm: 0.000<br>fan3:<br>=C2=A0 fan3_input: 1616.000<br>=C2=A0 =
fan3_min: 0.000<br>=C2=A0 fan3_alarm: 0.000<br>
fan4:<br>=C2=A0 fan4_input: 1646.000<br>=C2=A0 fan4_min: 0.000<br>=C2=A0 fa=
n4_alarm: 0.000<br>fan5:<br>=C2=A0 fan5_input: 0.000<br>=C2=A0 fan5_min: 0.=
000<br>=C2=A0 fan5_alarm: 0.000<br>SYSTIN:<br>=C2=A0 temp1_input: 26.000<br=
>=C2=A0 temp1_max: 0.000<br>=C2=A0 temp1_max_hyst: 0.000<br>
=C2=A0 temp1_alarm: 1.000<br>=C2=A0 temp1_type: 4.000<br>=C2=A0 temp1_offse=
t: 0.000<br>CPUTIN:<br>=C2=A0 temp2_input: 38.000<br>=C2=A0 temp2_max: 80.0=
00<br>=C2=A0 temp2_max_hyst: 75.000<br>=C2=A0 temp2_alarm: 0.000<br>=C2=A0 =
temp2_type: 4.000<br>=C2=A0 temp2_offset: 0.000<br>
AUXTIN0:<br>=C2=A0 temp3_input: 105.000<br>=C2=A0 temp3_alarm: 0.000<br>=C2=
=A0 temp3_type: 4.000<br>=C2=A0 temp3_offset: 0.000<br>AUXTIN1:<br>=C2=A0 t=
emp4_input: 106.000<br>=C2=A0 temp4_type: 4.000<br>=C2=A0 temp4_offset: 0.0=
00<br>AUXTIN2:<br>=C2=A0 temp5_input: 106.000<br>
=C2=A0 temp5_type: 4.000<br>=C2=A0 temp5_offset: 0.000<br>AUXTIN3:<br>=C2=
=A0 temp6_input: 17.000<br>=C2=A0 temp6_type: 3.000<br>=C2=A0 temp6_offset:=
 0.000<br>PCH_CHIP_CPU_MAX_TEMP:<br>=C2=A0 temp7_input: 0.000<br>PCH_CHIP_T=
EMP:<br>=C2=A0 temp8_input: 0.000<br>
PCH_CPU_TEMP:<br>=C2=A0 temp9_input: 0.000<br>PCH_MCH_TEMP:<br>=C2=A0 temp1=
0_input: 0.000<br>cpu0_vid:<br>=C2=A0 cpu0_vid: 0.000<br>intrusion0:<br>=C2=
=A0 intrusion0_alarm: 1.000<br>intrusion1:<br>=C2=A0 intrusion1_alarm: 1.00=
0<br><br><br># output of: grep . /sys/devices/platform/nct6775.656/pwm*<br>
/sys/devices/platform/nct6775.656/pwm1:255<br>/sys/devices/platform/nct6775=
.656/pwm1_auto_point1_pwm:255<br>/sys/devices/platform/nct6775.656/pwm1_aut=
o_point1_temp:0<br>/sys/devices/platform/nct6775.656/pwm1_auto_point1_temp_=
hyst:0<br>
/sys/devices/platform/nct6775.656/pwm1_auto_point2_pwm:255<br>/sys/devices/=
platform/nct6775.656/pwm1_auto_point2_temp:0<br>/sys/devices/platform/nct67=
75.656/pwm1_auto_point2_temp_hyst:0<br>/sys/devices/platform/nct6775.656/pw=
m1_auto_point3_pwm:255<br>
/sys/devices/platform/nct6775.656/pwm1_auto_point3_temp:0<br>/sys/devices/p=
latform/nct6775.656/pwm1_auto_point3_temp_hyst:0<br>/sys/devices/platform/n=
ct6775.656/pwm1_auto_point4_pwm:255<br>/sys/devices/platform/nct6775.656/pw=
m1_auto_point4_temp:0<br>
/sys/devices/platform/nct6775.656/pwm1_auto_point4_temp_hyst:0<br>/sys/devi=
ces/platform/nct6775.656/pwm1_auto_point5_pwm:255<br>/sys/devices/platform/=
nct6775.656/pwm1_auto_point5_temp:75000<br>/sys/devices/platform/nct6775.65=
6/pwm1_auto_point5_temp_hyst:73000<br>
/sys/devices/platform/nct6775.656/pwm1_enable:5<br>/sys/devices/platform/nc=
t6775.656/pwm1_mode:1<br>/sys/devices/platform/nct6775.656/pwm1_start_outpu=
t:1<br>/sys/devices/platform/nct6775.656/pwm1_step_down_time:100<br>/sys/de=
vices/platform/nct6775.656/pwm1_step_up_time:100<br>
/sys/devices/platform/nct6775.656/pwm1_stop_output:1<br>/sys/devices/platfo=
rm/nct6775.656/pwm1_stop_output_enable:0<br>/sys/devices/platform/nct6775.6=
56/pwm1_stop_time:6000<br>/sys/devices/platform/nct6775.656/pwm1_target:0<b=
r>
/sys/devices/platform/nct6775.656/pwm1_temp_sel:0<br>/sys/devices/platform/=
nct6775.656/pwm1_weight_duty_base:0<br>/sys/devices/platform/nct6775.656/pw=
m1_weight_duty_step:0<br>/sys/devices/platform/nct6775.656/pwm1_weight_enab=
le:0<br>
/sys/devices/platform/nct6775.656/pwm1_weight_temp_sel:1<br>/sys/devices/pl=
atform/nct6775.656/pwm1_weight_temp_step:0<br>/sys/devices/platform/nct6775=
.656/pwm1_weight_temp_step_base:0<br>/sys/devices/platform/nct6775.656/pwm1=
_weight_temp_step_tol:0<br>
/sys/devices/platform/nct6775.656/pwm2:86<br>/sys/devices/platform/nct6775.=
656/pwm2_auto_point1_pwm:51<br>/sys/devices/platform/nct6775.656/pwm2_auto_=
point1_temp:20000<br>/sys/devices/platform/nct6775.656/pwm2_auto_point1_tem=
p_hyst:20000<br>
/sys/devices/platform/nct6775.656/pwm2_auto_point2_pwm:178<br>/sys/devices/=
platform/nct6775.656/pwm2_auto_point2_temp:70000<br>/sys/devices/platform/n=
ct6775.656/pwm2_auto_point2_temp_hyst:70000<br>/sys/devices/platform/nct677=
5.656/pwm2_auto_point3_pwm:255<br>
/sys/devices/platform/nct6775.656/pwm2_auto_point3_temp:75000<br>/sys/devic=
es/platform/nct6775.656/pwm2_auto_point3_temp_hyst:75000<br>/sys/devices/pl=
atform/nct6775.656/pwm2_auto_point4_pwm:255<br>/sys/devices/platform/nct677=
5.656/pwm2_auto_point4_temp:75000<br>
/sys/devices/platform/nct6775.656/pwm2_auto_point4_temp_hyst:75000<br>/sys/=
devices/platform/nct6775.656/pwm2_auto_point5_pwm:255<br>/sys/devices/platf=
orm/nct6775.656/pwm2_auto_point5_temp:75000<br>/sys/devices/platform/nct677=
5.656/pwm2_auto_point5_temp_hyst:73000<br>
/sys/devices/platform/nct6775.656/pwm2_enable:5<br>/sys/devices/platform/nc=
t6775.656/pwm2_mode:1<br>/sys/devices/platform/nct6775.656/pwm2_start_outpu=
t:1<br>/sys/devices/platform/nct6775.656/pwm2_step_down_time:100<br>/sys/de=
vices/platform/nct6775.656/pwm2_step_up_time:100<br>
/sys/devices/platform/nct6775.656/pwm2_stop_output:1<br>/sys/devices/platfo=
rm/nct6775.656/pwm2_stop_output_enable:0<br>/sys/devices/platform/nct6775.6=
56/pwm2_stop_time:6000<br>/sys/devices/platform/nct6775.656/pwm2_target:500=
00<br>
/sys/devices/platform/nct6775.656/pwm2_temp_sel:0<br>/sys/devices/platform/=
nct6775.656/pwm2_weight_duty_base:0<br>/sys/devices/platform/nct6775.656/pw=
m2_weight_duty_step:0<br>/sys/devices/platform/nct6775.656/pwm2_weight_enab=
le:0<br>
/sys/devices/platform/nct6775.656/pwm2_weight_temp_sel:1<br>/sys/devices/pl=
atform/nct6775.656/pwm2_weight_temp_step:0<br>/sys/devices/platform/nct6775=
.656/pwm2_weight_temp_step_base:0<br>/sys/devices/platform/nct6775.656/pwm2=
_weight_temp_step_tol:0<br>
/sys/devices/platform/nct6775.656/pwm3:162<br>/sys/devices/platform/nct6775=
.656/pwm3_auto_point1_pwm:153<br>/sys/devices/platform/nct6775.656/pwm3_aut=
o_point1_temp:30000<br>/sys/devices/platform/nct6775.656/pwm3_auto_point1_t=
emp_hyst:30000<br>
/sys/devices/platform/nct6775.656/pwm3_auto_point2_pwm:255<br>/sys/devices/=
platform/nct6775.656/pwm3_auto_point2_temp:75000<br>/sys/devices/platform/n=
ct6775.656/pwm3_auto_point2_temp_hyst:75000<br>/sys/devices/platform/nct677=
5.656/pwm3_auto_point3_pwm:255<br>
/sys/devices/platform/nct6775.656/pwm3_auto_point3_temp:75000<br>/sys/devic=
es/platform/nct6775.656/pwm3_auto_point3_temp_hyst:75000<br>/sys/devices/pl=
atform/nct6775.656/pwm3_auto_point4_pwm:255<br>/sys/devices/platform/nct677=
5.656/pwm3_auto_point4_temp:75000<br>
/sys/devices/platform/nct6775.656/pwm3_auto_point4_temp_hyst:75000<br>/sys/=
devices/platform/nct6775.656/pwm3_auto_point5_pwm:255<br>/sys/devices/platf=
orm/nct6775.656/pwm3_auto_point5_temp:75000<br>/sys/devices/platform/nct677=
5.656/pwm3_auto_point5_temp_hyst:73000<br>
/sys/devices/platform/nct6775.656/pwm3_enable:5<br>/sys/devices/platform/nc=
t6775.656/pwm3_mode:1<br>/sys/devices/platform/nct6775.656/pwm3_start_outpu=
t:1<br>/sys/devices/platform/nct6775.656/pwm3_step_down_time:100<br>/sys/de=
vices/platform/nct6775.656/pwm3_step_up_time:100<br>
/sys/devices/platform/nct6775.656/pwm3_stop_output:1<br>/sys/devices/platfo=
rm/nct6775.656/pwm3_stop_output_enable:0<br>/sys/devices/platform/nct6775.6=
56/pwm3_stop_time:6000<br>/sys/devices/platform/nct6775.656/pwm3_target:0<b=
r>
/sys/devices/platform/nct6775.656/pwm3_temp_sel:0<br>/sys/devices/platform/=
nct6775.656/pwm3_weight_duty_base:0<br>/sys/devices/platform/nct6775.656/pw=
m3_weight_duty_step:0<br>/sys/devices/platform/nct6775.656/pwm3_weight_enab=
le:0<br>
/sys/devices/platform/nct6775.656/pwm3_weight_temp_sel:1<br>/sys/devices/pl=
atform/nct6775.656/pwm3_weight_temp_step:0<br>/sys/devices/platform/nct6775=
.656/pwm3_weight_temp_step_base:0<br>/sys/devices/platform/nct6775.656/pwm3=
_weight_temp_step_tol:0<br>
/sys/devices/platform/nct6775.656/pwm4:162<br>/sys/devices/platform/nct6775=
.656/pwm4_auto_point1_pwm:153<br>/sys/devices/platform/nct6775.656/pwm4_aut=
o_point1_temp:30000<br>/sys/devices/platform/nct6775.656/pwm4_auto_point1_t=
emp_hyst:30000<br>
/sys/devices/platform/nct6775.656/pwm4_auto_point2_pwm:255<br>/sys/devices/=
platform/nct6775.656/pwm4_auto_point2_temp:75000<br>/sys/devices/platform/n=
ct6775.656/pwm4_auto_point2_temp_hyst:75000<br>/sys/devices/platform/nct677=
5.656/pwm4_auto_point3_pwm:255<br>
/sys/devices/platform/nct6775.656/pwm4_auto_point3_temp:75000<br>/sys/devic=
es/platform/nct6775.656/pwm4_auto_point3_temp_hyst:75000<br>/sys/devices/pl=
atform/nct6775.656/pwm4_auto_point4_pwm:255<br>/sys/devices/platform/nct677=
5.656/pwm4_auto_point4_temp:75000<br>
/sys/devices/platform/nct6775.656/pwm4_auto_point4_temp_hyst:75000<br>/sys/=
devices/platform/nct6775.656/pwm4_auto_point5_pwm:255<br>/sys/devices/platf=
orm/nct6775.656/pwm4_auto_point5_temp:75000<br>/sys/devices/platform/nct677=
5.656/pwm4_auto_point5_temp_hyst:73000<br>
/sys/devices/platform/nct6775.656/pwm4_enable:5<br>/sys/devices/platform/nc=
t6775.656/pwm4_mode:1<br>/sys/devices/platform/nct6775.656/pwm4_start_outpu=
t:1<br>/sys/devices/platform/nct6775.656/pwm4_step_down_time:100<br>/sys/de=
vices/platform/nct6775.656/pwm4_step_up_time:100<br>
/sys/devices/platform/nct6775.656/pwm4_stop_output:1<br>/sys/devices/platfo=
rm/nct6775.656/pwm4_stop_output_enable:0<br>/sys/devices/platform/nct6775.6=
56/pwm4_stop_time:6000<br>/sys/devices/platform/nct6775.656/pwm4_target:0<b=
r>
/sys/devices/platform/nct6775.656/pwm4_temp_sel:0<br>/sys/devices/platform/=
nct6775.656/pwm4_weight_duty_base:0<br>/sys/devices/platform/nct6775.656/pw=
m4_weight_duty_step:0<br>/sys/devices/platform/nct6775.656/pwm4_weight_enab=
le:0<br>
/sys/devices/platform/nct6775.656/pwm4_weight_temp_sel:1<br>/sys/devices/pl=
atform/nct6775.656/pwm4_weight_temp_step:0<br>/sys/devices/platform/nct6775=
.656/pwm4_weight_temp_step_base:0<br>/sys/devices/platform/nct6775.656/pwm4=
_weight_temp_step_tol:0<br>
/sys/devices/platform/nct6775.656/pwm5:255<br>/sys/devices/platform/nct6775=
.656/pwm5_auto_point1_pwm:140<br>/sys/devices/platform/nct6775.656/pwm5_aut=
o_point1_temp:25000<br>/sys/devices/platform/nct6775.656/pwm5_auto_point1_t=
emp_hyst:25000<br>
/sys/devices/platform/nct6775.656/pwm5_auto_point2_pwm:170<br>/sys/devices/=
platform/nct6775.656/pwm5_auto_point2_temp:35000<br>/sys/devices/platform/n=
ct6775.656/pwm5_auto_point2_temp_hyst:35000<br>/sys/devices/platform/nct677=
5.656/pwm5_auto_point3_pwm:200<br>
/sys/devices/platform/nct6775.656/pwm5_auto_point3_temp:45000<br>/sys/devic=
es/platform/nct6775.656/pwm5_auto_point3_temp_hyst:45000<br>/sys/devices/pl=
atform/nct6775.656/pwm5_auto_point4_pwm:230<br>/sys/devices/platform/nct677=
5.656/pwm5_auto_point4_temp:55000<br>
/sys/devices/platform/nct6775.656/pwm5_auto_point4_temp_hyst:55000<br>/sys/=
devices/platform/nct6775.656/pwm5_auto_point5_pwm:255<br>/sys/devices/platf=
orm/nct6775.656/pwm5_auto_point5_temp:60000<br>/sys/devices/platform/nct677=
5.656/pwm5_auto_point5_temp_hyst:60000<br>
/sys/devices/platform/nct6775.656/pwm5_enable:0<br>/sys/devices/platform/nc=
t6775.656/pwm5_mode:1<br>/sys/devices/platform/nct6775.656/pwm5_start_outpu=
t:1<br>/sys/devices/platform/nct6775.656/pwm5_step_down_time:1000<br>/sys/d=
evices/platform/nct6775.656/pwm5_step_up_time:1000<br>
/sys/devices/platform/nct6775.656/pwm5_stop_output:1<br>/sys/devices/platfo=
rm/nct6775.656/pwm5_stop_output_enable:0<br>/sys/devices/platform/nct6775.6=
56/pwm5_stop_time:6000<br>/sys/devices/platform/nct6775.656/pwm5_target:0<b=
r>
/sys/devices/platform/nct6775.656/pwm5_temp_sel:3<br>/sys/devices/platform/=
nct6775.656/pwm5_weight_duty_base:0<br>/sys/devices/platform/nct6775.656/pw=
m5_weight_duty_step:0<br>/sys/devices/platform/nct6775.656/pwm5_weight_enab=
le:0<br>
/sys/devices/platform/nct6775.656/pwm5_weight_temp_sel:1<br>/sys/devices/pl=
atform/nct6775.656/pwm5_weight_temp_step:0<br>/sys/devices/platform/nct6775=
.656/pwm5_weight_temp_step_base:0<br>/sys/devices/platform/nct6775.656/pwm5=
_weight_temp_step_tol:0<br>


--e89a8ff25680eb777704c20e6053--


--===============2939261459262428703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2939261459262428703==--
