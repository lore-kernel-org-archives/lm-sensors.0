From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 24 Aug 2006 15:09:18 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <20060824170918.d3712d49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Prakash,

> the mobo has nforce430 (MCP51) chipset. sensors-detect tells me the it87 
> driver should be the right one, but it doesn't seem to help:
> 
> lsmod:
> Module                  Size  Used by
> i2c_dev                 9992  0
> it87                   23140  0
> hwmon_vid               3456  1 it87
> i2c_isa                 4736  1 it87
> eeprom                  6736  0
> loop                   57172  0
> powernow_k8            12640  1
> i2c_nforce2             7488  0
> nvidia               5424340  12
> i2c_core               19776  6 i2c_dev,it87,i2c_isa,eeprom,i2c_nforce2,nvidia
> 
> sensors:
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> I am using 2.6.18-rc4 kernel with lm-sensors 2.10.0
> 
> Any idea what to do? Thx.

You have a recent ITE Super-I/O, IT8716F, which isn't supported yet.
But you are lucky, I have been working on this in the last two weeks.
You can get a kernel patch here:
http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v2-2.6.18.patch

And user-space support is available in the latest SVN snapshot of
lm_sensors:
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4108-20060824.tar.bz2

Please report your results!

-- 
Jean Delvare

