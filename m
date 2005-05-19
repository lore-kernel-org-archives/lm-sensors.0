From: bjarvis@astro.umn.edu (Ben Jarvis)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #774
Message-Id: <20011230201254.A11421@nexus.astro.umn.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's some more progress on ticket #774.

I put in a different BIOS for the same board but an earlier revision.
The system then worked, except the CPU temp and System temp lines were
missing in the BIOS.  I figured this was because it was an older
version, so I downloaded the latest BIOS image and flashed it.
The flash worked, but afterwards the system wouldn't post again.

Maybe the old revision of the BIOS worked *because* it wasn't finding
the chips responsible for the CPU and system temps?  Maybe they were
somehow screwed up by the lm-sensors install..  The Fan RPMs and power
supply voltages were reporting correctly.

At least I have a way to get my board working now, sans the CPU/MB.
temps.  I'm hestitant to fiddle with it anymore, though, since I don't
have any more BIOS chips with the working BIOS revision on them, and no
flash prom writer. :)

Ben
