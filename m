From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0212181709390.25381-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Dec 2002, Mark Studebaker wrote:

> BTW, I want to make sure you've read the suggestions Dori Eldar made
> this summer, which I summarized in i2c/TODO. They're the ones marked
> "D.E.". If you have questions on those I may be able to help.

Here we go. In order of the TODO.

1. Timing considerations

Maximum of 50us SCL high, I quess this is an alternative for detecting
bus busy condition instead of Start-to-Stop. Sampling for 50us before
start is easier to achieve than sampling lines all the time for
Start/Stop. Neither was done by i2c-algo-bit, nor I have plans to do so.

With new driver these can be supported, if approriate capture/compare
unit is wired on the SCL line. In this case adapter code does not use
the provided inlines from i2c-algo-biths.h.


2. Arbitration

Without busy detection, no point for arbitration. The best we can do is
stop the message that already was corrupted if we notice difference in
set and get bus state. It is easy to change the recovery action from
Stop to release, if bus busy is detected.


Both issues can be ignored on a single-master system. One designing
multi-master bus system, really should use HW glue logic for SMBus
access anyway.


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
