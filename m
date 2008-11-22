From: skylimit <b.tancic@gmail.com>
Date: Sat, 22 Nov 2008 09:38:51 +0000
Subject: [lm-sensors] libsysfs.so.2  problem
Message-Id: <loom.20081122T093439-684@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello all,

i have linux box (slackware, 2.6.18) and lm_sensors already installed. when i
try to start it, there is an error message :

./sensors: error while loading shared libraries: libsysfs.so.2: cannot open
shared object file: No such file or directory

command sensor-detect on the end says:

Can't exec "i2cdetect": No such file or directory at ./sensors-detect line 5127,
<STDIN> line 2.
Couldn't find i2cdetect program!! at ./sensors-detect line 5127, <STDIN> line 2.

and ldd sensors:

 libsensors.so.3 => /usr/lib64/libsensors.so.3 (0x00002aca25e36000)
        libc.so.6 => /lib64/tls/libc.so.6 (0x00002aca25f8c000)
        libm.so.6 => /lib64/tls/libm.so.6 (0x00002aca261c5000)
        /lib64/ld-linux-x86-64.so.2 (0x00002aca25d1e000)
        libsysfs.so.2 => not found

Can somebody please tell me how can i find solution to this problem.

Thank you in advance


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
