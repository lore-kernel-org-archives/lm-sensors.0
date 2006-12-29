From: hamletmun@fibertel.com.ar (Hamlet)
Date: Fri, 29 Dec 2006 14:37:36 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45952830.8040505@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David.
How can I contact with Jean and Rudolf?

As your advice, I checked the BIOS.
CPU		56?C
MB		38?C

CPU		1600 RPM
CHASSIS FAN 1	N/A
CHASSIS FAN 2	N/A
CHASSIS FAN 3	N/A
POWER FAN	N/A

VCORE		1.208
3.3V		3.280
5V		5.171
12V		12.091

So I adjusted again my .gkrellm2/sensor-config

sensor sensor_config_version 1
sensor sensor_float_factor 10000
sensor gkrellm_float_factor 1000
sensor "MB" "w83627dhg-9191-0290/temp1" 08500 0 1 0
sensor "CPU" "w83627dhg-9191-0290/temp2" 10000 0 1 0
sensor "AUX" "w83627dhg-9191-0290/temp3" 10000 0 0 0
sensor "FAN1" "w83627dhg-9191-0290/fan1" 10000 0 1 0
sensor "CPU" "w83627dhg-9191-0290/fan2" 10000 0 1 0
sensor "PWR" "w83627dhg-9191-0290/fan3" 10000 0 1 0
sensor "FAN3" "w83627dhg-9191-0290/fan4" 10000 0 1 0
sensor "FAN2" "w83627dhg-9191-0290/fan5" 10000 0 1 0
sensor "NONE" "w83627dhg-9191-0290/in0" 10000 0 0 0
sensor "Vcore" "w83627dhg-9191-0290/in1" 06600 0 1 0
sensor "+3.3V" "w83627dhg-9191-0290/in2" 09960 0 1 0
sensor "+5V" "w83627dhg-9191-0290/in3" 15680 0 1 0
sensor "+12V" "w83627dhg-9191-0290/in4" 71500 0 1 0
sensor "-12V" "w83627dhg-9191-0290/in5" -74500 0 0 0
sensor "-5V" "w83627dhg-9191-0290/in6" -30950 0 0 0
sensor "V5SB" "w83627dhg-9191-0290/in7" 10000 0 0 0
sensor "VBat" "w83627dhg-9191-0290/in8" 10000 0 0 0
sensor units_fahrenheit 0
sensor volt_display_mode 0

ASUS P5B Deluxe WiFi AP Edition seems to use:

temp1, temp2
fan1, fan2, fan3, fan4, fan5
in1 (or in0 for Vcore, how can I tell?), in2, in3, in4

At least, these values are shown in Asus Probe II and BIOS.

The attachment is the screenshot of gkrellm2.
It shows only those values enabled and adjusted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gkrellm.jpg
Type: image/jpeg
Size: 6150 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061229/244790fb/attachment.jpg 
