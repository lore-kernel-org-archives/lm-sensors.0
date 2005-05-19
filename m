From: npfdd@gmx.net (Daniel Schregenberger)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors-CVS on 2.6.0-test10
Message-Id: <20031126190459.724240ad.npfdd@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!

I'm using an ASUS P4C800E-Deluxe which has a Winbond w83627thf
SuperIO-Chip. I have to use the beta Kernel because the Onboard LAN and
the SerialATA-Controller cause each other problems under 2.4.x (the LAN
won't work there).

I've tried to load the new user-space tools as suggested on the homepage
but it didn't work out. I'm not sure where the problem is. Maybe I
missed something I should compile into the kernel (do I need those
I2C-Algorithm-Modules (BitBanging-Device etc.) ?; and what about
ISA-Support? I don't have any ISA-Slots so I turned it off but
apparently the ISA-Bus is still present...)

Here are the results of my tries:

# modprobe i2c-i801

# ./lm_sensors2/prog/detect/i2cdetect=20
Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       unknown         SMBus I801 adapter at 0400            =20
Algorithm unavailable

# modprobe w83781d

# sensors=20
No sensors found!

# lsmod
Module                  Size  Used by
w83781d                33856  0=20
i2c_sensor              2304  1 w83781d
i2c_i801                7052  0=20
i2c_core               21124  3 w83781d,i2c_sensor,i2c_i801

I also tried 2.7.1 before I figured out I need 2.6 to enable my LAN and
this is what sensorsdetect (under 2.4.x) told me to load:
MODULE_0=3Di2c-i801
MODULE_1=3Di2c-isa
MODULE_2=3Dlm75
MODULE_3=EEprom
MODULE_4=3Dsmbus-arp
MODULE_5=3Dit87

So now I tried to load these modules (as far as they existed) on 2.6:

# modprobe lm75
# modprobe eeprom
# modprobe it87 =20

# sensors=20
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Algorithm: Unavailable from sysfs
ERROR: data 1

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Algorithm: Unavailable from sysfs
ERROR: data 1

lm75-i2c-0-49
Adapter: SMBus I801 adapter at 0400
Algorithm: Unavailable from sysfs
ERROR: Can't get temperature data!

lm75-i2c-0-48
Adapter: SMBus I801 adapter at 0400
Algorithm: Unavailable from sysfs
ERROR: Can't get temperature data!

Since this didn't work out and sensorsdetect not always gave me the same
results when I started it back in 2.4.x I don't really know what to do
know. sensorsdetect isn't yet functional on 2.6 kernels so I'm a bit
lost.

Any help appreciated. I can provide more information if necessary, just
tell me what you need.

Oh and I also tried it on test9 before I installed test10 with the same
results.

-- Daniel
