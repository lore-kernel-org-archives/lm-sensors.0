From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 18:56:08 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <20080219195608.701cd2fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

On Tue, 19 Feb 2008 11:49:15 -0700, Jordan Crouse wrote:
> On 18/02/08 20:54 +0100, Jean Delvare wrote:
> > Hi Hans,
> > 
> > On Wed, 13 Feb 2008 18:46:23 +0100, Hans de Goede wrote:
> > > Hi all,
> > > 
> > > Yesterday the store called me that my defective Asus M2N-SLI Deluxe has been 
> > > replaced by a new one. So I should be able to start working on the adt7475 
> > > driver again soon.
> > > 
> > > Is there any progress after Jordan Crouse latest patch:
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022338.html
> > > 
> > > ?
> > 
> > Not that I know of. You might want to update the wiki/Devices page to
> > record the current state so that you (and others) can look it up at a
> > later time.
> 
> There was one little buglet that needed to be fixed
> (I2C_DRIVERID_ADT74XX should be I2C_DRIVERID_ADT7475)

Best would be to get rid of it altogether. As you might have noticed,
all the hwmon driver IDs have be deleted by now:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h{501b1f53605bec17454dd8bbdbbf3f57a7cf32

> but by all reports, things were looking good.  I was actually getting ready
> to send the updated patch to Mark to start the trip upstream, but I'll
> hold off if you want to test some more.
> 
> I'll reply with an up-to-date version against HEAD.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
