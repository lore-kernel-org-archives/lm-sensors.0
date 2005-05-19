From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040224004351.GB24487@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 21, 2004 at 10:26:31AM +0100, Jean Delvare wrote:
> > BTW, care to send me that sysfs change patch as I didn't see any
> > objections to the name change?
> 
> Which probably doesn't mean they all agree, but at least they won't
> possibly complain later ;)
> 
> Here it is. The associated libsensors patch is here:
> http://jdelvare.net1.nerim.net/sensors/libsensors-sysfs-names-1.diff
> (not applied yet, on purpose)
> 
> TESTERS WANTED!
> 
> Note that the documentation patch won't apply unless you have previously
> applied my previous documentation update.
> 
> Also note that this is only the first step of my plan. I know you like
> sliced patches ;) Second step coming soon.

Ok, I've applied this one, and the second patch to my trees.  I'll let
them show up in the next -mm release and if no complaints, I'll forward
them all on to Linus.

thanks a lot for doing all of this work.

greg k-h
