From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Mar 2009 13:13:17 +0000
Subject: Re: [lm-sensors] lm_sensors help
Message-Id: <20090310141317.2777c7c6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <622d3d2b0903090451v50a8614bjed6e5ba66cafebdd@mail.gmail.com>
In-Reply-To: <622d3d2b0903090451v50a8614bjed6e5ba66cafebdd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 9 Mar 2009 15:57:36 +0100, Csapl=E1r Zolt=E1n wrote:
> Thank you for your quick answer. Unfortunately, it maybe happen, that I
> cannot find the right information at first sight because of the language
> problems, so, please, forgive it to me. Could you send me a specific
> example to the below mentioned own-made sensors.d?

For clarity: I said a configuration file to put _into_
directory /etc/sensors.d. It's a new feature in lm-sensors 3.1 that you
can put additional custom configuration files in this directory.

> There is a
> it8712-isa-0290 chip on my motherboard, but it would be also useful a conf
> file made to another type because I could conclude to the way of the
> transcription from that.

No, a configuration example for another chip on a different motherboard
wouldn't help you at all. Chip configuration is motherboard-specific.
And if you really want this, well, etc/sensors.conf.eg is full of this,
so you can just look there. At this point you still didn't tell us what
brand and model your motherboard was, so we can't even give any advice.

In the absence of additional information, the only thing I can suggest
is to try a configuration file which corresponds to the default wiring
of the ITE IT8712F Super-I/O chip. This is what the chip "it8712-*"
section in etc/sensors.conf.eg is all about. So, you could copy that
section (from chip "it8712f-*" to the following chip statement) from
etc/sensors.conf.eg and copy it into, for
example, /etc/sensors.d/it8712.

If we knew which motherboard you have, we could check if we already
have a suitable configuration file for it. We don't have that many
configuration files, but you may be lucky. Or we may have a
configuration file for a similar board from the same vendor, which
would be a better starting point than the default section.

Writing a custom, perfect configuration file for a specific motherboard
can be very difficult and time consuming. This isn't something I am
willing to do for free for people I don't know. I intend to write a
guide on how to do this but didn't have the time to do it yet.

> As well as, do you know an other command for linux except of sensors to l=
et
> me know the chip (e.g. it8712-isa-0290) of my PC?

There are several commands listing the hardware included in your PC, as
well a graphical front-ends. That's not exactly on-topic here and I
don't mean to give you an exhaustive list, but to list the ones I know
and use frequently:
* "lspci" will list all the PCI devices on your system.
* "lsusb" will list all the USB devices on your system.
* "dmidecode" will list many information about your hardware as encoded
  in the SMBIOS/DMI table in your BIOS.
* "hwinfo" (at least on Suse Linux) will list a lot of information about
  your system.
* There's also a tool names "lshw" which tries to gather as much
  information as possible, but I'm not sure about its status and
  availability in distributions.
* I think both KDE and Gnome come with an applet which displays
  hardware information.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
