From: hamletmun@fibertel.com.ar (Hamlet)
Date: Thu, 28 Dec 2006 22:53:56 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45944B04.3060007@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David.

I have Asus P5B Deluxe WiFi AP Edition with Gentoo.

Below is the content of my .gkrellm2/sensor-config

sensor sensor_config_version 1
sensor sensor_float_factor 10000
sensor gkrellm_float_factor 1000
sensor "MB" "w83627dhg-9191-0290/temp1" 10000 0 1 0
sensor "CPU" "w83627dhg-9191-0290/temp2" 10000 0 1 0
sensor "AUX" "w83627dhg-9191-0290/temp3" 10000 0 0 0
sensor "FAN1" "w83627dhg-9191-0290/fan1" 10000 0 1 0
sensor "CPU" "w83627dhg-9191-0290/fan2" 10000 0 1 0
sensor "NONE" "w83627dhg-9191-0290/fan3" 10000 0 1 0
sensor "FAN3" "w83627dhg-9191-0290/fan4" 10000 0 1 0
sensor "FAN2" "w83627dhg-9191-0290/fan5" 10000 0 1 0
sensor "Vcor1" "w83627dhg-9191-0290/in0" 10000 0 0 0
sensor "Vcor2" "w83627dhg-9191-0290/in1" 10000 0 0 0
sensor "+3.3V" "w83627dhg-9191-0290/in2" 09900 0 0 0
sensor "+5V" "w83627dhg-9191-0290/in3" 15640 0 0 0
sensor "+12V" "w83627dhg-9191-0290/in4" 71000 0 0 0
sensor "-12V" "w83627dhg-9191-0290/in5" -74500 0 0 0
sensor "-5V" "w83627dhg-9191-0290/in6" -30950 0 0 0
sensor "V5SB" "w83627dhg-9191-0290/in7" 10000 0 0 0
sensor "VBat" "w83627dhg-9191-0290/in8" 10000 0 0 0
sensor units_fahrenheit 0
sensor volt_display_mode 0

Left side of these pictures shows Asus Probe II.
I don't have Windows, so just googled for these.
http://www.bugtrack.almico.com/file_download.php?file_id7&type=bug
http://www.bugtrack.almico.com/file_download.php?file_id 0&type=bug

# TEMPERATURES

MB 46.0C
CPU 59.0C

As you said I had to disable AUX TEMP.
It shows high temperature and it doesn't make any sense.
And based on the above picture, I renamed SYS to MB

# FANS

The motherboard has 6 fans (one for CPU and 5 for CHASSIS)
fan2 detected CPU_FAN
fan1 detected CHA_FAN1
fan5 detected CHA_FAN2
fan4 detected CHA_FAN3
CHA_FAN4 or CHA_FAN5 seem not to have sensors
Asus Probe II only shows three CHASSIS fans
No idea what POWER means, but seems to be fan3
Maybe it's because I am using ATX not BTX power supply unit

# VOLTAGES

I changed some numbers of 4th column, based on the above pictures.
Now I get these values:
Vcor1 1.22
Vcor2 1.84 Sometimes it changes to 1.83
+3.3 3.26
+5V 5.15 as Asus Probe II shows, sometimes it changes to 5.12
+12V 12.0
-12V -12.0
-5V -5.15 sometimes changes to -5.12
V5SB 3.30
VBat 2.82

Asus Probe II shows only one Vcore and the value is 1.26.
Do I have to choose Vcor2 and adjust the value?
Above picture doesn't mention -12V, -5V, V5SB, VBat.
No clue what V5SB and VBat are, but maybe P5B users could ignore those.

