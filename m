From: "John Brier" <johnbrier@gmail.com>
Date: Mon, 22 Dec 2008 22:50:50 +0000
Subject: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't read
Message-Id: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[root@tb303 ~]# sensors
Can't access procfs/sysfs file
Kernel interface access error
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!

I have Debian 4.0 with 2.10.1-3 lm-sensors and libsensors3. I read
http://www.lm-sensors.org/wiki/Kernel2.6

"In kernel 2.6.22, the way the I2C adapters are presented in sysfs
changed, and this affects libsensors. You will need lm_sensors version
2.10.3 or later. Alternatively, the kernel can be compiled with
CONFIG_SYSFS_DEPRECATED=y, then version 2.10.2 will work too. Older
versions of lm_sensors will complain that the I2C adapter names can't
be read. This is only a warning though. "

So in my kernel 2.6.26.5 I have

# grep CONFIG_SYSFS_DEPRECATED /boot/config-2.6.26.5
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y

yet I still get this "warning" If it's only a warning why don't I get
the actual readings from my hardware? I looked into upgrading to
lm-sensors 3 and libsenseors4 packages from Debian testing tree but
the dependencies were pretty bad, I might as well upgrade the whole
system to testing.

I have run sensors-detect and have the proper modules loaded.

John Brier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
