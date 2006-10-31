From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 Oct 2006 21:24:03 +0000
Subject: [lm-sensors] sensors won't launch
Message-Id: <QCML0TWL.1162329843.6591780.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mathieu,

Redirected to the lm-sensors list, where it belongs.

On 10/31/2006, HALM Mathieu wrote:
> I install the last ubuntu 6.10
> The kernel is  2.6.17-10
>
> I have a problem to launch sensors

What's your system? Laptop, desktop? Which brand, which model?

Which version of lm-sensors are you using?

> I launched sensors-detect without problem
>
> the result of sensor-detect is :
>
> #----cut here----
> # I2C adapter drivers
> i2c-viapro
> # I2C chip drivers
> eeprom
> #----cut here----

The complete output would be much more useful.

> I put these lines in my /etc/module files
> I loaded them and can see the 2 modules in lsmod
>
> But when I launched sensors, I got this error message :
>
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
>
> /sys is well mounted
>
> I m not sure if I have the sysfs support in my kernel (I don't how to
> check this) but I believed it should ok in the 2.6 kernel

This error message is misleading and was fixed since. What it really
means is: no sensors found. Which is true, as sensors-detect found an
SMBus master and some EEPROM on that bus, but no sensor chip. (You can
read the EEPROM contents with decode-dimms.pl, but that's not what
you're after.)

So, either sensors-detect missed some chip, and you want to try the
latest version of sensors-detect, or your system indeed doesn't have
any sensor chip - this is frequent on laptops and vendor desktop
machines.

--
Jean Delvare

