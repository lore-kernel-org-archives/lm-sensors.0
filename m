From: thomas536@gmail.com (Thomas Garner)
Date: Fri, 09 Mar 2007 01:26:05 +0000
Subject: [lm-sensors] IT8726F support (was: mcp61 sensors support)
Message-Id: <9ef864c50703081726v7c1a4889va5bd0ae997eeacc6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070301075719.9e1c0127.khali@linux-fr.org>
In-Reply-To: <20070301075719.9e1c0127.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I will see what I can do about getting a comparison to the BIOS output.

I pasted in the one line from kern.log.  Was that what you were
looking for, or something else?

Thomas

> > [root at ns ~]# modprobe it87
> > [root at ns ~]# tail -n 1 /var/log/kern.log
> > Mar  7 21:55:48 ns kernel: it87: Found IT8726F chip at 0x290, revision 1

> Quoting myself:
> > > Recompile, test and report. The report should include the output of
> > > "sensors" and the message printed in the kernel logs when you loaded
> > > the it87 driver.
>
> You didn't report what was to be seen in the logs.

