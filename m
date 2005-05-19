From: andrew.fowler@onlinehome.de (Andrew Fowler)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: FW:Update to ticket #882 - Please close - user error
Message-Id: <NEBBLDJIBMPGMPAKEEBKCEAHCIAA.andrew.fowler@onlinehome.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Another try ...

--- Had problems sending this the first time round ----

<sensors@stimpy.netroedge.com>:
Sorry, I wasn't able to establish an SMTP connection. (#4.4.1)
I'm not going to try again; this message has been in the queue too long.
--- snip ----

Ooops - Found the problem:

Located a mail somewhere on the site indicating that the CPU is sometimes
slowed by HW on overheating, so wnet about
trying to stop the alarms again and found the root cause:

my sensors.conf read (!WRONG!)       should have been (last element
inverted)
compute temp2 (@*2.3), 2.3/@         compute temp2 (@*2.3), @/2.3

This of course meant that I could not set temp2 limit which in turn meant
that alarm was on which resulted in
slow machine and flashing power LED (better than a bloody buzzer actually).

So, all in all just a user error.  Bet this is the first time you've had one
of them ;-)

Thanks,

Andy.







