From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Jun 2013 11:28:37 +0000
Subject: Re: [lm-sensors] Module load order dependency
Message-Id: <20130604132837.7e8ba705@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <51A9CC8D.2010105@sat.dundee.ac.uk>
In-Reply-To: <51A9CC8D.2010105@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Mon, 03 Jun 2013 16:01:01 +0100, Paul Crawford wrote:
> Dear Jean,
> > I believe the manual page libsensors(3) is pretty complete. What do you
> > think is missing? Suggestions are welcome, and patches even more so ;)
> 
> I have the lm-sensors package installed on my machine (Ubuntu 12.04) and 
> that has not added a man page for libsensors, but I don't know if that 
> is Canonical's actions or the lm-sensors suite.

The manual page for libsensors is included in the source package and
installed by "make install". With distribution packages, you most
likely have to install the development package to get the manual pages
from section 3. This is libsensors4-devel in openSUSE, most likely
libsensors4-dev in Ubuntu.

> Looking at the site's 
> page here:
> 
> http://www.lm-sensors.org/wiki/man/libsensors

Beware that man pages on our site are badly out-of-date :( The wiki
page above is 7 years old, while the actual manual page was updated 37
times meanwhile :(

I think I'll just delete the manual pages from the wiki, presenting
out-of-date documentation is bad and confusing and possibly dangerous.
linuxmanpages.com die.net both have much more up-to-date manual pages:

http://www.linuxmanpages.com/man3/libsensors.3.php
http://linux.die.net/man/3/libsensors

AFAICS die.net's is more recent, but formatting on linuxmanpages.com is
better. Might be that our mark-up is less than optimal, but I am no
expert in troff language and I don't really have the time to work on
this right now.

> Start with this:
> 
> "int sensors_init(FILE *input);
> (Re)load the configuration file and the detected chips list. If this 
> returns a value unequal to zero, you are in trouble; you can not assume 
> anything will be initialized properly."
> 
> What format is the file? I presume it is the sensors.conf format, but 
> that is not stated.

Yes, this is sensors.conf. I'll add mention of it.

> What if 'input' is NULL, will it use defaults, if so what are they?

From the latest version of the man page:

"If FILE is NULL, the default configuration files are used (see the
FILES section below). Most applications will want to do that."

> Can I call it for multiple files or will that destroy past configurations?

From the latest version of the man page:

"If you want to reload the configuration file, call sensors_cleanup()
below before calling sensors_init() again."

While it is not explicitly stated, you can't call it for multiple files
(unless they are all in /etc/sensors.d and and you pass NULL as the
input parameter.)

This is an historical limitation, ideally initialization and
configuration file parsing would be achieved in two distinct functions.
If we ever redesign the library, we should do that. That being said,
the current limitation doesn't seem to be an issue in practice.

> The sensors_cleanup() is clear, but then there is a list of functions to 
> do various things without an explanation of what those things are. Take 
> for example there two:
> 
> "const char *sensors_get_adapter_name(int bus_nr);
> const char *sensors_get_algorithm_name(int bus_nr);
> These functions return the adapter and algorithm names of a bus number, 
> as used within the sensors_chip_name structure. If it could not be 
> found, it returns NULL"
> 
> What is 'the adapter'? The specific chip used to sense? It seems not to 
> be covered anywhere else on that page.

Adapters describe how a monitoring chip is hooked up to the system.
This is particularly relevant when the monitoring chip cannot be
accessed directly by the CPU. The most common example of this is
I2C/SMBus sensor chips, which must be accessed over an I2C/SMBus
master. LPC / Super-IO / CPU-embedded sensors, on the other hand, can
be accessed directly and don't really need an adapter, but for
simplicity sensors_get_adapter_name will return a generic adapter name
for these ("PCI adapter" for example.)

I agree this is not clearly explained even in the last version of the
manual page.

> What is an 'algorithm name'? Is this the computation details of 
> converting digital count to physical parameter? What possible values can 
> this be?

Algorithms have been removed from the API altogether meanwhile :)

> What is the 'bus number'? I am guessing it is I2C address or something, 

