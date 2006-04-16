From: webe3@myrealbox.com (Brent S. Elmer, Ph.D.)
Date: Sun, 16 Apr 2006 23:10:15 +0000
Subject: [lm-sensors] sensor output writing to terminals
Message-Id: <1145229015.329.9.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm-sensors is working fine as far as reading the sensors.  The problem
is that it (or something) is sending the output to all open terminals.
I have had lm-sensors set up for years.  The writing to the terminals
has only started happening in the last month or so.  It is annoying to
be working in a terminal and the sensor data to constantly be written to
the terminal.  I use regular gnome terminals logged in as a normal user.

My system is Debian testing.
Kernel 2.6.15 custom built
lm-sensors 2.10.0

Here is the sensor detected information

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)

Here is a snippet of what is being written to the terminal:

Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
-12V: +2.03 V (min = -13.18 V, max = -10.80 V) [ALARM]
Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
-5V: +0.63 V (min = -5.25 V, max = -4.75 V) [ALARM]
Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
fan2: 0 RPM (min = 1188 RPM, div = 8) [ALARM]
Apr 16 19:07:48 VTdebian sensord: Sensor alarm: Chip w83697hf-isa-0290:
temp1: 24 C (limit = 12 C, hysteresis = 18 C, sensors = thermistor)
[ALARM]

Can someone please tell me what I need to configure to stop the writing
to all open terminals?

Thanks,

Brent


