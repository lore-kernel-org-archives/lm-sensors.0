From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <20030821152332.GB2858@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 21, 2003 at 11:34:32AM +0200, Geert Uytterhoeven wrote:
> On Tue, 19 Aug 2003, Greg KH wrote:
> > On Sun, Aug 17, 2003 at 08:32:44PM +0200, Geert Uytterhoeven wrote:
> > > I'm porting i2c-hydra (which I wrote many years ago) to 2.6.0-test3 and am
> > > trying to test it. I want to probe for all i2c devices on my i2c bus, but
> > > sensors-detect doesn't work because /proc/bus/i2c is not there.
> > 
> > sensors-detect does not work on 2.6, sorry.  You have to poke around in
> > the sysfs tree by hand right now after loading the drivers by hand :)
> > 
> > > How do I probe for all i2c devices in 2.6.0-test3? Thanks!
> > 
> > I just load all of the drivers and see what happens :)
> 
> Hmm... And all I have on the i2c bus is the SPD EEPROMs on my SDRAM DIMMs.
> AFAIK there's no kernel `driver' for these?

There's one in my bk tree, but it's not "correct" and I haven't taken
the time to fix it up in order to get it into shape for submission to
the main kernel.

If you want, I can send a patch so you can test with.

thanks,

greg k-h
