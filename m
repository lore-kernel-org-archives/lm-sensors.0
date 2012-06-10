From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jun 2012 01:34:56 +0000
Subject: Re: [lm-sensors] ASUS Sabertooth Z77 / nct6775.ko report
Message-Id: <20120610013456.GA9292@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120523123730.6f2d7e36@desktop>
In-Reply-To: <20120523123730.6f2d7e36@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Jun 09, 2012 at 02:35:18PM -0400, Torbj=F6rn =D6sterdahl wrote:
> I have got a Asus P8Z77-M PRO and have similar experiences.
>=20
> - The standard lm-sensors package that comes with my distribution, (i:3.3=
.1/
> Ubuntu), does not include support for setting PWM fan speeds.
> - By downloading and compiling the nct6775 module from https://github.com/
> groeck/nct6775 these things work to statisfaction.
> - Temperatures as read from the chipset is low. Compared to temperatures
> measured by a thermometer in the case they are lower and does not go up as
> quickly when they system load increases. I.e. my idle system have a chips=
et
> temperature of 28 Degrees - they temperature in the case is meassured to =
32.
> The loaded system reports a chipset temperature of 32 but the thermometer=
 in
> the case reports 44!
> - Case temperature as read from the acpiz module are identical though.
> - hysteresis values, i.e. pwm3_auto_point1_temp_hyst, behave strange. It =
is
> depenant on the corresponding temp field and often takes negative values.
> - In Thermal Cruise mode it sometimes stops the fan completely which I co=
nsider
> unnecessary. I was not able to prevent this.
> - Otherwise I was successful in setting up proper regulation of my pwm ca=
se
> fans depending on the case temprature. Some examples follows
>=20
Hi,

thanks a lot for the great feedback. I'll have a detailed look into it and =
check
if there is anything wrong or can be done better, especially with the hyste=
resis
values and the thermal cruise mode.

Guenter

