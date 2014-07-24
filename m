From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 24 Jul 2014 23:39:20 +0000
Subject: Re: [lm-sensors] not fan detected chromebook c720
Message-Id: <53D19928.6050301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <53D18E7E.4020308@gmail.com>
In-Reply-To: <53D18E7E.4020308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/24/2014 03:53 PM, Pietro Sammarco wrote:
> Hello people,
>
> I have recently bought a brand new Acer chromebook c720 which I am using with ArchLinux. Ever since I wiped out ChromeOS to install ArchLinux I realized a smell of electronic burning coming from it. Digging around I have realized lm-sensors does not detect the fan.
>
> The chipset is a Lynx Point (PCH), therefore as according the wiki it should work with the i2c-i801.
>
> I am going to attach a bit of informations below.
>
> Linux chromebookC720 3.16.0-1-mainline-chromebook #1 SMP PREEMPT Mon Jul 14 22:04:51 NZST 2014 x86_64 GNU/Linux
>
> [latrina@chromebookC720 ~]$ sudo i2cdetect -l
> i2c-0    i2c           i2c-designware-pci                  I2C adapter
> i2c-1    i2c           i2c-designware-pci                  I2C adapter
> i2c-2    smbus         SMBus I801 adapter at 0400          SMBus adapter


Well, it does, as you can see here.

Problem is that the fan controller is not detected, which suggests
that ChromeOS includes a fan controller driver for your system
which is not included in the upstream kernel and thus not in ArchLinux.
Detecting and instantiating the SMBus controller won't help you with
detecting the fan controller, much less with installing a driver for it.

You could try to get the ChromeOS kernel source, figure out how they
control the fans, and port the necessary code to ArchLinux. I don't know
if there is anything else you could do.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
