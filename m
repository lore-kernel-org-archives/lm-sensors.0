From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 13 Apr 2011 08:05:33 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTikfuvvujTi6i2MUGOHgNLZCqcouJQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<4DA547CD.60406@redhat.com>
In-Reply-To: <4DA547CD.60406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Mike Waychison <mikew@google.com>

Hans,
      Comments below

On Tue, Apr 12, 2011 at 11:50 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>
> You shouldn't (void) this, there is a reason you get a warning
> otherwise! request_muxed_region can still fail if some other driver
> has done a none muxed request_region on the same region, and in that
> case you should not continue with accessing the io-ports.
There are 3 it87 drivers and they all have to do the exact same
sequence to put the chip into a mode where they can modify its state.
The sequences involve non atomic sequences that write locations 0x2e
and 0x2f. When they are done they write a different sequence to these
2 locations. The entry routine is superio_enter and exit is
superio_exit. All the it87 drivers reserve these 2 locations before
they start manipulating the chip. This macro will hold off requestors
if the resource is busy because one of the other drivers is
manipulating the chip. Once the  an it87 driver is done it calls
superio_exit which will release the reservation on those 2 locations
letting any other driver on the wait queue to now gain access two
locations.

Please read code in kernel/resource.c function "__request_region".
"request_muxed_region" turns on IORESOURCE_MUXED bit and that means
that only  way an it87 driver will get back from a call to
"request_muxed_region" is when it gets hold of the region.

The scenario you mention above can never happen.

Regards
Nat


>
> Regards,
>
> Hans
>



-- 
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
