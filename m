From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 16 Apr 2006 13:59:41 +0000
Subject: [lm-sensors] Improvement to I2C debugging tools
Message-Id: <20060416155941.7e43f57e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just made two improvements to our I2C debugging tools.

Firstly, I added an option -F to i2cdetect. When used, i2cdetect will
only print the functionalities offered by a given i2c adapter (or more
exactly by a given adapter driver.) Sample output:

root at arrakis:~> modprobe i2c-dev
root at arrakis:~> i2cdetect -l
i2c-0   smbus           SMBus I801 adapter at 1880              Non-I2C SMBus adapter
root at arrakis:~> i2cdetect -F 0
Functionalities implemented by /dev/i2c/0:
I2C                              no
SMBus Quick Command              yes
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               no
SMBus Block Write                yes
SMBus Block Read                 yes
SMBus Block Process Call         no
SMBus PEC                        no
I2C Block Write                  yes
I2C Block Read                   no
root at arrakis:~> 

Secondly, I added a mode W to i2cdump. This new mode is somewhere
between mode w (it uses SMBus Read Word transactions) and mode b (it
assumes 8 bit per "register".) The idea is to consider SMBus Read Word
as an I2C Block Read with length 2, as this is exactly how an EEPROM
will see it. So, when using i2cdump an a 24C02 EEPROM, modes b, c, W
and (if available) i should produce the same output. Thus, this new mode
W makes it possible and easy to test SMBus Read Word transactions on
any adapter; all it takes is an EEPROM on that bus.

This EEPROM dumping method also has an interest in terms of
performance. It fetches two bytes per transaction when modes b and c
only fetch one. For poll-based bus adapters with low to medium HZ
values, the speed benefit is enjoyable. Here is an example using
i2c-viapro with HZ%0:

i2cdump -y 5 0x50 b: 2.05 s
i2cdump -y 5 0x50 c: 2.05 s
i2cdump -y 5 0x50 W: 1.02 s
i2cdump -y 5 0x50 i: 0.19 s

Of course I2C Block Read is still much faster, but it is available only
on a limited number of adapters, while SMBus Read Word is very common.

With greater values of HZ (e.g. 1000) or for interrupt-based adapter
drivers, modes c and W should be roughly equivalent (SMBus Receive Byte
is 20 bits on the bus, SMBus Read Word is 48 bits and brings two bytes
at once.)

I was thinking of using the word mode in the eeprom kernel driver, as
it improves the performance in some cases. However, the exact gain
depends on the adapter driver (poll vs. interrupt, bit-banging I2C vs.
hardware SMBus) and the value of HZ for poll-based adapter drivers, and
I'd expect continuous byte mode to be faster or otherwise better (lower
latency, lower CPU load) in some conditions. For example, using some
i2c-algo-bit adapter at 25 kHz, I obtain:

i2cdump -y 1 0x50 b: 1.19 s
i2cdump -y 1 0x50 c: 0.59 s
i2cdump -y 1 0x50 W: 0.71 s
i2cdump -y 1 0x50 i: 0.25 s

So I'll probably forget leave the eeprom driver as is, but comments are
still welcome.

-- 
Jean Delvare

