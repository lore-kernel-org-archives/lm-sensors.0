From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Mar 2007 10:21:33 +0000
Subject: [lm-sensors] IT8726F support (was: mcp61 sensors support)
Message-Id: <20070309112133.dbb4632f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070301075719.9e1c0127.khali@linux-fr.org>
In-Reply-To: <20070301075719.9e1c0127.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Thu, 8 Mar 2007 20:26:05 -0500, Thomas Garner wrote:
> I will see what I can do about getting a comparison to the BIOS output.
> 
> I pasted in the one line from kern.log.  Was that what you were
> looking for, or something else?
> (...)
> > > Mar  7 21:55:48 ns kernel: it87: Found IT8726F chip at 0x290, revision 1

Ah sorry, I totally missed it. This is what I was after. Sometimes we
are able to guess some voltage labels from the devices configuration,
and that shows in the logs, but this doesn't appear to be your case, so
no luck.

-- 
Jean Delvare

