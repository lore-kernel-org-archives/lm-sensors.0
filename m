From: Jarod Wilson <jarod@wilsonet.com>
Date: Fri, 15 Apr 2011 21:07:03 +0000
Subject: Re: [lm-sensors] [PATCH v6 0/2] Make all it87 drivers SMP safe
Message-Id: <25810A23-EB28-4FBF-8CEB-487313F0E16E@wilsonet.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302816996-6345-1-git-send-email-natg@google.com>
In-Reply-To: <1302816996-6345-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, =?iso-8859-1?Q?=22Juan_Jes=FAs_Garc=EDa_de_Soria=22?= <skandalfo@gmail.com>

On Apr 14, 2011, at 5:36 PM, Nat Gurumoorthy wrote:

> There are 3 different drivers that touch the it87 hardware registers.
> The 3 drivers have been written independently and access the it87 hardware
> registers assuming they are the only driver accessing it. This change
> attempts to serialize access to the hardware by using
> "request_muxed_region" macro defined by Alan Cox. Call to this macro
> will hold off the requestor if the resource is currently busy.
> The use of the above macro makes it possible to get rid of
> spinlocks in it8712f_wdt.c and it87_wdt.c watchdog drivers.
> This also greatly simplifies the implementation of it87_wdt.c driver.
>=20
> 01 - Changes to it87 watchdog driver to use "request_muxed_region"
> drivers/watchdog/it8712f_wdt.c
> drivers/watchdog/it87_wdt.c
>=20
> 02 - Chages to hwmon it87 driver to use "request_muxed_region"
> drivers/hwmon/it87.c
>=20
> drivers/hwmon/it87.c           |   30 +++++++++++++-
> drivers/watchdog/it8712f_wdt.c |   50 +++++++++++++++++++++---
> drivers/watchdog/it87_wdt.c    |   80 +++++++++++++++++++++--------------=
----
> 3 files changed, 113 insertions(+), 47 deletions(-)

FYI,

$ head -n 4 drivers/media/rc/ite-cir.c
/*
 * Driver for ITE Tech Inc. IT8712F/IT8512 CIR
 *
 * Copyright (C) 2010 Juan Jes=FAs Garc=EDa de Soria <skandalfo@gmail.com>


--=20
Jarod Wilson
jarod@wilsonet.com




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
