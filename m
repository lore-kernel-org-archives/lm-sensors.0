From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: adm9240.c review
Message-Id: <20040814204912.GA4155@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040812194946.721317b0.khali@linux-fr.org>
In-Reply-To: <20040812194946.721317b0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 14, 2004 at 10:12:09PM +0200, Jean Delvare wrote:
> > > >     Copyright (c) 1999  Frodo Looijaard <frodol@dds.nl>
> > > >     and Philip Edelbrock <phil@netroedge.com>
> > > > 
> > > >     Copyright (c) 2003 Michiel Rook <michiel@grendelproject.nl>   
> > > >     
> > > 
> > > Copyright is (C), not (c).
> > 
> > No it isn't.  Or so says the copyright lawyers at my employeer :)
> 
> Huh?
> 
> http://archives.andrew.net.au/lm-sensors/msg04630.html
> 
> There you said:
> 
> > + * Copyright (c) 2003  Jean Delvare <khali@xxxxxxxxxxxx>
>                  ^- should be "(C)" to be legal.  So says the lawyers
> 		 who know these things.
> 
> Which is why this "conversion" is part of my chip driver porting guide
> (Documentation/i2c/porting-clients).
> 
> Have lawyers changed their minds in the meantime, or am I missing
> something?

Oh crap.  Now I'm going to have to go track down the document that told
me all about this at work, gee thanks :)

Anyway, it'll be a week or so before I make it back into the office, so
just do whichever you want in the meantime, I don't care...

thanks,

greg k-h
