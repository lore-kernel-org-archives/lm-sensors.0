From: Gabriel C <nix.or.die@googlemail.com>
Date: Wed, 20 Jan 2010 08:20:19 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <4B56BCC3.6050503@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 20.01.2010 05:30, b13johnson@comcast.net wrote:

Hello,

...
> [root@Backup-P4 smsc47m1_driver]# modprobe smsc47m1 
> FATAL: Error inserting smsc47m1 (/lib/modules/2.6.31.9-174.fc12.i686.PAE/kernel/drivers/hwmon/smsc47m1.ko): Device or resource busy 
> ---------------------------------------------------------- 
> 
> The log file "messages" has the following: 
> 
> ---------------------------------------------------------- 
> Jan 18 23:06:51 localhost kernel: i2c /dev entries driver 
> Jan 18 23:07:05 localhost kernel: smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997 
> Jan 18 23:07:05 localhost kernel: ACPI: I/O resource smsc47m1 [0x604-0x604] conflicts with ACPI region SMC_ [0x600 
> -0x65f] 
> Jan 18 23:07:05 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead 
> of the native driver 
> ---------------------------------------------------------- 
> 
> I'm running Fedora Core kernel 2.6.31.9-174.fc12.i686.PAE 
> 
> Do you have any ideas? I really appreciate your help. 
>


I guess you have to boot your kernel with :

acpi_enforce_resources=no

> Thanks, 
> Bob 

Best Regards,

Gabriel C

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
