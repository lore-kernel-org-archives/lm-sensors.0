From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 29 May 2009 07:36:25 +0000
Subject: Re: [lm-sensors] lm-sensors benefits
Message-Id: <4A1F9079.7070300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <0331509C72A4CE4F925973DC8EC98E1B0165F5E4@AMSACEX2.americas.ad.flextronics.com>
In-Reply-To: <0331509C72A4CE4F925973DC8EC98E1B0165F5E4@AMSACEX2.americas.ad.flextronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 05/28/2009 04:00 PM, Rob Bloom wrote:
>
>
> Many thanks to Hans, Mark and Jonathan for answering my previous email
> on specific hwmon chips (turns out 3 of the 4 I questioned are not (yet)
> supported by lm-sensors). I=92d like to back-up a bit and ensure I
> understand what lm-sensors will do for us in our project:
>
> Essentially, we want to be able to read our temp and power monitor chips
> every 10 seconds and evaluate the values read (pass them for review to
> our own customized health monitoring system). I=92ve been tasked with
> explaining the benefits of using lm-sensors package vs. not using it.
> Hopefully my questions do not seem too naive but I=92m asking them from
> the perspective of having to write drivers (or, at least, assisting) for
> unsupported chips:
>
> - As I understand it, the drivers for these chips are not part of
> lm-sensors; one must develop the code for the chip in the kernel, if not
> already supported by the kernel. This driver work, if needed, is done
> whether or not one chooses to use lm-sensors, correct?
>

Correct, in the end you will always need some code to talk to the IC's

> - The libsensors library makes things easier by offering an interface
> for apps to access chip readings, configure them and convert them to
> real-world values. It works in conjunction with the /etc/sensors.conf fil=
e.
>
> o Is libsensors part of lm-sensors or are they developed and retrieved
> independently?
>

libsensors is part of lm_sensors, one could even argue that libsensors *is*
what lm_sensors is all about, and that the sensors application included
is an example application of how to use libsensors.

> o Is lm-sensors considered one of the =93apps=94 mentioned above that opt=
 to
> use libsensors to make things easier?
>

The sensors application which is part of lm_sensors (as is libsensors)
is one of the apps yes. And libsensors is not only about making things
easier, but also about providing a single unified interface that many
different applications can use, while having all the configuration data
(which pin is connected to what, what are the scaling factors if any) in
a central place for all of them, this is what /etc/sensors.conf is for.

> o Can I choose to write my own app to interface with libsensors and the
> hwmon chips?

Yes you can easily write your own app.

 > One of my colleagues asked =93why can=92t we simply read the
> chip registers with simple i2c calls over the bus?=94.
>

Sure you can do this, but the advantage of writing a proper driver and
then using libsensors is that your app becomes independent of the
IC's, so if you ever do another revision of the product, or a whole new
product you could reuse your application without needing to change it.
And chances are that if in the new product you choose already
supported IC'd, you don't need to write any driver code either.

> - I skimmed over the lm-sensors source code. I know that it was made
> generic. So, how does it know what chips it needs to monitor? I assume
> this is through the sensors.conf file. I=92m looking for the:
 > o lm-sensors source code that discovers the chips that it has (does it
 > read the sensors.conf file? Where is the lm-sensors code that does this?)
 >

libsensors will give you access to all hwmon IC's the kernel knows about,
all drivers which implement the hwmon interface register themselves as
being part of the hwmon class, you can find out which IC's you have
by looking under /sys/class/hwmon

Then it finds out what sort of inputs the IC has (and what sort of
settings (min / max limits for alarms, alarm, etc) by looking at the files
under /sys/class/hwmon/hwmon#/device, these files follow the hwmon
sysfs API which is documented in the kernel tree, you can find it
online here:
http://www.mjmwired.net/kernel/Documentation/hwmon/sysfs-interface

Only then it looks at sensors.conf, to see if there is anantry for the
IC it found and within that entry an entry for the input. If it finds such
an entry that can tell it 3 things.
1: This input should be ignored (in which case it will forget about the inp=
ut)
2: The label for the input (a pretty name to show for this)
3: A conversion formula to go from the raw pin measurement to what is actua=
lly
    being measured.

> o lm-sensors source code that utilizes the kernel drivers that sit in
> /drivers/hwmon directory. Could you point me to this code?
>

That code lives under the lib directory. But all it basically does is
read the files under /sys/class/hwmon/hwmon#/device, and when
a scaling formula is given in sensors.conf apply that and then return
the value.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
