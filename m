From: Greg KH <greg@kroah.com>
Date: Sun, 09 Sep 2007 21:12:56 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/firmware: const-ify DMI API and
Message-Id: <20070909211256.GB6310@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070901142719.GA31990@havoc.gtf.org> <20070901153644.GA530@kroah.com> <46D98CD0.9040206@garzik.org> <20070909175142.GB32447@kroah.com> <20070909202442.GA21086@uranus.ravnborg.org>
In-Reply-To: <20070909202442.GA21086@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, ak@suse.de, len.brown@intel.com, linux-ide@vger.kernel.org, dz@debian.org, minyard@acm.org, j.w.r.degoede@hhs.nl, lm-sensors@lm-sensors.org, rlove@rlove.org, bzolnier@gmail.com, dmitry.torokhov@gmail.com, mzxreary@0pointer.de, stelian@popies.net, ibm-acpi@hmh.eng.br, ambx1@neo.rr.com, gimli@dark-green.com

On Sun, Sep 09, 2007 at 10:24:42PM +0200, Sam Ravnborg wrote:
> > >
> > > I was just going to push it myself, but have no strong feelings on the 
> > > matter.
> > 
> > Ok, you can push it, that's fine with me.  Feel free to add my:
> > 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > if you want.
> That should be "Acked-by:" since the patch does not pass via you but you
> acknowledge it is OK by your Ack.

Well, as I am the maintainer for that subsystem, and I did review the
patch and it looks good, that is a bit more than just an "ack" :)

But whatever you want, I'm not going to get technical here with
"reviewed-by" and such right now...

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
