From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Feb 2009 11:47:59 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] Read extra configuration files from
Message-Id: <20090213124759.08531b29@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090211175008.0f843712@hyperion.delvare>
In-Reply-To: <20090211175008.0f843712@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Thu, 12 Feb 2009 23:23:12 -0600 (CST), Matt Roberds wrote:
> On Wed, 11 Feb 2009, Jean Delvare wrote:
> > Read extra configuration files from /etc/sensors.d.
> 
> [...]
> > +static int add_config_from_dir(const char *dir)
> [...]
> > +	for (res = 0, i = 0; !res && i < count; i++) {
> > +		int len;
> > +		char path[16 + NAME_MAX];
> > +		FILE *input;
> > +
> > +		len = snprintf(path, sizeof(path), "%s/%s", dir,
> > +			       namelist[i]->d_name);
> > +		if (len < 0 || len >= (int)sizeof(path)) {
> > +			res = -SENSORS_ERR_PARSE;
> > +			continue;
> > +		}
> 
> This says that the maximum length of the path to the config files is 16
> characters?  Seems kind of short.  By default this will be
> "/etc/sensors.d/" which clocks in at 15 bytes.  If somebody wants to use
> (say) "/usr/local/etc/sensors.d/" they'll be out of luck.

Not really. There is no strong delimiter between the directory name and
the configuration file name, what is limited is the total length. If
the directory name is longer than 16 bytes then the configuration file
name has to be a bit shorter than NAME_MAX. I very much doubt this will
be a problem in practice. In your example above,
"/usr/local/etc/sensors.d/" is 25 bytes long, so there is still
NAME_MAX-10 (245) bytes available for the configuration file name. I
suspect this is way more than anyone will ever use. Even including the
full board manufacturer and model names in the configuration file name
is hardly going to exceed 50 characters.

So, I very much doubt it is a problem in practice. In fact I had even
started with just char path[NAME_MAX]. I added 16 later just for the
principle, even though I admit I shouldn't have hard-coded it.

> Maybe something like
> 
> char path[PATH_MAX + NAME_MAX];
> 
> would be better?

I don't know the exact semantics of PATH_MAX but I suspect it includes
all the directory names _and_ the file name, so adding MAX_NAME to it
doesn't make sense. But just char path[PATH_MAX] would probably be the
easiest and cleanest way. I'll do that.

> > +++ lm-sensors/lib/sensors.conf.5	2009-02-11 10:30:22.000000000 +0100
> [...]
> > +A directory where you can put additional libsensors configuration files.
> > +Files found in this directory will be processed in alphabetical order after
> > +the default configuration file. Files those name starts with a dot are
>                                            ^
> Spelling: "Files whose name starts"
> 
> > +++ lm-sensors/lib/libsensors.3	2009-02-11 10:29:09.000000000 +0100
> [...]
> > +A directory where you can put additional libsensors configuration files.
> > +Files found in this directory will be processed in alphabetical order after
> > +the default configuration file. Files those name starts with a dot are
>                                            ^
> Spelling: "Files whose name starts"

Ah, thanks for pointing it out. This one appears to be my preferred
spelling mistakes, I do it all the time :/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
