From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 04 Jan 2007 20:15:37 +0000
Subject: [lm-sensors] "sensors" no longer finding pcf8574 and pca9541
Message-Id: <20070104211537.891a86df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <459BC8E4.1010106@kr4jb.net>
In-Reply-To: <459BC8E4.1010106@kr4jb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Wed, 03 Jan 2007 10:16:52 -0500, Alan Porter wrote:
> Where to start?  My name is Alan Porter, and I am in a little
> over my head.  (Now I feel better).  I apologize in advance for
> not being able to speak intelligently about what I am seeing,
> but I am just now diving into this problem.
> 
> I just started a new job at a company that has a RedHat-based
> distro that runs on telecom equipment.  We monitor the health of
> our machines by running the "sensors" command and parsing the output
> with a perl script.
> 
> Recently (within the last few months?), we have found that the
> "sensors -A" command has stopped reporting some of our devices,
> specifically:
>  - the pcf8574 that monitors power supply health
>  - the pca9541 -- not sure what this does
> 
>  From what I can tell, the kernel modules are loading properly,
> because I get entries in the /sys filesystem.
> 
>    [root at doesnotwork i2c]# find /sys/bus/i2c
>    /sys/bus/i2c
>    /sys/bus/i2c/drivers
>    /sys/bus/i2c/drivers/lm87
>    /sys/bus/i2c/drivers/lm87/0-002d
>    /sys/bus/i2c/drivers/pcf8574
>    /sys/bus/i2c/drivers/pcf8574/0-0023
>    /sys/bus/i2c/drivers/pcf8574/0-0022
>    /sys/bus/i2c/drivers/pca9541
>    /sys/bus/i2c/drivers/pca9541/0-0070
>    /sys/bus/i2c/drivers/eeprom
>    /sys/bus/i2c/drivers/eeprom/0-0057
>    /sys/bus/i2c/drivers/eeprom/0-0053
>    /sys/bus/i2c/drivers/lm93
>    /sys/bus/i2c/drivers/lm93/0-002e
>    /sys/bus/i2c/drivers/dev_driver
>    /sys/bus/i2c/drivers/i2c_adapter
>    /sys/bus/i2c/devices
>    /sys/bus/i2c/devices/0-002d
>    /sys/bus/i2c/devices/0-0023
>    /sys/bus/i2c/devices/0-0022
>    /sys/bus/i2c/devices/0-0070
>    /sys/bus/i2c/devices/0-0057
>    /sys/bus/i2c/devices/0-0053
>    /sys/bus/i2c/devices/0-002e
>    [root at doesnotwork i2c]#
> 
> The drivers appear to work.  They return "sane" data.  "128" means the
> power supply is functioning properly with no warnings.
> 
>    [root at doesnotwork Driver]# cat /sys/bus/i2c/drivers/pcf8574/0-0022/read
>    128
>    [root at doesnotwork Driver]#
> 
> However, when I run "sensors -A", I no longer get the following entries
> in the output:
> 
>    pcf8574-i2c-0-22
>    pcf8574-i2c-0-23
>    pca9541-i2c-0-70
> 
> When I load an older version of our platform (older kernel, same version of
> lmsensors package), the "sensors -A" command includes these three entries.

This is expected. Since lm_sensors 2.10.0, libsensors non longer
handles non-hardware-monitoring chips on recent Linux 2.6 kernels. This
was briefly documented in the CHANGES document, although only the
"eeprom" driver case is explicitely listed. This is part of our plan to
cleanly separate the i2c and hardware monitoring subsystems.

The PCF8574 chip isn't a hardware monitoring chip, so it is no longer
handled by libsensors. It never actually belang there. For the PCA9541
I can't tell, the driver doesn't appear to be in the mainline kernel.

So it's really not a bug, it's a feature. You'll have to handle your
PCF8574 chips directly through sysfs, or write your own script or
application.

-- 
Jean Delvare

