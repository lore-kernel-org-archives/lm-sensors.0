From: Frank Schaefer <kelledin@gmail.com>
Date: Mon, 17 Aug 2015 03:57:52 +0000
Subject: Re: [lm-sensors] [PATCH] Support for Enermax DigiFanless 550W PSU
Message-Id: <CAF=9fWvsc-U+14F8aWRmweyeEzpMLjaaT6ym4bCQKn3jtO0XMw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF=9fWv3JY_ejXwa9Z93YYnbEOXQjgt-xh60nT4GySwMY7b-yA@mail.gmail.com>
In-Reply-To: <CAF=9fWv3JY_ejXwa9Z93YYnbEOXQjgt-xh60nT4GySwMY7b-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Regarding the placement of the driver, I'm actually kind of torn on
this myself.  Mainly because the driver includes hid-ids.h, which for
some reason resides in drivers/hid instead of the more logical
include/linux.  I could obviously move things around and still include
it as "../hid/hid-ids.h", although that feels wrong as well.

I can do whichever you feel is the lesser of two evils; in the
meantime, I'll focus on cleaning up and re-testing the code.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
