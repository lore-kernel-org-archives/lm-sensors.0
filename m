From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 13 May 2009 16:16:51 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/7] sensord: Remove commandline
Message-Id: <20090513161651.GA17670@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160022.GB17530@ubuntu>
In-Reply-To: <20090511160022.GB17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 12, 2009 at 06:23:21PM +0200, Jean Delvare wrote:
> On Mon, 11 May 2009 18:00:23 +0200, Andre Prendel wrote:
> > Remove the hidden commandline interface of sensord.
> > 
> > Sensord can be invoked as an console application. Therefor a link
> > named sensors pointing to sensord is needed. That is very
> > intransparent and IMO useless. Printing sensor values to console is
> > done by the sensors tool.
> > 
> > Changes in v2:
> > 
> > Remove references to isDaemon.
> > Rename daemonShortOptions to shortOptions and daemonLongOptions to
> > longOptions.
> > Remove commandline flags doScan and doSet. They are needless without
> > the CLI.
> > Cleanup main().
> 
> Looks good to me.
> 
> > Jean, there is some more useless stuff after the removal of the CLI
> > (e.g. the DO_SET action in doChip). I would prefer first to get this
> > series applied and remove the remaining stuff in further patches. Is
> > this OK for you?
> 
> Yes, this is OK with me. Function setChips() can be killed too.

I've just applied the whole series.

Thanks,
Andre

> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
