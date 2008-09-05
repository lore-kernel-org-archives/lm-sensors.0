From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Sep 2008 08:37:15 +0000
Subject: Re: [lm-sensors] need info about sysfs for sensors
Message-Id: <20080905103715.34ee99f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <70270.75041.qm@web95204.mail.in2.yahoo.com>
In-Reply-To: <70270.75041.qm@web95204.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kalhan,

On Thu, 4 Sep 2008 12:12:09 +0530 (IST), kalhan trisal wrote:
> Hi, 
>  I wanted to know how should my sensors be places as my sensors
> driver takes care of all the sensor devices on the platform.
> I don't find any class as sensors->accelerometer/gyrometer/ambient
> light/compass.Is there any existing frame work where I can register
> my driver and use the interface.
>    If I use Hwmon then my devices are not connected to I2C directly.
> Can I get some help.

The hwmon class if for hardware monitoring and not sensors in general.
There is a separate project for so-called "industrial I/O" devices,
which include the devices you mention (accelerometer, gyrometer, etc.)
It isn't merged in the kernel yet. You can read the discussions about
it here:
  http://lkml.org/lkml/2008/7/23/163
If you have an interest in this then I suggest that you get in touch
with Jonathan Cameron (Cc'd). I don't know if the project has a mailing
list or home yet.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
