From: hiro_yuki_mori@yahoo.co.jp (Mori Hiroyuki)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Sensor results of P4P800
Message-Id: <20031207163032.1639.qmail@web1208.mail.yahoo.co.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Delvare-san,
Thank you for your quick reply.

>I guess you have been defining a section in
/etc/sensors.conf for
>"w83627thf-*". Could you please send it to us? It'll help
us understand
>the sensors output below, and we also could add it to our
default
>configuration file for the benefit of other users.

Following is my definition related to w83627thf  in
/etc/sensors.conf.

***Start of w83627thf section ***

chip "w83782d-*" "w83627thf-*"

# Same as above for w83781d except that in5 and in6 are
computed differently.
# Rather than an internal inverting op amp, the 82d/83s
use standard positive
# inputs and the negative voltages are level shifted by a
3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

    label in0 "VCore 1"
    label in1 "VCore 2"
#    label in1 "+12V"
    label in2 "+3.3V"
    label in3 "+5V"
#    label in4 "+12V"
#    label in5 "-12V"
#    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"
    label temp1 "M/B Temp"
    label temp2 "CPU Temp"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
#    set in1_min vid*0.95
#    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in1_min 12 * 0.90
    set in1_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
   set sensor1 3435
   set sensor2 1
   set sensor3 3435

# examples for temperature limits
    set temp1_over 40
    set temp1_hyst 37
    set temp2_over 52
    set temp2_hyst 47
#    set temp3_over 52
#    set temp3_hyst 47

***End of w83627thf section ***


>Usually, motherboard manufacturers provide the chip with
VID input(s),
>which the driver uses to automatically compute the VCore
min and max
>values. Since your vid reading is 0, min and max are
naturally computed
>to 0. You can try changing the vrm value through the
configuration file,
>it will change the way VID is read. But I doubt it'll
lead you anywhere
>considering you start from +0.0V.
Now, I tried to set vrm to 9.0 based on doc/vid
information with following command.
Currently I'm using Petimum4 3GHz. In this case, I should
be set vrm=9.0. Is this correct?

# echo 9.0 >/proc/sys/dev/sensors/w83627thf-isa-0290/vrm

After this, I read vid value.

# cat /proc/sys/dev/sensors/w83627thf-isa-0290/vid
0.000

I still get 0.000. Why?

>As for the VCore 1 readings, you might need to divide the
value by 2.
>Never see that before though.
OK. I guessed so.

>> Vcore2: Can I ignore?
>If your CPU is a single power plane one, yes, this value
probably
>doesn't make much sense. Take a look at what your BIOS
setup screen
>displays. If it display a single reading for your CPU, I
would assume
>VCore 2 isn't used.
You mentioned that in1 was +12V. I try to change my
configuration file to your recommendation. After this, I
will report the result to you.

>> in4: I believe in4 shows +12V. Is this a bug?
>Strange indeed. Could you please provide the list and
contents of all
>files in /proc/sys/dev/sensors/w83627thf-isa-0290? This
would help us
>understand wether the problem comes from the driver or
from the library
>or sensors program.
Is 'in4' utilized to -12V? Anyway, I inform you of  the
result of /proc/sys/dev/sensors/w83627thf-isa-0290 as
follows.
Below data shows the results after tried to set vrm=9.0.

*** start of result ***
# ls /proc/sys/dev/sensors/w83627thf-isa-0290/
alarms  fan1  fan3     in0  in2  in4  in8   pwm2  sensor1 
sensor3  temp2  vid
beep    fan2  fan_div  in1  in3  in7  pwm1  pwm3  sensor2 
temp1    temp3  vrm

# cat /proc/sys/dev/sensors/w83627thf-isa-0290/*
0
1 0
351 0
5273 2812
87 0
32 2 128
0.00 0.00 3.04
4.08 4.08 3.20
3.14 3.46 3.36
2.82 3.12 3.04
0.08 1.46 0.00
2.82 3.12 2.98
2.40 3.60 3.22
255 1
255 1
255 1
3435
1
3435
40.0 37.0 24.0
52.0 47.0 22.5
80.0 75.0 208.0
0.000
9.0

*** end of result ***

>> CPU Temp: I tried to set 1,2,3435 in /etc/sensors.conf.
>> Result shows as below.
>> 
>> CPU Temp:  +29.0  (high =   +52, hyst =   +47)   sensor
>> PII/Celeron diode
>> CPU Temp:  +30.0  (high =   +52, hyst =   +47)   sensor
>> 3904 transistor
>> CPU Temp:  +86.0  (high =   +52, hyst =   +47)   sensor
>> thermistor   ALARM
>> 
>> BIOS shows 40'C(approx M/B+9'C) as CPU temp value. What
>> should I do?

>Asus are well known to use arbitrary computation
formulae. You shouldn't
>necessarily trust them, and you should not expect to come
to the same
Really? Its unlucky for me...

>value as the one your BIOS setup screen displays.
According to this
>page:
>  http://mbm.livewiredev.com/comp/asus.html
>the correct sensor type for CPU is diode. If you really
want to match
>the BIOS' claimings, feel free to add a compute line for
temp2.
Currently, I found that temp2 was rising up based on CPU
usage. However it is strange..
Can you guess any formula for calculation?

>> Also I report the status of temp3 with above condition
for
>> reference.
>> temp3:    +127.5  (high =   +80, hyst =   +75)   sensor
>> PII/Celeron diode   ALARM
>> temp3:    +127.5  (high =   +80, hyst =   +75)   sensor
>> 3904 transistor   ALARM
>> temp3:    +208.0  (high =   +80, hyst =   +75)   sensor
>> thermistor

>All these mean the temp3 sensor is not used. Add an
ignore temp3 line.
OK.

__________________________________________________
Do You Yahoo!?
Yahoo! BB is Broadband by Yahoo!
http://bb.yahoo.co.jp/
