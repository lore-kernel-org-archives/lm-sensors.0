From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Sun, 08 May 2011 00:05:08 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110508000508.183B81A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 7 May 2011 13:47:21 +0200 Jean Delvare wrote:
> Hi Harry, Ric and Jeff,
> 
> On Thu, 05 May 2011 10:40:28 -0600, Harry G McGavran Jr wrote:
> > I can hope for an lm-sensors driver...
> 
> I found some time to work on EMC6W201 support and I have something for
> you to test. My standalone driver for this chip can be downloaded from:
>   http://khali.linux-fr.org/devel/misc/emc6w201/
> You only need i2c-compat.h for kernels <= 2.6.32. I build-tested the
> driver down to kernel 2.6.27, older kernels may or may not work.
> emc6w201.conf is a template configuration file, copy to /etc/sensors.d
> and add statements as needed. Generic build instructions are available
> at:
>   http://khali.linux-fr.org/devel/misc/INSTALL
> 
> At this point the driver only supports basic monitoring, in read-only
> mode. It seems to work reasonably well on the dumps sent by Harry and
> Jeff, but real hardware can behave differently.
> 
> Anyway, let me know how it goes.
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html

Hi Jean --

I spent a fair amount of time playing with the emc6w201 you mentioned
above.  I wanted to let you know that it seems to be working really
well.  It's an absolutely amazing relief to have this after all this time!

All the apps I've tried that depend on it seem to work fine.

For the time being I've left out emc6w201.conf from sensors.d
in case you do some more fine tuning of anything.

I have labels for temp1, temp5, and temp6; and fan1 and fan3
seem to be the fans that were reported by hddtemp.

Are you planning on any further changes?  If so, I'll wait
before putting my .conf file in sensors.d.

Thanks a bundle!

	Harry McGavran





-- 

Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
