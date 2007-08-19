From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sun, 19 Aug 2007 19:14:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070819191426.GA11390@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 19 Aug 2007, Jean Delvare wrote:
> Basically, two changes: add a "name" attribute to the device, and give
> the platform device an instance number.
> 
> The name attribute is needed and must be added to the thinkpad_acpi
> driver now, otherwise it won't work with libsensors (neither current nor
> libsensors4). This is where libsensors gets the "prefix" part of a
> chip name.

I will bake up a patch and send it for inclusion in 2.6.23-rc ASAP. If Len
and Linus will take it (they should, it is an obviously safe thing that
affects one driver only...).

> The instance number is required for now, this is where libsensors gets
> the "address" part of a chip name for platform devices. However, I
> admit that it's not ideal that you have to declare a fake instance
> number in the case of the thinkpad_acpi driver, as there can be only
> one device almost by definition. Ideally libsensors should default to
> address 0 for platform devices with no instance number. This should be
> addressed as part of:
> 
> http://www.lm-sensors.org/ticket/2240
> 
> But I didn't plan to fix this before 3.0.1. Maybe we can have a
> temporary workaround before that so that we don't have to hack the
> thinkpad_acpi driver.

Since this would probably hit problems in other drivers, I think a
work-around in libsensors is probably the best way to go about it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
