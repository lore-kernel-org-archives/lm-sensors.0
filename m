From: jenniferv@messagegate.com (Jennifer Villar)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: No sensors found!
Message-Id: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am a complete newbie here cutting my teeth on RedHat 9 Kernel
2.4.20-8smp. I am trying to get lm_sensors to work but I continually get
the "No Sensors found!" error. I have followed the instructions that
sensors-detect has provided (except the /etc/rc* entries as I am not
sure which file to put the entries into, any?). 

 

I am using a Supermicro server with an Intel 857 chipset and the Super
P4SCA motherboard. Unfortunately I cannot look at the mother board as
the system is racked. 

 

Here is some of the information I have that may shed light to someone
who knows a thing or two about this stuff.

 

# Results from lsmod

 

Module                  Size  Used by    Not tainted

i2c-isa                 1868   0  (unused)

i2c-dev                 5636   0

i2c-philips-par         3360   0  (unused)

parport                39072   0  [i2c-philips-par]

i2c-elv                 2408   0

i2c-algo-bit            8872   1  [i2c-philips-par i2c-elv]

i2c-proc                9232   0

i2c-core               19908   0  [i2c-isa i2c-dev i2c-algo-bit
i2c-proc]

autofs                 13684   0  (autoclean) (unused)

e1000                  70400   1

ipt_REJECT              3928   0  (autoclean)

iptable_filter          2412   0  (autoclean)

ip_tables              15864   2  [ipt_REJECT iptable_filter]

keybdev                 2976   0  (unused)

mousedev                5656   0  (unused)

hid                    22308   0  (unused)

input                   6208   0  [keybdev mousedev hid]

usb-uhci               27404   0  (unused)

ehci-hcd               20456   0  (unused)

usbcore                82592   1  [hid usb-uhci ehci-hcd]

ext3                   73376   2

jbd                    56336   2  [ext3]

 

# Output of sensors-detect

 Detects correctly:

  * ISA bus address 0x0290 (Busdriver `i2c-isa')

    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

 

 

 I will now generate the commands needed to load the I2C modules.

 Sometimes, a chip is available both through the ISA bus and an I2C bus.

 ISA bus access is faster, but you need to load an additional driver
module

 for it. If you have the choice, do you want to use the ISA bus or the

 I2C/SMBus (ISA/smbus)? Driver `w83627hf' (should be inserted):

  Detects correctly:

  * ISA bus address 0x0290 (Busdriver `i2c-isa')

    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

 

To make the sensors modules behave correctly, add these lines to

/etc/modules.conf:

 

#----cut here----

# I2C module options

alias char-major-89 i2c-dev

#----cut here----

 

To load everything that is needed, add this to some /etc/rc* file:

 

#----cut here----

# I2C adapter drivers

modprobe i2c-isa

# I2C chip drivers

modprobe w83627hf

# sleep 2 # optional

/usr/bin/sensors -s # recommended

#----cut here----

 

Any information would be greatly appreciated.

 

-Jennifer

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040326/801f2267/attachment.html
