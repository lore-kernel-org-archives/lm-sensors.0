From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 09 Mar 2009 11:31:49 +0000
Subject: Re: [lm-sensors] [PATCH 6/7] sensord: Coding style conversion (gnu
Message-Id: <20090309113149.GI4636@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090309084612.GG4636@ubuntu>
In-Reply-To: <20090309084612.GG4636@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 09, 2009 at 11:22:45AM +0100, Jean Delvare wrote:
> On Mon, 9 Mar 2009 09:46:12 +0100, Andre Prendel wrote:
> > Fix coding style in sensord.c
> > (...)
> > +static void daemonize(void)
> > +{
> > +	int pid;
> > +	struct stat fileStat;
> > +	FILE *file;
> > +
> > +	if (chdir("/") < 0) {
> > +		perror("chdir()");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	if (!(stat(pidFile, &fileStat)) &&
> > +	    ((!S_ISREG(fileStat.st_mode)) || (fileStat.st_size > 11))) {
> > +		fprintf(stderr,
> > +			"Error: PID file `%s' already exists and looks suspicious.\n",
> > +			pidFile);
> > +		exit(EXIT_FAILURE);
> > +	}
> >   
> 
> Trailing white space, could be stripped (and a few other occurrences in
> this file.)

You're right. Strange, quilt complains about that whitespaces in all
the other patches except that one. I switched on support in emacs to
find the occurrences and fixed it.

> 
> > -  if (!(file = fopen (pidFile, "w"))) {
> > -    fprintf (stderr, "fopen(\"%s\"): %s\n", pidFile, strerror (errno));
> > -    exit (EXIT_FAILURE);
> > -  }
> 
> -- 
> Jean Delvare

Thanks
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