It's not an I2C address, but the number of (typically) an I2C
bus/adapter (to be totally accurate: of an I2C bus segment.) If you
have more than one I2C bus in your system (and these days, you do), the
kernel must give them a number so that they can be distinguished from
each other.

> but how would I know what it will be? There is no obvious call to find 
> out the bus numbers and it is not mentioned elsewhere on that page. Do I 
> even need to know them unless I am doing hardware development, or can I 
> just read all sensors without such knowledge?

The simple answer is that you can ignore bus numbers.

The complete answer is: it depends. If you need to access a specific
monitoring chip which is on an I2C bus, you need to know the bus number
and the chip's address on that bus.

The problem is that the bus number could change over reboots. To
workaround this problem, you can have bus statements in the
configuration file, which map I2C bus _names_ (which are stable) to
fake I2C bus numbers, and these fake I2C bus numbers can be used in the
configuration file, and libsensors will apply the configuration
statements to the chip on the right I2C bus, regardless of its current
number.

As I wrote before, there is still an unresolved issue about this, when
it comes to passing chip names (which can include a bus number) as a
command line parameter to "sensors". The same issue would exist for
other applications doing the same.

In practice, it really only matters on systems with multiple I2C sensor
chips on different buses but using the same I2C address (as I2C address
uniqueness is per-segment), and then only if you want to apply
different configuration statements to these chips. So this affects a
very small number of systems.

> Maybe this would be clearer if the 'sensors_chip_name' structure was 
> documented, but it is not on that page nor linked from it.

I think I left it undocumented on purpose because it's an internal
structure and applications should never tinkle with it.

> (similar thoughts for other function calls)
> 
> It may be that studying the source code for the sensors library would 
> reveal these things, but the purpose of a library & documentation is so 
> you don't need to go through the low-level details of how it all works 
> because you have a simple described API that will do it for you.

In fact I suspect that looking at the code of "sensors" would be a
better idea, it is very simple and covers most of (maybe even all) the
API. The same suggestion is made in this document:
  http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/developers/applications

> (sorry if that sounds a bit of a rant)

No problem. The manual page was written by the authors of the library
(that would be mostly me for the current version) who had intimate
knowledge of the whole thing. For me it was difficult to realize what
was obvious and what needed a more detailed description. So it is
rather logical that the manual page doesn't properly address the
questions of application developers, because none ever reviewed that
document.

In fact I am very happy that you are doing that now, and I will enhance
the manual page with answers to the questions you're asking now. So
keep asking :)

> > (...)
> > The problem is that there is no read(2), write(2) or ioctl(2)
> > implemented for hwmon devices, so the point of having device nodes is
> > hard to justify.
> 
> I can see read() making sense, but maybe not write(). ioctl() could be 
> used to set limits, but I guess that is not the current way of thinking.

Given the time we spent on standardizing and implementing the sysfs
interface, I feel no urge to go for something completely different
right now ;)

I'm not even sure how read() would possibly be used. But if you have a
really good idea about it, I'm all ears. I've been working on this for
so long that everything we do today seems natural to me. But sometimes
an outer look can be very helpful.

> > (...)
> > We agree on the analysis. I suppose this could be solved by adding a
> > (somewhat artificial, granted) dependency between both "services" (or
> > whatever upstart calls these.)
>
> Things like that are really working with the symptoms in a way, as the 
> underlying problem is the kernel has no fixed order for the hwmon stuff. 

The kernel has no fixed order for any class device, that's not limited
to hwmon. i2c bus numbers can change, network interface numbers can
change, etc. That's why we have /dev/disk/by-id, ugly network interface
renaming code in udev, etc.

And you should expect this to get fixed anytime soon, as it's all by
design. The kernel allocates arbitrary numbers, and exposes device
attributes which should be sufficient to uniquely identify each device.
The rest is up to user-space.

> In a sense, libsensors is doing the same but at least it is a 
> centralised solution to that problem!

Yes, sort of. But libsensors doesn't currently address the problem
completely. Plus it doesn't cover all of the hwmon sysfs API, so
applications like fancontrol can't use it. Still a long way to go, and
so little time...

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
