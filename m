From: klingler@newtec.de (klingler@newtec.de)
Date: Fri, 07 Oct 2005 08:21:05 +0000
Subject: [lm-sensors] Ticket #2030
Message-Id: <70FE8182C709BD4F93E33B638E00F463077555@merkur.newtec.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

I have some news regarding the Ticket #2030. You may want to add this
information to the ticket.

Fe found out that it seems to be a hardware bug in the ali15x3 chip. The
chip needs a reset when it falls into blocking state. However, the reset
mechanism currently implemented in the ali15x3 driver does not work since
the chip does not turn to busy state and keeps idle in our case. We changed
the driver and now we do a reset when we detect the timeout condition. This
works fine.

Kind regards,
Claudio Klingler

