From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 29 Jan 2009 11:12:28 +0000
Subject: Re: [lm-sensors] [Patch] libsensors: Introduce error string
Message-Id: <20090129111228.GD4410@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090129090945.GB4410@ubuntu>
In-Reply-To: <20090129090945.GB4410@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 29, 2009 at 10:57:03AM +0100, Jean Delvare wrote:
> Hi Andre,
> 
> On Thu, 29 Jan 2009 10:09:45 +0100, Andre Prendel wrote:
> > sensors_error() returns NULL if errnum is not valid. Returning
> > "Unknown error" in this case, makes output clearer than:
> > 
> > foo: (null)
> > 
> > and prevents error output/logging from segmentation faults.
> > 
> > What do you think?
> > 
> > Andre
> > 
> > Signed-off-by: Andre Prendel <andre_prendel@gmx.de>
> > ---
> > 
> > --- lm-sensors-dev/lib/error.c	2009-01-26 17:43:43.000000000 +0100
> > +++ my-lm-sensors/lib/error.c	2009-01-28 22:49:53.000000000 +0100
> > @@ -33,7 +33,7 @@ void (*sensors_fatal_error) (const char 
> >  						sensors_default_fatal_error;
> >  
> >  static const char *errorlist[] = {
> > -	/* Invalid error code    */ NULL,
> > +	/* Invalid error code    */ "Unknown error",
> >  	/* SENSORS_ERR_WILDCARDS */ "Wildcard found in chip name",
> >  	/* SENSORS_ERR_NO_ENTRY  */ "No such subfeature known",
> >  	/* SENSORS_ERR_ACCESS_R  */ "Can't read",
> 
> Out of curiosity: did you actually hit this problem in real life?

No, I didn't. It's just theoretical.
 
> I was about to say that the caller was supposed to check for NULL, but
> apparently neither sensors nor sensord nor even libsensors does, so...

IMO error reporting should be very stable. If the caller checks
return value carefully it's fine too. Fprintf() isn't a problem. But I
don't know what about vsnprintf(), syslog().

> I guess you're right, having an error string instead of NULL would be
> better. Actually that's what libsensors 2.x did, I can't remember why I
> changed that in 3.x:
> http://www.lm-sensors.org/changeset/4854
> 
> Probably I thought it was not supposed to happen, but I guess it may
> actually happen if mixing a recent application with an older version of
> libsensors.
> 
> So I am pretty much inclined to apply your patch.

Vous avez le choix. :)

Andre

> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
