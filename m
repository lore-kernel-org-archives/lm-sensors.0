From: Andrey Repin <hell-for-yahoo@umail.ru>
Date: Thu, 28 Jun 2012 03:15:25 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <1744359228.20120628071525@mtu-net.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com>
In-Reply-To: <4FEA4C10.2060904@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings, Michael Zintakis!

> Initially, when the board is first powered up, all fans (all 3 of them)
> are at a standstill because the board temperature is low.

This SHOULD NOT be the case. Precisely because of the issue you've outlined
below:

> [...] due to the fact of the actual physical fan inertia (for a lack of
> better word), the fan does *not* start.

All fans SHOULD spin at some low rate to make the system work.
Alternatively, the BIOS may provide a kickstart, when there's rise of
temperature over certain threshold, like you did in your script.
I suggest you raise this issue with your board manufacturer.

P.S.
All capitalization in accordance with RFC#2119.


--
WBR,
Andrey Repin (hell-for-yahoo@umail.ru) 28.06.2012, <07:08>

Sorry for my terrible english...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
