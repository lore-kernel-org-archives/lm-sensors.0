From: devik@cdi.cz (Martin Devera)
Date: Wed, 01 Mar 2006 20:57:34 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <44060ABE.4000904@cdi.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I loaded the adm1026 module by hand:
> 
> [root at nemo-slave0017 ~]# lsmod | egrep '(i2c|adm)'
> adm1026                46736  0
> i2c_piix4              14480  0
> adm1025                27156  0
> hwmon_vid               7040  2 adm1026,adm1025
> i2c_isa                10624  0
> i2c_dev                17408  0
> i2c_core               30720  6 
> adm1026,i2c_piix4,adm1025,eeprom,i2c_isa,i2c_dev
> 
> I have:
> [root at nemo-slave0017 ~]# ls /sysfs
> block  bus  class  devices  firmware  kernel  module  power
> [root at nemo-slave0017 ~]# ls /sys
> block  bus  class  devices  firmware  kernel  module  power
> 

send
dmesg|tail -n 30
and try
ls /sys/class
(there is typicaly hwmon class, if yes, list it too)

