From: David Anderson <davea42@gmail.com>
Date: Wed, 27 Jul 2011 18:56:05 +0000
Subject: [lm-sensors] w83795adg no longer shows up in sensors
Message-Id: <4E305F45.5080801@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just updated my  7046T Supermicro with a minor
update of Ubuntu 10.10  to 2.6.35-30-generic *86_64 SMP.
Intel

Suddenly I find sensors is not finding the w83795adg .

The output of 'sensors' is
w83627hf-isa-0a00
Adapter: ISA adapter
beep_enable:enabled

It's been working (through various kernel updates)   using the
'make'  etc shown just below after each update. No problem.
Now it fails to work.  One change I made was to turn off hyperthreading
in the BIOS (an experiment to see if that speeds or degrades
my running of seti@home), but I would hope that change was irrelevant.

I'm uncertain how to get 'sensors' working again.

Suggestions?
Thanks in advance for any help.
DavidAnderson
---------------
After kernel install and reboot, I did

(this is Jean D's w83795.c . source from January 2011 or so,   from 
khali.linux-fr.org)

make clean
make
sudo make install
sudo service lm-sensors stop
sudo service lm-sensors start
sudo modprobe w83795

which does not help.

--------------------------------------------------------
dmesg shows:

[  131.083884] i2c i2c-0: w83795: Detection failed at addr 0x2e, check bank
[  131.217186] i2c i2c-0: w83795: Detection failed at addr 0x2f, check 
i2c addr
[  692.676771] i2c /dev entries driver
[ 2461.216555] i2c /dev entries driver

-------------------------------
sensors-detect  shows, at the final output

BDriver `to-be-written':
   * ISA bus, address 0xca2
     Chip `IPMI BMC Unknown' (confidence: 8)

Driver `coretemp':
   * Chip `Intel digital thermal sensor' (confidence: 9)

Driver `w83627hf':
   * ISA bus, address 0xa00
     Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)

Driver `w83795':
   * Bus `SMBus I801 adapter at 0400'
     Busdriver `i2c_i801', I2C address 0x2f
     Chip `Nuvoton W83795G/ADG' (confidence: 8)

Note: there is no driver for IPMI BMC Unknown yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
