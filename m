From: AAtallah@GMX.net (Antoine Atallah)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Error message on IBM Aptiva
Message-Id: <200402242045.i1OKjj1s020739@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

 

            As the error message specifies, and to help you develop your
great drivers, here is a copy of what my Aptiva 2274-38U (Duron 600MHz
version) told me when I ran sensor detect. Also, it is on kernel 2.4.25
(Gentoo Linux, recompiled and all). So, if that can help you, i'm happy :-)

 

            Antoine Atallah

 

Neptune root # sensors-detect

 

This program will help you determine which I2C/SMBus modules you need to

load to use lm_sensors most effectively. You need to have i2c and

lm_sensors installed before running this program.

Also, you need to be `root', or at least have access to the /dev/i2c-*

files, for most things.

If you have patched your kernel and have some drivers built-in, you can

safely answer NO if asked to load some modules. In this case, things may

seem a bit confusing, but they will still work.

 

 BIOS vendor (ACPI): VIA694

 System vendor (DMI): IBM

 BIOS version (DMI): S21M-E4

 Sorry, we won't let you go on. IBM systems are known to have

 serious problems with lm_sensors, resulting in hardware failures.

 For more information, see README.thinkpad or

 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad.

 We used two methods to determine your system's vendor, and they led

 to different results. We'd appreciate to have feedback about such

 systems. Please, take some time and contact the lm_sensors mailing

 list at <sensors@stimpy.netroedge.com>.

 We need the following information:

  * The brand and model of your system

  * The BIOS vendor (ACPI) displayed above

  * The System vendor (DMI) displayed above

 Thanks!

 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040224/5dd28f6e/attachment.html
