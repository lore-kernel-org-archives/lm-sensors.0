From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 14:55:51 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <20090114155551.5bc3791d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Malcolm,

On Wed, 14 Jan 2009 11:50:33 -0000, Crossley, Malcolm (GE EntSol, Intelligent Platforms) wrote:
> Jean Delvare wrote:
> > I beg to disagree. The lm90 driver already supports a lot of
> > different devices. The ADT7481 differs in a significant way in that
> > it supports an additional external sensor. This is probably the right
> > time to start a new driver. Then maybe the support for the ADT7461
> > can be moved to this new driver so that the lm90 driver can be
> > simplified a bit.  
>    
> I attempted to modify the lm90 driver and discovered that fairly 
> invasive changes were required to support a larger driver structure for
> storing the sensors values.
> 
> I would not move the ADT7461 into a driver for the ADT7481 because the
> structure would differ as above ( structure for 2 channel device vs 3 
> channel device) and the registers for device detection are in different
> locations.

The larger structure isn't such a big problem. It is perfectly OK to
use the larger structure for all devices, we do that all the time. The
difference isn't that much anyway, we are speaking of a few dozen bytes
here.

The different identification registers aren't necessarily a blocking
factor either. My main motivation for proposing to move ADT7461 support
is that there are a lot of data->kind = adt7461 conditionals in the
lm90 driver at the moment, which would go away with the ADT7461 support.

But anyway this can be revisited later, if it happens it doesn't have
to happen at the same time as adding support for the ADT7481, which is
your primary goal.

> I have created a separate ADT7481 driver based upon the LM90 structure.
> It's still needs a clean up but it's been tested and it has PEC support
> included (full PEC support not the half adm1032 support).

Ah, if the PEC support is better it's good news. The ADM1032
implementation was really a pain :( If I had not needed it to test the
i2c-core part, I would probably never have implemented it.

> > Can you please also send us a patch against the latest version of
> > sensors-detect, adding detection of the ADT7481?
> 
> Unfortunately I can only use Outlook at work currently and so it will
> be difficult to send patches to mailing lists without breaking them. I 
> have a colleague(Martyn Welch) with a better email setup who can send
> patches on my behalf. I am working towards a better email setup but it
> will take some weeks (IT issues).

Outlook isn't so bad that it would screw patches even sent as
attachments, would it? Oh well, maybe... But of course if Martyn sends
the patches that's fine with us.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
