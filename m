From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 04 Jan 2007 21:51:50 +0000
Subject: [lm-sensors] "sensors" no longer finding pcf8574 and pca9541
Message-Id: <ac921f990701041351j57810c10jbfa2ccc314f38e8c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <459BC8E4.1010106@kr4jb.net>
In-Reply-To: <459BC8E4.1010106@kr4jb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/4/07, Jean Delvare <khali at linux-fr.org> wrote:
> Hi James,
>
> Hey, long time no see, how are you?
Doing pretty good.

>
> On Thu, 4 Jan 2007 15:38:36 -0500, James Olin Oden wrote:
> > Jean I work with Alan, and I can definately say that that is easy
> > enough, but don't you think there ought to be some generic way to list
> > from a CLI and/or an API the I2C devices (similar to lspci for PCI
> > devices)?
> >
> > Just my 2 cents...james
>
> Well we have "i2cdetect -l" already, which lists the i2c busses, then
> "i2cdetect N" to list the devices on i2c bus N. It doesn't give the
> chip names though. The problem is that I2C differs fundamentally from
> PCI in that the devices are not enumerated and have no unique ID.
> i2cdetect attempts to detect the addresses where a device lives, but
> it's only trick, we're not following any specification.
>
> So you could write an "lsi2c" tool, but it would have to list the
> devices known by the kernel, i.e. for which a driver has already been
> loaded. That would be done by walking /sys, should be easy enough. But
> it might be a bit confusing that it lists only "driven" devices, as
> opposed to lspci or lsusb which list all present devices, even without
> a driver.
>
I think I would be happy with that.  My thinking is that as much as
possible the structure of your sysfs entries should be hidden
(programatically).   libsensors as crufty as it is always provided a
nice abstraction layer, though honestly with these devices it would
simply display a single line with them; I mean there wasn't much one
could do except be aware that they are there.

As it is its not hard with my current set of libraries to capture them
from sysfs so that is what I'll do for now.

> Or you could add device identification to the tool, and it would
> attempt to find out which devices are there, as sensors-detect is
> trying to do for I2C/SMBus hardware monitoring chips. But then this is
> a huge task, because many I2C chips are really hard to identify just by
> probing them, and it some cases it can even be unsafe to just try.
>
I wasn't trying to solve the identification problem which seemed to be
onerous as ISA device identification back in the bad old days before
PCI.

> All in all it really depends on what exactly you are trying to achieve.
>
I have library that provides a simple perl interface to the sensors
information and caches that information for some configurable amount
of time, such that you hopefully rarely loose alarms.  In this
particular case the power supplie devices actually kind of do have
"sensors" that are read, but libsensors never gave that.  My library
though was driven by the fact that libsensors returned this device
name and when i detected it I would read the additional information
from sysfs.

Its not hard for me to add my own scan though to look for these
additional devices, I just liked the fact that sensors was reporting
its existence to me.

Cheers...james

