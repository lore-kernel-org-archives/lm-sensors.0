From: keith@midnighthax.com (Keith Edmunds)
Date: Tue, 11 Jul 2006 12:11:19 +0000
Subject: [lm-sensors] Linux 2.6.16 kernel and "Can't access procfs/sysfs
Message-Id: <44B39567.40106@midnighthax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I've installed lm_sensors v2.10.0 on a Linux system running a 2.16.6
kernel. That's a Debian kernel, but I've also tried with a 2.6.17.4
vanilla kernel.

lm_sensors builds and installs fine, and sensors-detect runs and detects
i2c-i801. The 'sensors' command gives 'Can't access procfs/sysfs file'.
The FAQ suggests ensuring that /sys is mounted and populated (it is),
and that i2c-proc is loaded. That module is not loaded, but it doesn't
seem to be in the 2.16.6 kernels.

Should I have an i2c-proc module? If not, any further suggestions would
be welcome - thanks.

Keith

