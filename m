From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 20 Aug 2007 11:53:30 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820115330.GA20057@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 19 Aug 2007, Henrique de Moraes Holschuh wrote:
> On Sun, 19 Aug 2007, Jean Delvare wrote:
> > Basically, two changes: add a "name" attribute to the device, and give
> > the platform device an instance number.
> > 
> > The name attribute is needed and must be added to the thinkpad_acpi
> > driver now, otherwise it won't work with libsensors (neither current nor
> > libsensors4). This is where libsensors gets the "prefix" part of a
> > chip name.
> 
> I will bake up a patch and send it for inclusion in 2.6.23-rc ASAP. If Len
> and Linus will take it (they should, it is an obviously safe thing that
> affects one driver only...).

Ok, I have one tentative patch ready, but I better make sure I got it right
on the first try.

First, is the "name" attribute documented anywhere?  I may have to change
its contents later, if I break up thinkpad-acpi into various modules.  Does
anything else other than libsensors4 uses it?

To avoid changing the contents of the "name" attribute, I'd have to create a
second platform device and dedicate it to hwmon (and name it
"thinkpad-sensors").  This is NOT a problem, but I am unsure if such a
change would be accepted in-tree this late in the game.  I will probably try
it anyway, at least it is future-proof.  It is probably safer to defer
thinkpad-acpi libsensors4 support to 2.6.24 if the change is not accepted
for -rc4.

Second, the libsensors configuration for thinkpad-acpi depends on the
thinkpad model.  I *can* export its model to libsensors4 (I have that
information), but how do I go about it?

See, that's why I'd really like BUS_HOST.  Unlike ISA which has port
numbers, or PCI, which has PCI-IDs, BUS_HOST is suitable to model and
version numbers as a way to differentiate various devices.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
