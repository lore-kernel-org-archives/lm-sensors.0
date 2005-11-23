From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Wed, 23 Nov 2005 14:12:22 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051123131115.GA3180@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Nov 23, 2005 at 01:18:32PM +0100, Jean Delvare wrote:
> "sensors -s" does too many things so it'll be hard to find out what
> exactly causes the hang. Could be any write on the bus, or a specific
> limit change. Better would be to try writing to the /sysfs files
> directly, manually, and see if any write causes the problem, or only to
> certain files.

I will try this later, probably tomorrow since I only have remote
access right now and no way to reset the machine :-( Should I attempt
to write arbitrary values to all writeable files under
/sys/bus/i2c/devices/0-002c/ ?

> Please also try to reproduce the hang without loading the eeprom
> driver.

Ok, I'll include that in the testing proposed above.

> I would additionally be interested in the SMBus topology (output of
> "i2cdetect 0" to start with, or whatever the bus number is for
> i2c-i801).

i2c-i801 is bus 0 on my machine, the only i2c bus.

oden:~# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX 
30: XX 31 XX 33 XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX 44 XX XX XX UU XX XX XX UU XX XX XX 
50: XX UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX 
60: 60 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX                         

> Do you happen to know if the SMBus on that board is
> multiplexed or shared with another bus type.?

Well, I'm not sure. What I can tell though is that sensors-detect
suggested to insert the it87 driver as well. If I do, I get the
message:

it87: Found IT8712F chip at 0x290, revision 7

in the kernel log. The output of sensors then reads:

oden:~# sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.26 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
VCore 2:   +1.47 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+3.3V:     +6.59 V  (min =  +8.16 V, max =  +8.16 V)   ALARM
+5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
+12V:     +11.58 V  (min = +16.32 V, max = +16.32 V)   ALARM
-12V:     -13.86 V  (min =  +3.93 V, max =  +3.93 V)   ALARM
-5V:       -8.51 V  (min =  +4.03 V, max =  +4.03 V)   ALARM
Stdby:     +5.56 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
VBat:      +3.17 V
fan1:        0 RPM  (min =    0 RPM, div = 8)          
fan2:        0 RPM  (min =    0 RPM, div = 8)          
fan3:       -1 RPM  (min =    0 RPM, div = 8)          
M/B Temp:    +80?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor   
CPU Temp:    +64?C  (low  =    -1?C, high =    -1?C)   sensor = diode   
Temp3:       +75?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor   

I'm not sure if there is a second I2C master on the bus or if the same
master is also mapped to the ISA bus address space somehow? Except for
that, I don't know how to answer the question...

-- 
Daniel Nilsson
