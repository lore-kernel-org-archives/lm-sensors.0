From: ballen@gravity.phys.uwm.edu (Bruce Allen)
Date: Wed, 01 Mar 2006 20:53:29 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <Pine.LNX.4.62.0603011449380.27761@trinity.phys.uwm.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> One other possibility is that because I have a BMC card plugged in to the 
>> motherboard (SuperMicro H8SSL-i) the BMC card is not allowing access to the 
>> devices from lm_sensors.
>
> it works well for me for the same MB, only loaded patched piix4 and then
> adm1026 module. Then even supermicro's superodoctor started to work on the 
> bow :) But I can imagine that it may become unavailable after BMC is plugged 
> in. I havn't bought BMC yet but I want to.

I loaded the adm1026 module by hand:

[root at nemo-slave0017 ~]# lsmod | egrep '(i2c|adm)'
adm1026                46736  0
i2c_piix4              14480  0
adm1025                27156  0
hwmon_vid               7040  2 adm1026,adm1025
i2c_isa                10624  0
i2c_dev                17408  0
i2c_core               30720  6 adm1026,i2c_piix4,adm1025,eeprom,i2c_isa,i2c_dev

I have:
[root at nemo-slave0017 ~]# ls /sysfs
block  bus  class  devices  firmware  kernel  module  power
[root at nemo-slave0017 ~]# ls /sys
block  bus  class  devices  firmware  kernel  module  power

sensors-detect reports: "Sorry, no chips were detected."

[root at nemo-slave0017 ~]# sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!


