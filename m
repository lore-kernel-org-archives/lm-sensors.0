From: frido@zolder.net (Frido Ferdinand)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: #1385 (sensors segfault)
Message-Id: <20030824213041.GA6171@borneo.zolder.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Regarding #1385:

---
It is completely different from ticket #1267.

Segfaults are often caused by old versions of libsensors being present on your
system. Please look in both /usr/lib and /usr/local/lib for libsensor* and keep
only the more recent version. Run "ldconfig" after that.

Another possibility is that you have different versions of i2c, lm_sensors
modules and lm_sensors userspace tools mixed. Please check that too. How did you
install the whole thing?

Follow up on the list (sensors@stimpy.netroedge.com), reference your ticket number.
---

There is only 1 version of libsensors around, this is 2.8.0, both i2c and 
lm_sensors where run from standard sources with ./configure; make; make install.
Loaded modules right now are:

i2c-i801                4724   0  (unused)
i2c-dev                 4772   0  (unused)
i2c-proc                7312   1 
i2c-core               13924   1  [i2c-i801 i2c-dev i2c-proc]

/proc/sys/dev/sensors is empty except for chips, which has no entries.

Jorge Luis Borges (1899-1986) said, "Violence is the last sanctuary of the
weak."
