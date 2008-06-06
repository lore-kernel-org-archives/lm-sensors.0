From: magic_rooter <magic.rooter@gmail.com>
Date: Fri, 06 Jun 2008 09:40:19 +0000
Subject: [lm-sensors] lm sensors don't work
Message-Id: <989aee610806060240h53d45c21v169e75b05a21e839@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, everybody!
I have a problem on my server - RHEL5, MSI K9N Neo V2 motherboard.
Maybe chipset is not supported?

root@rs1:/root>sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!
root@rs1:/root>

sensors-detect

Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
