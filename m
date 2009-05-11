From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 08:32:10 +0000
Subject: Re: [lm-sensors] [PATCH 8/8] sensord: Refactoring of rrdInit()
Message-Id: <20090511083209.GB5197@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075810.GI4734@ubuntu>
In-Reply-To: <20090406075810.GI4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 08, 2009 at 04:54:06PM +0200, Jean Delvare wrote:
> On Mon, 6 Apr 2009 09:58:10 +0200, Andre Prendel wrote:
> > Refactoring of the rrdInit() function.
> > 
> > * Fix deep indentation levels
> > * Return with unique error code (-1)
> > ---
> > 
> > rrd.c |   85 ++++++++++++++++++++++++++++++------------------------------------
> >  1 file changed, 39 insertions(+), 46 deletions(-)
> > 
> > --- quilt-sensors.orig/prog/sensord/rrd.c	2009-04-04 20:40:28.000000000 +0200
> > +++ quilt-sensors/prog/sensord/rrd.c	2009-04-04 23:17:17.000000000 +0200
> > @@ -242,58 +242,51 @@
> >  
> >  int rrdInit(void)
> >  {
> > -	int ret = 0;
> > +	int ret;
> >  	struct stat tmp;
> > +	char stepBuff[STEP_BUFF], rraBuff[RRA_BUFF];
> > +	int argc = 4, num;
> > +	const char *argv[6 + MAX_RRD_SENSORS] = {
> > +		"sensord", sensord_args.rrdFile, "-s", stepBuff
> > +	};
> >  
> >  	sensorLog(LOG_DEBUG, "sensor RRD init");
> > -	if (stat(sensord_args.rrdFile, &tmp)) {
> > -		if (errno = ENOENT) {
> > -			char stepBuff[STEP_BUFF], rraBuff[RRA_BUFF];
> > -			int argc = 4, num;
> > -			const char *argv[6 + MAX_RRD_SENSORS] = {
> > -				"sensord", sensord_args.rrdFile, "-s", stepBuff
> > -			};
> > -
> > -			sensorLog(LOG_INFO, "creating round robin database");
> > -			num = rrdGetSensors(argv + argc);
> > -			if (num = 0) {
> > -				sensorLog(LOG_ERR,
> > -					  "Error creating RRD: %s: %s",
> > -					  sensord_args.rrdFile,
> > -					  "No sensors detected");
> > -				ret = 2;
> > -			} else if (num < 0) {
> > -				ret = -num;
> > -			} else {
> > -				sprintf(stepBuff, "%d", sensord_args.rrdTime);
> > -				sprintf(rraBuff, "RRA:%s:%f:%d:%d",
> > -					sensord_args.rrdNoAverage ? "LAST" :
> > -					"AVERAGE",
> > -					0.5 /* fraction of non-unknown samples needed per entry */,
> > -					1 /* samples per entry */,
> > -					7 * 24 * 60 * 60 /
> > -					sensord_args.rrdTime /* 1 week */);
> > -
> > -				argc += num;
> > -				argv[argc ++] = rraBuff;
> > -				argv[argc] = NULL;
> > -				if ((ret = rrd_create(argc,
> > -						      (char **) /* WEAK */ argv))) {
> > -					sensorLog(LOG_ERR,
> > -						  "Error creating RRD file: %s: %s",
> > -						  sensord_args.rrdFile,
> > -						  rrd_get_error());
> > -				}
> > -			}
> > -		} else {
> > -			sensorLog(LOG_ERR, "Error stat()ing RRD: %s: %s",
> > -				  sensord_args.rrdFile, strerror(errno));
> > -			ret = 1;
> > +
> > +	/* Create RRD if it does not exist. */
> > +	ret = stat(sensord_args.rrdFile, &tmp);
> > +	if (ret = -1 && errno != ENOENT) {
> > +		sensorLog(LOG_ERR, "Could not stat rrd file: %s\n",
> > +			  sensord_args.rrdFile);
> > +		return -1;
> > +	} else if (errno = ENOENT) {
> 
> "else" after a return statement isn't that useful ;)
> 
> But more importantly, ret may be != -1 at this point, in which case you
> have no guarantee that errno is up-to-date. It could carry an old error
> value. The original code did handle this properly... at the price of an
> additional level of indentation. Doesn't look unfeasible though:
> 
> 	if (stat(sensord_args.rrdFile, &tmp)) {
> 		if (errno != ENOENT) {
> 			sensorLog(LOG_ERR, "Error stat()ing RRD: %s: %s",
> 				  sensord_args.rrdFile, strerror(errno));
> 			return -1;		
> 		}
> 
> 		sensorLog(LOG_INFO, "Creating round robin database");
> 		[etc.]
> 	}
> 

You're right and I'm an idiot :) How to write stupid conditions :)
Will be fixed in v2.

> > +		sensorLog(LOG_INFO, "Creating round robin database");
> > +
> > +		num = rrdGetSensors(argv + argc);
> > +		if (num < 1) {
> > +			sensorLog(LOG_ERR, "Error creating RRD: %s: %s",
> > +				  sensord_args.rrdFile, "No sensors detected");
> > +			return -1;
> > +		}
> > +
> > +		sprintf(stepBuff, "%d", sensord_args.rrdTime);
> > +		sprintf(rraBuff, "RRA:%s:%f:%d:%d",
> > +			sensord_args.rrdNoAverage ? "LAST" :"AVERAGE",
> > +			0.5, 1, 7 * 24 * 60 * 60 / sensord_args.rrdTime);
> > +
> > +		argc += num;
> > +		argv[argc++] = rraBuff;
> > +		argv[argc] = NULL;
> > +
> > +		ret = rrd_create(argc, (char**) argv);
> > +		if (ret = -1) {
> > +			sensorLog(LOG_ERR, "Error creating RRD file: %s: %s",
> > +				  sensord_args.rrdFile, rrd_get_error());
> > +			return -1;
> >  		}
> >  	}
> > -	sensorLog(LOG_DEBUG, "sensor RRD inited");
> >  
> > -	return ret;
> > +	sensorLog(LOG_DEBUG, "sensor RRD initialized");
> > +	return 0;
> >  }
> >  
> >  #define RRDCGI "/usr/bin/rrdcgi"
> 
> Other than that, your cleanup look reasonable.
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
