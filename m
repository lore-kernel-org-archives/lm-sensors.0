From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 19 Feb 2006 22:03:01 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I rewrote the vt1211 driver to implement it as a platform driver but
now sensors doesn't see it anymore. The chip is registered at
/sys/devices/platform/vt1211.24576 but sensors (2.10.0) reports:
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!

SYSFS support is compiled into libsensors and kernel version is 2.6.16-rc3-mm1.

Thanks
...juerg

