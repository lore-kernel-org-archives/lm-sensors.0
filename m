From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Feb 2011 13:08:14 +0000
Subject: Re: [lm-sensors] [PATCH] lm85: extend to support emc6d103 chips
Message-Id: <20110218130813.GA27225@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5E343702000078000329C1@vpn.id2.novell.com>
In-Reply-To: <4D5E343702000078000329C1@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 18, 2011 at 03:06:13AM -0500, Guenter Roeck wrote:
> Jan,
> 
> On Fri, Feb 18, 2011 at 02:56:23AM -0500, Jan Beulich wrote:
> > The interface is identical emc6d102, so all that needs to be added are
> > some definitions and their uses.
> > 
> > Registers apparently missing in emc6d103:A2 compared to emc6d103:A0,
> > emc6d103:A1, and emc6d102 (according to the data sheets), but used
> > unconditionally in the driver: 62[5:7], 6D[0:7], and 6E[0:7]. For that
> > reason, A2 stepping chips don't get enabled for the time being.
> > 
> > Signed-off-by: Jan Beulich <jbeulich@novell.com>
> > 
Applied. Added Cc: stable@kernel.org since it matches stable criteria.

sensors-detect update will follow.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
