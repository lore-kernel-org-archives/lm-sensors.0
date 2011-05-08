From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 May 2011 09:25:07 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110508112507.63f6b398@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harry,

On Sat, 07 May 2011 18:05:08 -0600, Harry G McGavran Jr wrote:
> On Sat, 7 May 2011 13:47:21 +0200 Jean Delvare wrote:
> > I found some time to work on EMC6W201 support and I have something for
> > you to test. My standalone driver for this chip can be downloaded from:
> >   http://khali.linux-fr.org/devel/misc/emc6w201/
> > You only need i2c-compat.h for kernels <= 2.6.32. I build-tested the
> > driver down to kernel 2.6.27, older kernels may or may not work.
> > emc6w201.conf is a template configuration file, copy to /etc/sensors.d
> > and add statements as needed. Generic build instructions are available
> > at:
> >   http://khali.linux-fr.org/devel/misc/INSTALL
> > 
> > At this point the driver only supports basic monitoring, in read-only
> > mode. It seems to work reasonably well on the dumps sent by Harry and
> > Jeff, but real hardware can behave differently.
> > 
> > Anyway, let me know how it goes.
> 
> I spent a fair amount of time playing with the emc6w201 you mentioned
> above.  I wanted to let you know that it seems to be working really
> well.  It's an absolutely amazing relief to have this after all this time!
> 
> All the apps I've tried that depend on it seem to work fine.

Great :)

> For the time being I've left out emc6w201.conf from sensors.d
> in case you do some more fine tuning of anything.
>
> I have labels for temp1, temp5, and temp6; and fan1 and fan3
> seem to be the fans that were reported by hddtemp.

I guess you mean i8k, not hddtemp. And yes, I agree, see my warning in
a previous reply.

If/when you have a good configuration file for your system, please
share it and I'll put it on the wiki.

> Are you planning on any further changes?  If so, I'll wait
> before putting my .conf file in sensors.d.

Further possible improvements to the driver would be extra features
(e.g. temperature offsets, alarm bits, maybe fan control.) The
monitoring part should be as good as we can get already, so I don't
expect any change that would cause incompatibilities in the
configuration file.

BTW, you can test your configuration file with "sensors -c" first, and
only copy it to /etc/sensors.d/ when you're happy with the results.
This avoids doing the tuning work as root.

> Thanks a bundle!

You're welcome. Wish list below - hint hint ;)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
