From: Andre Prendel <andre_prendel@gmx.de>
Date: Wed, 18 Feb 2009 11:11:45 +0000
Subject: Re: [lm-sensors] [Patch] libsensors: Fix wrong behaviour in
Message-Id: <20090218111145.GB4230@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090218082008.GA4230@ubuntu>
In-Reply-To: <20090218082008.GA4230@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 18, 2009 at 11:04:12AM +0100, Jean Delvare wrote:
> Hi Andre,

Hi Jean!
> 
> On Wed, 18 Feb 2009 09:20:08 +0100, Andre Prendel wrote:
> > The support for multiple configuration files causes a fatal error if
> > /etc/sensors.d does not exist.
> > 
> > That shouldn't be treated as an error. This patch fixes that.
> 
> You are perfectly right, what you propose is how I intended to
> implement the thing but apparently there was a loss of signal between
> the idea and its implementation.

I know this problem. :)
> 
> > --- lm-sensors-dev/lib/init.c	2009-02-16 14:12:50.000000000 +0100
> > +++ my-sensors/lib/init.c	2009-02-17 23:15:46.000000000 +0100
> > @@ -124,10 +124,15 @@ static int add_config_from_dir(const cha
> >  	struct dirent **namelist;
> >  
> >  	count = scandir(dir, &namelist, config_file_filter, alphasort);
> > +	/* Do not return an error if directory does not exist or is empty. */
> >  	if (count < 0) {
> > +		if (errno = ENOENT)
> > +			return 0;
> > +		
> 
> I'm applying this right now.
> 
> >  		sensors_parse_error_wfn(strerror(errno), NULL, 0);
> >  		return -SENSORS_ERR_PARSE;
> > -	}
> > +	} else if (!count)
> > +		return 0;
> 
> This second test doesn't seem needed, the following code is a no-op if
> count = 0, isn't it?

Yes it is. That's just my programming style. So you see at first view
what will happen if the directory is empty. You have not to examine the loop.

> 
> >  
> >  	for (res = 0, i = 0; !res && i < count; i++) {
> >  		int len;
> 
> Thanks for your contribution!

Thanks
Andre

> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
