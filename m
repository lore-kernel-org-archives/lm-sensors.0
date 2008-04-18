From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Apr 2008 15:52:22 +0000
Subject: Re: [lm-sensors] [PATCH] lm75: Fix lm75a detection
Message-Id: <20080418175222.2d62ac52@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161334.10533.laurentp@cse-semaphore.com>
In-Reply-To: <200804161334.10533.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Apr 2008 17:35:19 +0200, Laurent Pinchart wrote:
> Hi Jean,
> 
> On Friday 18 April 2008 16:10, Jean Delvare wrote:
> > Hello Laurent,
> > 
> > On Wed, 16 Apr 2008 13:34:09 +0200, Laurent Pinchart wrote:
> > > Philips LM75A temperature sensors don't pass the current detection check
> > > as they return 0xffff when reading unimplemented registers instead of the
> > > last read value. This patch modifies device detection to accept 0xffff as
> > > valid values when reading registers 0x04-0x07.
> > 
> > In fact almost no LM75 clone mimics the original behavior perfectly so
> > they all need to be forced with a module parameter at the moment. I
> > have always been reluctant to update the detection code to support them
> > all, as this would weaken it to a point where about any device at any
> > of the 8 supported I2C addresses would be picked.
> >
> > May I ask on which system you have the Philips LM75A chip? If that's an
> > embedded system where you will end up using the new-style lm75 driver,
> > then I'd rather focus on getting this new-style driver ready, instead
> > of updating the detection code.
> 
> This is indeed an embedded system. I'm fine with focussing on getting the
> new-style driver ready.
> 
> Do you have more comments on David's patches ? He mentionned receiving no 
> feedback on his smbalert# patch.

I didn't look at the updated patchset David sent 2 days ago yet. But anyway,
smbalert# support is unrelated to converting the lm75 driver to new-style.
What should get reviewed and integrated quickly are the 2 first patches of
the set. Please test them, and if you have time, please review them. I don't
know when I will have the time for that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