> # 'Manual mode' (1) setting pwm duty cycle explicityly:
> echo "1" > /sys/devices/platform/nct6775.656/pwm3_enable
> echo "130" > /sys/devices/platform/nct6775.656/pwm3
>=20
>=20
> # 'Thermal Cruise' (2) mode. The fan is regulated to maintain a target
> temperature
> echo "2" > /sys/devices/platform/nct6775.656/pwm3_enable
> echo "1" > /sys/devices/platform/nct6775.656/pwm3_mode
> echo "100" > /sys/devices/platform/nct6775.656/pwm3_start_output
> echo "100" > /sys/devices/platform/nct6775.656/pwm3_step_down_time
> echo "100" > /sys/devices/platform/nct6775.656/pwm3_step_up_time
> echo "90" > /sys/devices/platform/nct6775.656/pwm3_stop_output
> echo "6000" > /sys/devices/platform/nct6775.656/pwm3_stop_time
> echo "28000" > /sys/devices/platform/nct6775.656/pwm3_target
> echo "1" > /sys/devices/platform/nct6775.656/pwm3_temp_sel
> echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_duty_base
> echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_duty_step
> echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_enable
> echo "1" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_sel
> echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_step
> echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_step_base
> echo "0" > /sys/devices/platform/nct6775.656/pwm3_weight_temp_step_tol
>=20
>=20
> # 'Smart Fan IV' (5) mode. The fan is regulated to maintain a target
> temperature.
> echo "100" > /sys/devices/platform/nct6775.656/pwm4_auto_point1_pwm
> echo "28000" > /sys/devices/platform/nct6775.656/pwm4_auto_point1_temp
> echo "120" > /sys/devices/platform/nct6775.656/pwm4_auto_point2_pwm
> echo "34000" > /sys/devices/platform/nct6775.656/pwm4_auto_point2_temp
> echo "150" > /sys/devices/platform/nct6775.656/pwm4_auto_point3_pwm
> echo "38000" > /sys/devices/platform/nct6775.656/pwm4_auto_point3_temp
> echo "200" > /sys/devices/platform/nct6775.656/pwm4_auto_point4_pwm
> echo "42000" > /sys/devices/platform/nct6775.656/pwm4_auto_point4_temp
> echo "255" > /sys/devices/platform/nct6775.656/pwm4_auto_point5_pwm
> echo "46000" > /sys/devices/platform/nct6775.656/pwm4_auto_point5_temp
> echo "5" > /sys/devices/platform/nct6775.656/pwm4_enable
> echo "1" > /sys/devices/platform/nct6775.656/pwm4_mode
> echo "100" > /sys/devices/platform/nct6775.656/pwm4_start_output
> echo "100" > /sys/devices/platform/nct6775.656/pwm4_step_down_time
> echo "100" > /sys/devices/platform/nct6775.656/pwm4_step_up_time
> echo "90" > /sys/devices/platform/nct6775.656/pwm4_stop_output
> echo "6000" > /sys/devices/platform/nct6775.656/pwm4_stop_time
> echo "28000" > /sys/devices/platform/nct6775.656/pwm4_target
> echo "1" > /sys/devices/platform/nct6775.656/pwm4_temp_sel
>=20
>=20
> # Output of sensors -u before customizations.
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:
> =A0 temp1_input: 27.800
> =A0 temp1_crit: 104.000
> temp2:
> =A0 temp2_input: 29.800
> =A0 temp2_crit: 104.000
>=20
> nct6779-isa-0290
> Adapter: ISA adapter
> in0:
> =A0 in0_input: 1.040
> =A0 in0_min: 0.000
> =A0 in0_max: 1.744
> =A0 in0_alarm: 0.000
> in1:
> =A0 in1_input: 1.008
> =A0 in1_min: 0.000
> =A0 in1_max: 0.000
> =A0 in1_alarm: 1.000
> in2:
> =A0 in2_input: 3.392
> =A0 in2_min: 0.000
> =A0 in2_max: 0.000
> =A0 in2_alarm: 1.000
> in3:
> =A0 in3_input: 3.392
> =A0 in3_min: 0.000
> =A0 in3_max: 0.000
> =A0 in3_alarm: 1.000
> in4:
> =A0 in4_input: 1.024
> =A0 in4_min: 0.000
> =A0 in4_max: 0.000
> =A0 in4_alarm: 1.000
> in5:
> =A0 in5_input: 2.040
> =A0 in5_min: 0.000
> =A0 in5_max: 0.000
> =A0 in5_alarm: 1.000
> in6:
> =A0 in6_input: 0.272
> =A0 in6_min: 0.000
> =A0 in6_max: 0.000
> =A0 in6_alarm: 1.000
> in7:
> =A0 in7_input: 3.392
> =A0 in7_min: 0.000
> =A0 in7_max: 0.000
> =A0 in7_alarm: 1.000
> in8:
> =A0 in8_input: 3.296
> =A0 in8_min: 0.000
> =A0 in8_max: 0.000
> =A0 in8_alarm: 1.000
> in9:
> =A0 in9_input: 1.056
> =A0 in9_min: 0.000
> =A0 in9_max: 0.000
> =A0 in9_alarm: 1.000
> in10:
> =A0 in10_input: 0.216
> =A0 in10_min: 0.000
> =A0 in10_max: 0.000
> =A0 in10_alarm: 1.000
> in11:
> =A0 in11_input: 0.168
> =A0 in11_min: 0.000
> =A0 in11_max: 0.000
> =A0 in11_alarm: 1.000
> in12:
> =A0 in12_input: 0.168
> =A0 in12_min: 0.000
> =A0 in12_max: 0.000
> =A0 in12_alarm: 1.000
> in13:
> =A0 in13_input: 0.152
> =A0 in13_min: 0.000
> =A0 in13_max: 0.000
> =A0 in13_alarm: 1.000
> in14:
> =A0 in14_input: 0.176
> =A0 in14_min: 0.000
> =A0 in14_max: 0.000
> =A0 in14_alarm: 1.000
> fan1:
> =A0 fan1_input: 0.000
> =A0 fan1_min: 0.000
> =A0 fan1_alarm: 0.000
> fan2:
> =A0 fan2_input: 1021.000
> =A0 fan2_min: 0.000
> =A0 fan2_alarm: 0.000
> fan3:
> =A0 fan3_input: 1616.000
> =A0 fan3_min: 0.000
> =A0 fan3_alarm: 0.000
> fan4:
> =A0 fan4_input: 1646.000
> =A0 fan4_min: 0.000
> =A0 fan4_alarm: 0.000
> fan5:
> =A0 fan5_input: 0.000
> =A0 fan5_min: 0.000
> =A0 fan5_alarm: 0.000
> SYSTIN:
> =A0 temp1_input: 26.000
> =A0 temp1_max: 0.000
> =A0 temp1_max_hyst: 0.000
> =A0 temp1_alarm: 1.000
> =A0 temp1_type: 4.000
> =A0 temp1_offset: 0.000
> CPUTIN:
> =A0 temp2_input: 38.000
> =A0 temp2_max: 80.000
> =A0 temp2_max_hyst: 75.000
> =A0 temp2_alarm: 0.000
> =A0 temp2_type: 4.000
> =A0 temp2_offset: 0.000
> AUXTIN0:
> =A0 temp3_input: 105.000
> =A0 temp3_alarm: 0.000
> =A0 temp3_type: 4.000
> =A0 temp3_offset: 0.000
> AUXTIN1:
> =A0 temp4_input: 106.000
> =A0 temp4_type: 4.000
> =A0 temp4_offset: 0.000
> AUXTIN2:
> =A0 temp5_input: 106.000
> =A0 temp5_type: 4.000
> =A0 temp5_offset: 0.000
> AUXTIN3:
> =A0 temp6_input: 17.000
> =A0 temp6_type: 3.000
> =A0 temp6_offset: 0.000
> PCH_CHIP_CPU_MAX_TEMP:
> =A0 temp7_input: 0.000
> PCH_CHIP_TEMP:
> =A0 temp8_input: 0.000
> PCH_CPU_TEMP:
> =A0 temp9_input: 0.000
> PCH_MCH_TEMP:
> =A0 temp10_input: 0.000
> cpu0_vid:
> =A0 cpu0_vid: 0.000
> intrusion0:
> =A0 intrusion0_alarm: 1.000
> intrusion1:
> =A0 intrusion1_alarm: 1.000
>=20
>=20
> # output of: grep . /sys/devices/platform/nct6775.656/pwm*
> /sys/devices/platform/nct6775.656/pwm1:255
> /sys/devices/platform/nct6775.656/pwm1_auto_point1_pwm:255
> /sys/devices/platform/nct6775.656/pwm1_auto_point1_temp:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point1_temp_hyst:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point2_pwm:255
> /sys/devices/platform/nct6775.656/pwm1_auto_point2_temp:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point2_temp_hyst:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point3_pwm:255
> /sys/devices/platform/nct6775.656/pwm1_auto_point3_temp:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point3_temp_hyst:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point4_pwm:255
> /sys/devices/platform/nct6775.656/pwm1_auto_point4_temp:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point4_temp_hyst:0
> /sys/devices/platform/nct6775.656/pwm1_auto_point5_pwm:255
> /sys/devices/platform/nct6775.656/pwm1_auto_point5_temp:75000
> /sys/devices/platform/nct6775.656/pwm1_auto_point5_temp_hyst:73000
> /sys/devices/platform/nct6775.656/pwm1_enable:5
> /sys/devices/platform/nct6775.656/pwm1_mode:1
> /sys/devices/platform/nct6775.656/pwm1_start_output:1
> /sys/devices/platform/nct6775.656/pwm1_step_down_time:100
> /sys/devices/platform/nct6775.656/pwm1_step_up_time:100
> /sys/devices/platform/nct6775.656/pwm1_stop_output:1
> /sys/devices/platform/nct6775.656/pwm1_stop_output_enable:0
> /sys/devices/platform/nct6775.656/pwm1_stop_time:6000
> /sys/devices/platform/nct6775.656/pwm1_target:0
> /sys/devices/platform/nct6775.656/pwm1_temp_sel:0
> /sys/devices/platform/nct6775.656/pwm1_weight_duty_base:0
> /sys/devices/platform/nct6775.656/pwm1_weight_duty_step:0
> /sys/devices/platform/nct6775.656/pwm1_weight_enable:0
> /sys/devices/platform/nct6775.656/pwm1_weight_temp_sel:1
> /sys/devices/platform/nct6775.656/pwm1_weight_temp_step:0
> /sys/devices/platform/nct6775.656/pwm1_weight_temp_step_base:0
> /sys/devices/platform/nct6775.656/pwm1_weight_temp_step_tol:0
> /sys/devices/platform/nct6775.656/pwm2:86
> /sys/devices/platform/nct6775.656/pwm2_auto_point1_pwm:51
> /sys/devices/platform/nct6775.656/pwm2_auto_point1_temp:20000
> /sys/devices/platform/nct6775.656/pwm2_auto_point1_temp_hyst:20000
> /sys/devices/platform/nct6775.656/pwm2_auto_point2_pwm:178
> /sys/devices/platform/nct6775.656/pwm2_auto_point2_temp:70000
> /sys/devices/platform/nct6775.656/pwm2_auto_point2_temp_hyst:70000
> /sys/devices/platform/nct6775.656/pwm2_auto_point3_pwm:255
> /sys/devices/platform/nct6775.656/pwm2_auto_point3_temp:75000
> /sys/devices/platform/nct6775.656/pwm2_auto_point3_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm2_auto_point4_pwm:255
> /sys/devices/platform/nct6775.656/pwm2_auto_point4_temp:75000
> /sys/devices/platform/nct6775.656/pwm2_auto_point4_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm2_auto_point5_pwm:255
> /sys/devices/platform/nct6775.656/pwm2_auto_point5_temp:75000
> /sys/devices/platform/nct6775.656/pwm2_auto_point5_temp_hyst:73000
> /sys/devices/platform/nct6775.656/pwm2_enable:5
> /sys/devices/platform/nct6775.656/pwm2_mode:1
> /sys/devices/platform/nct6775.656/pwm2_start_output:1
> /sys/devices/platform/nct6775.656/pwm2_step_down_time:100
> /sys/devices/platform/nct6775.656/pwm2_step_up_time:100
> /sys/devices/platform/nct6775.656/pwm2_stop_output:1
> /sys/devices/platform/nct6775.656/pwm2_stop_output_enable:0
> /sys/devices/platform/nct6775.656/pwm2_stop_time:6000
> /sys/devices/platform/nct6775.656/pwm2_target:50000
> /sys/devices/platform/nct6775.656/pwm2_temp_sel:0
> /sys/devices/platform/nct6775.656/pwm2_weight_duty_base:0
> /sys/devices/platform/nct6775.656/pwm2_weight_duty_step:0
> /sys/devices/platform/nct6775.656/pwm2_weight_enable:0
> /sys/devices/platform/nct6775.656/pwm2_weight_temp_sel:1
> /sys/devices/platform/nct6775.656/pwm2_weight_temp_step:0
> /sys/devices/platform/nct6775.656/pwm2_weight_temp_step_base:0
> /sys/devices/platform/nct6775.656/pwm2_weight_temp_step_tol:0
> /sys/devices/platform/nct6775.656/pwm3:162
> /sys/devices/platform/nct6775.656/pwm3_auto_point1_pwm:153
> /sys/devices/platform/nct6775.656/pwm3_auto_point1_temp:30000
> /sys/devices/platform/nct6775.656/pwm3_auto_point1_temp_hyst:30000
> /sys/devices/platform/nct6775.656/pwm3_auto_point2_pwm:255
> /sys/devices/platform/nct6775.656/pwm3_auto_point2_temp:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point2_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point3_pwm:255
> /sys/devices/platform/nct6775.656/pwm3_auto_point3_temp:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point3_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point4_pwm:255
> /sys/devices/platform/nct6775.656/pwm3_auto_point4_temp:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point4_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point5_pwm:255
> /sys/devices/platform/nct6775.656/pwm3_auto_point5_temp:75000
> /sys/devices/platform/nct6775.656/pwm3_auto_point5_temp_hyst:73000
> /sys/devices/platform/nct6775.656/pwm3_enable:5
> /sys/devices/platform/nct6775.656/pwm3_mode:1
> /sys/devices/platform/nct6775.656/pwm3_start_output:1
> /sys/devices/platform/nct6775.656/pwm3_step_down_time:100
> /sys/devices/platform/nct6775.656/pwm3_step_up_time:100
> /sys/devices/platform/nct6775.656/pwm3_stop_output:1
> /sys/devices/platform/nct6775.656/pwm3_stop_output_enable:0
> /sys/devices/platform/nct6775.656/pwm3_stop_time:6000
> /sys/devices/platform/nct6775.656/pwm3_target:0
> /sys/devices/platform/nct6775.656/pwm3_temp_sel:0
> /sys/devices/platform/nct6775.656/pwm3_weight_duty_base:0
> /sys/devices/platform/nct6775.656/pwm3_weight_duty_step:0
> /sys/devices/platform/nct6775.656/pwm3_weight_enable:0
> /sys/devices/platform/nct6775.656/pwm3_weight_temp_sel:1
> /sys/devices/platform/nct6775.656/pwm3_weight_temp_step:0
> /sys/devices/platform/nct6775.656/pwm3_weight_temp_step_base:0
> /sys/devices/platform/nct6775.656/pwm3_weight_temp_step_tol:0
> /sys/devices/platform/nct6775.656/pwm4:162
> /sys/devices/platform/nct6775.656/pwm4_auto_point1_pwm:153
> /sys/devices/platform/nct6775.656/pwm4_auto_point1_temp:30000
> /sys/devices/platform/nct6775.656/pwm4_auto_point1_temp_hyst:30000
> /sys/devices/platform/nct6775.656/pwm4_auto_point2_pwm:255
> /sys/devices/platform/nct6775.656/pwm4_auto_point2_temp:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point2_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point3_pwm:255
> /sys/devices/platform/nct6775.656/pwm4_auto_point3_temp:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point3_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point4_pwm:255
> /sys/devices/platform/nct6775.656/pwm4_auto_point4_temp:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point4_temp_hyst:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point5_pwm:255
> /sys/devices/platform/nct6775.656/pwm4_auto_point5_temp:75000
> /sys/devices/platform/nct6775.656/pwm4_auto_point5_temp_hyst:73000
> /sys/devices/platform/nct6775.656/pwm4_enable:5
> /sys/devices/platform/nct6775.656/pwm4_mode:1
> /sys/devices/platform/nct6775.656/pwm4_start_output:1
> /sys/devices/platform/nct6775.656/pwm4_step_down_time:100
> /sys/devices/platform/nct6775.656/pwm4_step_up_time:100
> /sys/devices/platform/nct6775.656/pwm4_stop_output:1
> /sys/devices/platform/nct6775.656/pwm4_stop_output_enable:0
> /sys/devices/platform/nct6775.656/pwm4_stop_time:6000
> /sys/devices/platform/nct6775.656/pwm4_target:0
> /sys/devices/platform/nct6775.656/pwm4_temp_sel:0
> /sys/devices/platform/nct6775.656/pwm4_weight_duty_base:0
> /sys/devices/platform/nct6775.656/pwm4_weight_duty_step:0
> /sys/devices/platform/nct6775.656/pwm4_weight_enable:0
> /sys/devices/platform/nct6775.656/pwm4_weight_temp_sel:1
> /sys/devices/platform/nct6775.656/pwm4_weight_temp_step:0
> /sys/devices/platform/nct6775.656/pwm4_weight_temp_step_base:0
> /sys/devices/platform/nct6775.656/pwm4_weight_temp_step_tol:0
> /sys/devices/platform/nct6775.656/pwm5:255
> /sys/devices/platform/nct6775.656/pwm5_auto_point1_pwm:140
> /sys/devices/platform/nct6775.656/pwm5_auto_point1_temp:25000
> /sys/devices/platform/nct6775.656/pwm5_auto_point1_temp_hyst:25000
> /sys/devices/platform/nct6775.656/pwm5_auto_point2_pwm:170
> /sys/devices/platform/nct6775.656/pwm5_auto_point2_temp:35000
> /sys/devices/platform/nct6775.656/pwm5_auto_point2_temp_hyst:35000
> /sys/devices/platform/nct6775.656/pwm5_auto_point3_pwm:200
> /sys/devices/platform/nct6775.656/pwm5_auto_point3_temp:45000
> /sys/devices/platform/nct6775.656/pwm5_auto_point3_temp_hyst:45000
> /sys/devices/platform/nct6775.656/pwm5_auto_point4_pwm:230
> /sys/devices/platform/nct6775.656/pwm5_auto_point4_temp:55000
> /sys/devices/platform/nct6775.656/pwm5_auto_point4_temp_hyst:55000
> /sys/devices/platform/nct6775.656/pwm5_auto_point5_pwm:255
> /sys/devices/platform/nct6775.656/pwm5_auto_point5_temp:60000
> /sys/devices/platform/nct6775.656/pwm5_auto_point5_temp_hyst:60000
> /sys/devices/platform/nct6775.656/pwm5_enable:0
> /sys/devices/platform/nct6775.656/pwm5_mode:1
> /sys/devices/platform/nct6775.656/pwm5_start_output:1
> /sys/devices/platform/nct6775.656/pwm5_step_down_time:1000
> /sys/devices/platform/nct6775.656/pwm5_step_up_time:1000
> /sys/devices/platform/nct6775.656/pwm5_stop_output:1
> /sys/devices/platform/nct6775.656/pwm5_stop_output_enable:0
> /sys/devices/platform/nct6775.656/pwm5_stop_time:6000
> /sys/devices/platform/nct6775.656/pwm5_target:0
> /sys/devices/platform/nct6775.656/pwm5_temp_sel:3
> /sys/devices/platform/nct6775.656/pwm5_weight_duty_base:0
> /sys/devices/platform/nct6775.656/pwm5_weight_duty_step:0
> /sys/devices/platform/nct6775.656/pwm5_weight_enable:0
> /sys/devices/platform/nct6775.656/pwm5_weight_temp_sel:1
> /sys/devices/platform/nct6775.656/pwm5_weight_temp_step:0
> /sys/devices/platform/nct6775.656/pwm5_weight_temp_step_base:0
> /sys/devices/platform/nct6775.656/pwm5_weight_temp_step_tol:0

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
