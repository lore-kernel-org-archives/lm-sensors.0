From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: success report
Message-Id: <9KTumIkJ.1111597551.2298610.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0503222149001.27188@n952.dyndns.ws>
In-Reply-To: <Pine.LNX.4.62.0503222149001.27188@n952.dyndns.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

You shall not use the root account for non-adminiastrative tasks.

> Just a note of thanks for your effort.
> I've an Abit IC7-G that works like a charm.
> The VID lines on this particular motherboard
> appear to not be connected.

Thanks :')

What hardware monitoring chipset does the IC7-G have?

What makes you believe that the VID lines are not wired? Did you attept
to ask Abit about it?

> It seems that most of the chip drivers depend on the BIOS
> to perform setup functions.

Saying that most *recent* drivers do would be more correct. Older drivers
would tend to instead reset the chip and reconfigure it arbitrarily. We
convert them to be less agressive as time permits.

> Have you considered providing some means of performing chip setup in the
> configuration file? This would allow simple integration of off-board
> monitoring.

We did, and some drivers do provide module parameters to hint for a
specific chip configuration, but that's rather an exception than a
rule. Most drivers are mainly meant for motherboards, where the BIOS
should actually configure the chip properly. Providing a way to
arbitrarily reconfigure all features of all chips would be a huge work
(and a mess since all chips are really different when it comes to
reconfiguration), and would make the drivers significantly more complex.
End-users should never need to reconfigure their chips, except in the
off-board case. Providing easy ways for them to do would additionally
make BIOS makers confident that they can go on shipping buggy BIOSes,
and I don't want to push them in that direction. It would also make it
easy for users to break the configuration. My overall impression is that
the trouble would outcome the benefits by a large margin, which is why I
am advocating for drivers being made as simple as possible, and inviting
users to ask for a fixed BIOS where BIOSes are broken.

For people playing with off-board stuff, there are some tools that can be
used to reprogram the chips: i2cset and isaset. I would hope this is
sufficient.

Thanks,
--
Jean Delvare
