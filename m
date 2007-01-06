From: salatiel.filho@gmail.com (Salatiel Filho)
Date: Sat, 06 Jan 2007 23:33:41 +0000
Subject: [lm-sensors] HP PAVILLION dv8000
Message-Id: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi , i have a hp pavillion dv8000.

sensors-detect build this file:


#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
modprobe i2c-i801
# Chip drivers
# Warning: the required module ds1621 is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe ds1621
# Warning: the required module eeprom is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----


but after all modules be SUCCESSFULLY loaded sensors -s still returns :

No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

What is the problem ???

Thanks in advice ...

-- 
[]'s
Salatiel

"O maior prazer do inteligente ? bancar o  idiota
   diante de um  idiota que banca o inteligente".

