From: Joakim Larsson <joakim@bildrulle.nu>
Date: Tue, 04 Mar 2008 17:53:21 +0000
Subject: [lm-sensors] lm78 detected as W83627DHG on MSI board
Message-Id: <1204653201.6143.18.camel@montecristo>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just upgraded from Ubuntu Edgy to Ubuntu Feisty on my MSI 975X
Platinum PowerUp Edition motherboard based system equipped with a
Pentium D. I never used lm-sensors since the Smart Fan utility seemed to
work pretty good before.

I got two other similar computers set up for my kids running Ubuntu
Dapper and they still have an active Smart Fan control that works.
Somewhere between Ubuntu Dapper to latest Edgy the Smart Fan control
stopped to work and the fan is almost always running noisily at full
speed. Thats why I upgraded my system to Feisty and are trying to set up
lm-sensors to work.

Running the sensors-detect in the Ubuntu Edgy distribution I got the
lm78 driver identified but in the Ubuntu Feisty and using the latest
sensors-detect from the lm-sensors.org home page it detects a Winbond
W83627DHG Super IO Sensors:

Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0x290, driver `w83627ehf')
  
However, I am only able to load the lm78 driver:

joakim@montecristo:~/Desktop$ sudo modprobe w83627ehf
FATAL: Error inserting w83627ehf
(/lib/modules/2.6.20-16-generic/kernel/drivers/hwmon/w83627ehf.ko): No
such device
joakim@montecristo:~/Desktop$ sudo modprobe lm78
joakim@montecristo:~/Desktop$ 

So I suspect that the latest sensors-detect script is doing something
wrong. 

Does anyone have any experience with this MSI board? Should I turn off
the Smart Fan feature in BIOS? 

BR Joakim 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
