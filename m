From: arvidjaar@mail.ru (Andrey Borzenkov)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: [PATCH 2.6] Fix conversion from milli volts in store_in_reg() for
Message-Id: <200309071941.30338.arvidjaar@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED8067E.1050503@paradyne.com> <20030616184149.GC25585@kroah.com> <1062622452.5275.38.camel@nosferatu.lan>
In-Reply-To: <1062622452.5275.38.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: azarah@gentoo.org, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

On Thursday 04 September 2003 00:54, Martin Schlemmer wrote:
[...]
> nosferatu patch # echo '3700' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
[...]
> I think Andrey also noticed this (if I did not smoke too much Weedbix
> this morning ;) - if so, please verify that this fixes it ... it does
> here at least.
>

yes, it has fixed it. thank you

-andrey
