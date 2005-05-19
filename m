From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: prog/init/lm_sensors.init: reduce verbosity, MAKEDEV, usage and
Message-Id: <20041209200412.5d98a3e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041207123418.GE32541@neu.nirvana>
In-Reply-To: <20041207123418.GE32541@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> I've tested this and the devices do not get created. Do the i2c
> modules create hotplug events for udev to pick them up? Or
> perhaps there are udev rules required for i2c modules.

Frankly I don't know how udev works, nor do I use it. I can't say.

> Running sensors-detect does creates /dev/i2c-0.

More likely, loading one i2c bus driver (and possibly i2c-dev) created
it.

> It would be nicer to have the modules advertise their /dev interfaces,
> so other tools can see them. Otherwise each tools would haveto
> generate the /dev entries itself.

This is how things work. Either there is a static /dev tree and files
are created once and for all, or devfs/udev are used and device files
should be created dynamically by either devfsd or udev. Thus I see no
room for the /sbin/MAKEDEV thing you found in Red Hat's init file.

> Best would be
> 
> grep '^MODULE_' $CONFIG >/dev/null 2>&1
> 
> From grep's doc:
> > Portability note: unlike GNU `grep', traditional `grep' did not
> > conform to POSIX.2, because traditional `grep' lacked a `-q' option
> > and its `-s' option behaved like GNU `grep''s `-q' option.  Shell
> > scripts intended to be portable to traditional `grep' should avoid
> > both `-q' and `-s' and should redirect output to `/dev/null'
> > instead.

Well, lm_sensors only works on Linux and Linux systems have GNU grep.
There is no portability issue that I can think of. Either will be fine
though, it doesn't really matter.

> > -	echo -n $"Starting up sensors: "
> > -	test -r "$CONFIG" && . "$CONFIG"
> > +	echo -n $"Starting $prog: starting module "
> > 
> > What is the leading $ for, BTW?
> 
> Bash's "locale-specific translation of the characters between the
> double quotes".

But it's an sh script.

Please provide an updated version of your patch if you want us to apply
it.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
