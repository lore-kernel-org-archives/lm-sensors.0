From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: I2C patch for Linux 2.4
Message-Id: <20030718232005.GH1583@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030712095859.64d3cefa.khali@linux-fr.org>
In-Reply-To: <20030712095859.64d3cefa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 18, 2003 at 08:13:27AM +0200, Jean Delvare wrote:
> 
> 
> > > > Individual diffs are good.  In an incremental fashion is even
> > > > better(this one fixes up the core files to match cvs, this one
> > > > adds one driver, etc...)
> > > 
> > > OK, let's go.
> > 
> > At first glance, this looks really good.
> 
> Note however that what I sent was build against i2c-CVS, not i2c-2.8.0
> yet (I mean, the core patch). And Linux 2.4.21-bk will evolve by the
> time we really submit a patch. So I will regenerate the patch when you
> are ready.
> 
> > But I'm strapped for time, trying to finish up stuff in time for OLS
> > and the kernel summit next week, so I'm not going to have a chance to
> > really look at it for about a week or so.
> > 
> > It's in my todo box, so I will get too it, sorry for the delay...
> 
> No problem. I was just astonished because you seemed to think it was
> kind of urgent, and then no more answer. But I know we all have many
> many things to do and we have to choose priorities. That's life! As long
> as I did not work for nothing, it's OK.

It's not for nothing.  The speed of the 2.4.22-pre development tree just
supprised me, so we've missed this window.  We should aim for
2.4.23-pre1, sound ok?

thanks,

greg k-h
