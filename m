From: Gareth Duncan <gareth@garethduncan.com>
Date: Mon, 16 Mar 2009 12:49:41 +0000
Subject: [lm-sensors] Problem with reported fan RPM on Asus A7v8x
Message-Id: <9f583a030903160549u2b08c66bp4fbb600c0df90de9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

I've almost got a completely working lm-sensors 3.0.0 on my Asus
A7v8x. Everything is working apart from the Chassis Fan readout. For
some reason as the fans speed decreases, sensors reports the RPM as
increasing. The CPU and Power Fan readouts work correctly (as the fan
speed decreases the reported RPM decreases). I'm using the Ubuntu
2.6.24-16-server kernel. Can anyone suggest a way of fixing the
readout or help me figure out what is wrong?

Here is the output normally (with the Chassis Fan at full speed), the
RPM matches what the BIOS reports:

# sensors
asb100-i2c-5-2d
Adapter: SMBus Via Pro adapter at e800
VCore 1:         +1.82 V  (min =  +1.39 V, max =  +2.08 V)
+3.3V:           +3.25 V  (min =  +2.96 V, max =  +3.63 V)
+5V:             +4.92 V  (min =  +4.49 V, max =  +5.51 V)
+12V:           +12.16 V  (min =  +9.55 V, max = +14.41 V)
-12V (reserved):-12.70 V  (min =  -0.00 V, max =  -0.00 V)
-5V (reserved):  -5.33 V  (min =  -0.00 V, max =  -0.00 V)
CPU Fan:        2596 RPM  (min = 1318 RPM, div = 8)
Power Fan:      3068 RPM  (min = 4963 RPM, div = 4)
Chassis Fan:    2109 RPM  (min = 337500 RPM, div = 4)
M/B Temp:        +26.0°C  (high = +80.0°C, hyst = +75.0°C)
Power Temp:      +12.5°C  (high = +80.0°C, hyst = +75.0°C)
CPU Temp (AMD):  +41.0°C  (high = +80.0°C, hyst = +75.0°C)
cpu0_vid:       +1.800 V

As I decrease the fan speed, the Chassis Fan RPM increase:

# echo 200 > /sys/class/hwmon/hwmon0/device/pwm1

# sensors
asb100-i2c-5-2d
Adapter: SMBus Via Pro adapter at e800
VCore 1:         +1.84 V  (min =  +1.39 V, max =  +2.08 V)
+3.3V:           +3.25 V  (min =  +2.96 V, max =  +3.63 V)
+5V:             +4.89 V  (min =  +4.49 V, max =  +5.51 V)
+12V:           +12.16 V  (min =  +9.55 V, max = +14.41 V)
-12V (reserved):-12.70 V  (min =  -0.00 V, max =  -0.00 V)
-5V (reserved):  -5.33 V  (min =  -0.00 V, max =  -0.00 V)
CPU Fan:        2596 RPM  (min = 1318 RPM, div = 8)
Power Fan:      3096 RPM  (min = 4963 RPM, div = 4)
Chassis Fan:    8035 RPM  (min = 337500 RPM, div = 4)
M/B Temp:        +26.0°C  (high = +80.0°C, hyst = +75.0°C)
Power Temp:      +12.5°C  (high = +80.0°C, hyst = +75.0°C)
CPU Temp (AMD):  +40.0°C  (high = +80.0°C, hyst = +75.0°C)
cpu0_vid:       +1.800 V

# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1

# sensors
asb100-i2c-5-2d
Adapter: SMBus Via Pro adapter at e800
VCore 1:         +1.82 V  (min =  +1.39 V, max =  +2.08 V)
+3.3V:           +3.25 V  (min =  +2.96 V, max =  +3.63 V)
+5V:             +4.89 V  (min =  +4.49 V, max =  +5.51 V)
+12V:           +12.16 V  (min =  +9.55 V, max = +14.41 V)
-12V (reserved):-12.70 V  (min =  -0.00 V, max =  -0.00 V)
-5V (reserved):  -5.33 V  (min =  -0.00 V, max =  -0.00 V)
CPU Fan:        2678 RPM  (min = 1318 RPM, div = 8)
Power Fan:      3125 RPM  (min = 4963 RPM, div = 4)
Chassis Fan:    337500 RPM  (min = 337500 RPM, div = 4)
M/B Temp:        +26.0°C  (high = +80.0°C, hyst = +75.0°C)
Power Temp:      +12.5°C  (high = +80.0°C, hyst = +75.0°C)
CPU Temp (AMD):  +41.0°C  (high = +80.0°C, hyst = +75.0°C)
cpu0_vid:       +1.800 V

Here is my sensor3.conf -

    chip "asb100-*"

    label in0 "VCore 1"
    #set in0_min cpu0_vid * 0.95
    #set in0_max cpu0_vid * 1.05

    label in1 "VCore 2"
    ignore in1
    #set in1_min cpu0_vid * 0.95
    #set in1_max cpu0_vid * 1.05

    label in2 "+3.3V"
    #set in2_min 3.3 * 0.95
    #set in2_max 3.3 * 1.05

    label in3 "+5V"
    compute in3 1.68 * @ ,  @ / 1.68
    #set in3_min 5.0 * 0.95
    #set in3_max 5.0 * 1.05

    label in4 "+12V"
    compute in4 3.8 * @ , @ / 3.8
    #set in4_min 12  * 0.90
    #set in4_max 12  * 1.10

    label in5 "-12V (reserved)"
    #ignore in5
    compute in5 -@ * 3.97 ,  -@ / 3.97
    #set in5_max -12 * 0.90
    #set in5_min -12 * 1.10

    label in6 "-5V (reserved)"
    #ignore in6
    compute in6 -@ * 1.666 , -@ / 1.666
    #set in6_max -5  * 0.95
    #set in6_min -5  * 1.05

    label temp1 "M/B Temp"
    #set temp1_max      45
    #set temp1_max_hyst 40

    label temp2 "CPU Temp (Intel)"
    ignore temp2
    #set temp2_max      60
    #set temp2_max_hyst 50

    # PWRTMP connector on P4S333, for external sensor
    label temp3 "Power Temp"
    #ignore temp3
    #set temp3_max      45
    #set temp3_max_hyst 40


    # Used for Athlon diode, ignore for P4S333
    label temp4 "CPU Temp (AMD)"
    #set temp4_max      60
    #set temp4_max_hyst 50

    label fan1 "CPU Fan"
    #set fan1_div 4
    #set fan1_min 2000

    label fan2 "Power Fan"
    set fan2_div 4
    #set fan2_min 1000

    label fan3 "Chassis Fan"
    set fan3_div 4
    #set fan3_min 0

Thanks,
Gareth.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
