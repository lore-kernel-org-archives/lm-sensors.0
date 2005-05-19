From: stuart@sswindells.free-online.co.uk (Stuart Swindells)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <200408122152.i7CLqOKW026201@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
In-Reply-To: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.53 V  (min =  +1.33 V, max =  +1.47 V)
+12V:     +12.18 V  (min = +10.84 V, max = +13.21 V)
+3.3V:     +3.44 V  (min =  +3.14 V, max =  +3.48 V)
+5V:       +5.13 V  (min =  +4.75 V, max =  +5.26 V)
-12V:     -14.88 V  (min = -10.77 V, max = -13.16 V)
V5SB:      +5.12 V  (min =  +4.77 V, max =  +5.25 V)
VBat:      +0.01 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =  659 RPM, div = 32)
CPU Fan:     0 RPM  (min =   -1 RPM, div = 2)
fan3:        0 RPM  (min = 10546 RPM, div = 128)
M/B Temp:    +27?C  (high =   +48?C, hyst =    +0?C)   sensor = thermistor

CPU Temp:  +85.5?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
ALARM
vid:      +1.400 V
alarms:
beep_enable:
          Sound alarm enabled
Is the output with the fault, it's not possible to get output without the
fault, since as soon as lm_sensors is installed, the fault appears.
Running cat on the three temp[1-3]_input files in
/sys/bus/i2c/devices/1-0290/ gives:
27000 	temp1_input
26000 	temp2_input (what's read as the CPU temp, goes further than temp1
under load, and is what goes to 85000)
-48000 	temp3_input

And for the voltages:
3061 	in0_input
3205 	in1_input
3445 	in2_input
3077 	in3_input
5	in4_input
3061	in7_input
5	in8_input

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 12 August 2004 20:21
To: 'Mr Admin'
Cc: sensors@Stimpy.netroedge.com
Subject: Re: Ticket 1751

> When everything is fine, CPU and MB temps move up and down with load
> as expected (and as confirmed by the BIOS).
> The only required action to break the values appears to be installing
> lm-sensors by apt-get install (which I'd guess runs sensors-detect) -
> removing lm-sensors, and running only the w83627hf kernel module (ie
> without lm_sensors) provides the "correct" (in the sense of more valid
> anyway) values. When broken, the CPU temp locks itself at 85.0?C, and
> doesn't shift whatsoever.
> Sensors -s doesn't help anything.

Just asked the debian maintainer about it, and he told me that
installing the package will actually run "sensors -s", not
sensors-detect. So "sensors -s" is somehow messing with your chip. I
can't remember of a similar report so far.

The configuration file doesn't seem to do anything with temperatures, it
only sets voltages. Maybe what you see is a side effect of some bug in
the driver.

Please provide the output of "sensors" with and without the problem. I
want to see if other values have changed or not. If for example some
voltage limits have not properly changed to what the configuration file
has, we would know where to look.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/


