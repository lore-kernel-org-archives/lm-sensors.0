From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Mar 2009 13:06:29 +0000
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <20090312140629.5d968b28@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wei,

On Tue, 3 Mar 2009 16:20:15 +0800, Wsong@nuvoton.com wrote:
> Dear lm-sensor group,
> 
> I am glad to submit to you the driver for Nuvoton W83795G/ADG hw monitor chip. 
> 
> The W83795G/ADG chip information are show at here:
> http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/HardwareMonitor/HWMonitorforDesktopAndServer/

I have added an entry for that chip to our wiki Devices page. Thanks a
lot for contributing code for your hardware, this is very appreciated.

> Driver files list:
> The attach file "wb83795.c" is the main driver file. This driver passed test on kernel 2.6.28.7.

Shouldn't this rather be w83795.c? This would be consistent with the
other driver names and with your sensors-detect patch.

> The attach file "Makefile" is used for compile the driver.
> 
> Patch files for lm-sensors 3.0.3:
> 
> The attach file "795_sensor3.conf" is the 795 related lines for sensor3.conf. But the exact names and settings may be changed for the motherboards.
> 
> The attach file "DESC" is the list of sys files which 795 driver would create.
> 
> The attach file "sensors-detect.3.0.3.patch" add detect 795 chip for "sensor-detect" tool in lm-sensors 3.0.3 package.

I have adjusted this patch so that it applies on top of 3.1.0 (there
have been a lot of changes in sensors-detect between 3.0.3 and 3.1.0.)
Can you please send me a dump of your W83795 chip so that I can test
the code before I commit it? You can obtain such a dump using the
i2c-dev kernel driver and "i2cdump" from the i2c-tools package:

# modprobe i2c-dev
# i2cdump 0 0x2d b

Replace 0 with the actual I2C bus number your chip sits on and 0x2d
with the actual I2C address of the chip. Remember to first unload the
w83795 driver if it is loaded.

> Until now, it seems there is not a motherboard based on W83795G/ADG in the market, and I am sure not the 795 SPEC could be share to you or not.
> 
> Please contact me if you need any help, want to know any information or have some other questions.

Unfortunately I will not have the time to do more. Maybe later when
there are actual motherboards with this chip and users start asking for
support...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
