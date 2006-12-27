From: hamletmun@fibertel.com.ar (Hamlet)
Date: Wed, 27 Dec 2006 01:10:18 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4591C7FA.4040203@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David.
Thank you again for your help.
But I couldn't resolve the problem.

temp3 changes between 124-127
+12V, -12V, -5V seem to be wrong and maybe others too.

Maybe I have to edit .gkrellm2/sensor-config but don't know how

Another problem I have is "sensors" from lm-sensors.
I already added these lines to /etc/sensors.conf:

# Winbond W83627DHG configuration
# This is for an Asus P5B Deluxe WiFi-AP Edition
chip "w83627dhg-*"
# Temperatures
label temp1 "SYS Temp"
label temp2 "CPU Temp"
label temp3 "AUX Temp"
# Fans
label fan1 "Fan1"
label fan2 "CPU Fan"
label fan3 "Fan3"
label fan4 "Fan4"
label fan5 "Fan5"
# Voltages
label in0 "+3.3V"
label in1 "Vtt1.2V"
label in2 "Vram"
label in3 "Vchip"
label in4 "+5V"
label in5 "+12V"
label in6 "Vcc1.5V"
label in7 "Vcore"
label in8 "5VSB"

But "sensors" command doesn't show any value.
It just says the chipset:

w83627dhg-isa-0290
Adapter: ISA adapter

Do I have to update lm-sensors package?
I am using 2.10.0 version

