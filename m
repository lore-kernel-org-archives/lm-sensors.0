From: crotalus@superig.com.br (Paulo Roma Cavalcanti)
Date: Fri, 21 Apr 2006 23:06:17 +0000
Subject: [lm-sensors] asb100 not working in kernel 2.6.16
Message-Id: <44496569.6030100@superig.com.br>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


I have been using lm_sensors for a long time
on an Asus P4S333 motherboard.
However, they are no longer working with the 2.6.16
kernel series. During the boot there is a message
saying it cannot find any i2c information.

Interesting is that the modules are loaded:

eeprom                  7249  0
asb100                 20437  0
hwmon_vid               2881  1 asb100
hwmon                   3269  1 asb100
i2c_sis96x              5829  0
i2c_core               21697  3 eeprom,asb100,i2c_sis96x
rfcomm                 36821  0
l2cap                  24641  5 rfcomm

But if I try to read the sensors, I get:

Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!

My system is a Fedora 4 with latest lm_sensors from ATrpms.

Linux version 2.6.16-1.2096_FC4 (bhcompile at hs20-bc1-4.build.redhat.com)

I am loading the modules below in /etc/sysconfig/lm_sensors:

MODULE_0=3Di2c-sis96x
MODULE_1=3Dasb100
MODULE_2=EEprom

They work very well with kernel 2.6.15 and below, only.

I appreciate any suggestion.

Thank you.

/Paulo Roma

