From: curt@curtronics.com (Curt Blank)
Date: Tue, 20 Mar 2007 17:36:00 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf but
Message-Id: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Motherboard: MSI K9N4 SLI-F
Chipset: nVidia nForce 500 SLI
SuSE Linux 10.1
Kernel: 2.6.16.27-0.9
lm-sensors: 2.10.0-10 (from SuSE 10.1 distro)

I run sensors-detect that came with the SuSE distribution and it can't 
find any sensors. So then I download and run the latest sensors-detect and 
it tells me to use the w83627ehf driver. But when I try it fails:

# modprobe w83627ehf
FATAL: Error inserting w83627ehf 
(/lib/modules/2.6.16.27-0.9-smp-bnfsrvr/kernel/drivers/hwmon/w83627ehf.ko): 
No such device

It has a confidence of 9 but it fails. Am I missing something here?  
w83627ehf has been in the kernel since 2.6.13, but do I maybe need a newer 
version then I have? 

These are the modules currently installed:

# lsmod
Module                  Size  Used by
i2c_dev                12552  0
hwmon                   5128  0
eeprom                  9488  0
i2c_isa                 7552  0
i2c_nforce2             9344  0

I have the output from the sensors-detect if anyone wants to see it.

