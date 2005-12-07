From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Wed, 07 Dec 2005 08:20:41 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051207092041.2ffmutyauqcgo0c4@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan, Rudolf,

Quoting Ymu at Winbond.com.tw:

>> Is there a chance that you have test hardware available with the
>> w83792d chip where you could try to run the same commands that I did?
>>
> Yes, I have a board on hand; it's a C version chip.

Your chip seems to behave differently from mine, but then again it is has '12'
as revision ID where my chip has '13'. So I guess we still need to wait for
that updated datasheet to understand if there are programming differences.

Meanwhile, I wrote back to Gigabyte support and got a slightly better answer
this time...

Quoting Gigabyte support:

"Hi Daniel,

We are sorry for the late reply. Here are some of the answers from our R&D
department:

The interrupt pin of the W83792D is connected to one of the GPIO pin of south
bridge. And that GPIO can trigger SMI.

If the sensor limit interrupt enable bit is enabled and the sensor reading is
beyond its limit, the chip will assert the interrupt pin.

The BIOS logs the events and does fan controls based on the interrupts of
w83792. But BIOS always enables interrupt of W83792 even when miniBMC is
disabled because BIOS needs it for fan controls.

Attached a simple diagram to show you how the W83792D chip is connected 
to south
bridge.

Best regards,

GBT Tech Support"

The picture attached is a very simple drawing showing the south bridge in one
box and the w83792d in another box. There is one arrow from the south 
bridge to
the w83792d labelled "SMI bus" and the there is one arrow from the w83792d to
the south bridge labelled interrupt.

Does this provide any more insight? Could this be more of an issue with the
interrupt coming into the south bridge causing a hang since no code is
servicing that interrupt? I don't know the kernel that well to guess any
further though...

Regards
Daniel Nilsson

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


