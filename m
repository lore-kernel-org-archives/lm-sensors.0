From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 20 Aug 2007 17:53:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820175308.GB4603@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Aug 2007, Jean Delvare wrote:
> For Core thermal sensors, admittedly, the coretemp-isa-0000 name has no
> physical sense. This is the exact same "problem" as for the thinkpad
> driver, with the exception that there can actually be more than one
> Core temperature sensor, so we use the "ISA address" to distinguish
> between them.
> 
> > I'm glat to know it is only a mostly cosmetic thing, but still, if it is not
> > too painful to fix...
> 
> Actually, this isn't trivial. To build a chip name, libsensors uses the
> device's subsystem in sysfs. i2c -> i2c, pci -> pci, platform -> isa.
> "Host" sensors are implemented as platform drivers, and this is the
> reason why libsensors names them foo-isa-0000. So having libsensors

Is there a good reason why we couldn't rename the "isa" bus to "platform",
then?  It is far more correct to call every hwmon ISA device a platform
device, than to call every platform device an ISA device :p

> a problem. BTW, most "ISA" hardware monitoring chips these days are
> actually connected through the LPC bus and not the ISA bus, but we
> have been reporting all of them as isa because it's more simple that
> way.

It is just cosmetics, indeed.  But still, it is the right time to ask about
it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
