From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 19 Jan 2007 15:25:23 +0000
Subject: [lm-sensors] question about vt1211
Message-Id: <191fb4ca0701190725j2620de3dvd521e23c690e72e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sasha,

For future questions, please cc the lm-sensors mailing list since
other people might be interested as well.

> I compiled the driver and successfully installed the module on my
> distribution (TimeSys 2.6.17) .  I read the document I found in 2.6.19, but
> it didn't give me the idea on how to call driver functions from user level
> application.

I'm not familiar with TimeSys but from the name I'm assuming your're
running a 2.6.17 kernel. The official vt1211 driver is not part of
this kernel, it got added later with 2.6.19. Are you using Lars
Ekmans' driver? If so, you should switch to 2.6.19 or later and use
the official vt1211 driver that comes with the kernel.

Like all hwmon drivers, the vt1211 driver creates a bunch of sysfs
files which are used to exchange data between the driver and
user-space processes. After loading the official driver, check
/sys/class/hwmon/vt1211. It contains a bunch of files that you can
access using regular read() and write() file operations to retrieve
data from the driver (like temps and fan RPMs) or write data to the
driver (like thermal thresholds).

Please check Documentation/hwmon/sysfs-interface and vt1211 for an
explanation of how to interpret the various files and their content.

The standard way is to use a tool called 'sensors' which is part of
the lm-sensors package. It reads these files, manipulates the data
according to some rules specified in /etc/sensors.conf and displays
them. Check it out...


> VIA Web site has  utility VIA_SystemHealth, but they don't provide source
> code as a reference for developers.  Could you please give me some idea on
> how to find API to the driver.

VIA's tool doesn't work with the 2.6.19 vt1211 driver, it is tailored
toward the old unofficial driver.

...juerg


> Thanks for the help.
>
> -- sasha
>

