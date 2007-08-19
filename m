From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sun, 19 Aug 2007 19:21:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070819192137.GB11390@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 19 Aug 2007, Jean Delvare wrote:
> Thanks for pointing this out, indeed we need to make sure that the new
> libsensors will work properly with the thinkpad_acpi driver and other
> similar drivers. However I do not think that we need a special bus type
> for these. The thinkpad_acpi driver instantiates a platform device (as
> you mentioned yourself), and platform drivers are covered by the "ISA"
> bus type in libsensors (for historical reasons mainly.)

This sounds a bit of an ugliness that might be best fixed, since it is a
rare time window where one can actually do those.  If it is not too painful,
why not add BUS_HOST to attach stuff that is not on PCI/PCIe, nor ISA, nor
I2C/SMBUS?

I mean, it is weird enough with ACPI, but there is also on-die sensors in
CPUs, and their ilk... and attaching those to BUS_ISA or BUS_PCI sounds like
something out of an acid trip IMHO, never mind that it would work just fine
(unlike most stuff that could come out of an acid trip, I suppose) :-)

I'm glat to know it is only a mostly cosmetic thing, but still, if it is not
too painful to fix...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
