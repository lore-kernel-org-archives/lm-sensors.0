From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 24 Mar 2010 15:51:51 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] [RFC] hwmon: f71882fg: Add watchdog
Message-Id: <20100324155151.2482952f@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100323141718.GA23172@salidar.me.mortis.eu>
	<1269385936-3440-1-git-send-email-me@mortis.eu>
	<1269385936-3440-2-git-send-email-me@mortis.eu>
	<1269385936-3440-3-git-send-email-me@mortis.eu>
	<1269385936-3440-4-git-send-email-me@mortis.eu>
	<4BA9CF57.4030504@redhat.com>
	<20100324093651.GG6368@salidar.me.mortis.eu>
	<4BA9EA5C.9060506@redhat.com>
	<20100324153550.GK6368@salidar.me.mortis.eu>
In-Reply-To: <20100324153550.GK6368@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

> hold on the SIO port range. This would thus interfere with the operation
> of the f71882fg driver. I.e. it would prevent the device probing stage
> from working, thus preventing it from loading *after* my in-development
> watchdog driver.

There are two ways to deal with that really

1. Add a multi-function driver - it finds the chip and claims the port
regions and then provides methods for locked access to them as well as
creating other device instances that the drivers map to (probably platform
devices ?) which in turn trigger the loading/binding of the relevant low
level devices.

2. Fix the kernel request_resource stuff to support a sleeping non
exclusive resource so request/free of regions can be used as a resource
semaphore by co-operative devices.

#2 is actually not hard but when I did the patch originally it then
wasn't needed by the driver I had in mind for other reasons.

See http://groups.google.com/group/linux.kernel/msg/1425fc2aad32e6ea

Maybe its worth resurrecting ?

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
