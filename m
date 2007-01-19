From: tmartin@physics.ucsd.edu (Terrence Martin)
Date: Fri, 19 Jan 2007 20:30:32 +0000
Subject: [lm-sensors] unresolved symbol is_unsafe_smbus
Message-Id: <45B12A68.4000309@physics.ucsd.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am getting the following error when trying to load the i2c-piix4 
module on RHEL3 with kernel. I am running a Serverworks HT-1000 chipset 
board with two AMD 275 Processors.

Code I am trying to use is
lm_sensors-2.10.2
i2c-2.10.2

Kernel is
Linux cabinet-5-5-0.local 2.4.21-37.0.1.ELsmp #1 SMP Tue Mar 7 12:24:47 
PST 2006 x86_64 x86_64 x86_64 GNU/Linux


root at cabinet-5-5-0 ~/sensors# modprobe i2c-piix4
/lib/modules/2.4.21-37.0.1.ELsmp/kernel/drivers/i2c/busses/i2c-piix4.o: 
unresolved symbol is_unsafe_smbus
/lib/modules/2.4.21-37.0.1.ELsmp/kernel/drivers/i2c/busses/i2c-piix4.o: 
insmod 
/lib/modules/2.4.21-37.0.1.ELsmp/kernel/drivers/i2c/busses/i2c-piix4.o 
failed
/lib/modules/2.4.21-37.0.1.ELsmp/kernel/drivers/i2c/busses/i2c-piix4.o: 
insmod i2c-piix4 failed
root at cabinet-5-5-0 ~/sensors#                                

According the FAQ symbol errors are often caused by running a different 
kernel than the compile headers, but I only have the headers for 
2.4.21-37.0.1 installed and the other i2c modules load fine.

The other question is I am running 2.4, and the sensors-detect said I 
could use k8temp module, however as far as I can tell that module was 
not built. Is k8temp 2.6 kernel only?

Thanks,

Terrence


