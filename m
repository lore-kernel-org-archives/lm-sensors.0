From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 11:43:04 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070624134304.215f7e43@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 19 Jun 2007 08:27:32 -0400, Mark M. Hoffman wrote:
> Elsewhere in this thread... I agree with Jean that pulling a new config file
> for a new board will get support to people w/ new boards more quickly.  Not
> all distros update as frequently as Fedora.  This would require the driver
> to go ahead and create all possible sysfs files in case it didn't recognzize
> the board, and let userspace sort it out.  (...)

Err, no, even me wouldn't like it. If we were to handle unknown
versions, my proposal was module parameters letting the user decide
which channels should be created. I never proposed to create all the
sysfs files.

> Nonetheless, I'm still OK w/ Hans' approach here, because ultimately he is
> going to be the one maintaining it.  And really, kernel code is not written
> on stone.  If it becomes clear that this approach sucks, we'll change it.

Fine with me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
