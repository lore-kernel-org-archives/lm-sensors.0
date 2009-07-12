From: "Tobias Hain" <tobias.hain@gmx.de>
Date: Sun, 12 Jul 2009 20:43:12 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <AB51281BB68441748DDC15B4A81B16F9@delline>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

> So while I wouldn't want to hide the hardware monitoring support
> of the VIA 686 in another driver, I would be totally fine with adding
> temperature reporting to whatever driver is already handling the Intel
> 965. At this point I still believe this is the way to go.

intel-agp.c contains the device ids for all intel host bridges. None of the
symbols (= device ids) intel-agp.c used has been exported to
include/linux/pci_ids.h and I guess there's a reason for this.

intel-agp.c has 2432 LOC and only deals with AGP/GART table management. I
don't think anybody would be amused to see other code in there. I don't see
other infrastructure in place (e.g. dispatchers) to management access from
multiple modules.

Do you have a successful example where temperature reading and evaluating is
done in an unrelated kernel module? To have a look at how they did it.

Thanks,
7oby


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
