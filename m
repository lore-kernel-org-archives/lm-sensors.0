From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 25 Jan 2011 15:53:01 +0000
Subject: Re: [lm-sensors] [PATCH] lis33: turn down the no IRQ message
Message-Id: <20110125155301.GA7863@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110125150910.18731.92369.stgit@bob.linux.org.uk>
In-Reply-To: <20110125150910.18731.92369.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 25, 2011 at 10:09:15AM -0500, Alan Cox wrote:
> From: Kalhan Trisal <kalhan.trisal@intel.com>
> 
> Turn down the no IRQ message - on some platforms that's a normal state of
> affairs.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Wondering - pr_err was too strong, but maybe pr_info would make sense
to inform the user that /dev/freefall won't work. Otherwise we may get
support requests with people complaining about it, and we won't be able
to see the reason.

Thoughts ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
