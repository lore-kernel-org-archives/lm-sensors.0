From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Nov 2005 16:31:17 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <8MJ0kgmd.1131376709.6455980.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

On 2005-11-07, Mingkun Gu wrote:
> Thank you for your prompt reply. I am working on a project where a
> customized board sitting on the PCI slot. The board has a SMBus
> microcontroller which is used to control some external sensors and
> communicates with the ICH6 SMBus master controller on the host PC
> motherboard. I need to send SMBus request command packets to the
> microcontroller and receive SMBus response data packets from the micro
> which also generates an interrupt sometimes to request for immediate or
> urgent services.
>
> Do you have any suggestion on how to implement such an application?

For one thing, if you are dealing with events which require fast
reactions, it might be wiser to write a kernel driver than a user-space
application.

Second, as I said, the current i2c-i801 driver is not interrupt based. If
you need it to react fast, you will need to rewrite it in part to use
interrupts. If you do, you should get in touch with Mark M. Hoffman who
has been working on this some times ago.

The details depend on the exact hardware implementation. I have to admit
I am not really qualified to comment on interrupts, as I never had to
deal with these so far. Please note that the i2c core in Linux doesn't
support slave mode on masters at the moment. If this is something your
system needs, this will be a (serious) problem.

--
Jean Delvare
