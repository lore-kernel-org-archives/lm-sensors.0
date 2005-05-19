From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: prog/init/lm_sensors.init: reduce verbosity, MAKEDEV, usage and
Message-Id: <20041207123418.GE32541@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Tue, Dec 07, 2004 at 10:17:20AM +0100, Jean Delvare wrote:
> > the attached patch is partly including some patching by Red Hat, which
> > are distribution independent.
> >
> > It exits early on absence of config files, or empty config files (no
> > MODULE_* entries) to avoid noise at startup of lm_sensors unconfigured
> > systems.
> 
> Sounds sane to me.
> 
> > There is also a MAKEDEV in the start command. This may be required for
> > proper udev operation.
> 
> Doesn't sound good to me. For one thing not all systems may have
> /sbin/MAKEDEV, for another what is fine for udev might not be fine for
> devfs or static /dev systems. Also, I thought that udev was totally
> dynamic so I don't understand why we would have to create the device
> files.

I've tested this and the devices do not get created. Do the i2c
modules create hotplug events for udev to pick them up? Or perhaps
there are udev rules required for i2c modules. Running sensors-detect
does creates /dev/i2c-0.

> Last, /dev/i2c* files are not needed for proper operation of the
> hardware monitoring modules, only for sensors-detect and dump tools.

It would be nicer to have the modules advertise their /dev interfaces,
so other tools can see them. Otherwise each tools would haveto
generate the /dev entries itself.

>  CONFIG=/etc/sysconfig/lm_sensors
> +[ -r "$CONFIG" ] || exit 0
> +egrep '^MODULE_' $CONFIG &>/dev/null || exit 0
> 
> Why egrep and not simply grep?

Taken over w/o much though, grep would be fine.

> I'd also suggest -q instead of &>/dev/null.

Best would be

grep '^MODULE_' $CONFIG >/dev/null 2>&1

From grep's doc:
> Portability note: unlike GNU `grep', traditional `grep' did not
> conform to POSIX.2, because traditional `grep' lacked a `-q' option
> and its `-s' option behaved like GNU `grep''s `-q' option.  Shell
> scripts intended to be portable to traditional `grep' should avoid
> both `-q' and `-s' and should redirect output to `/dev/null'
> instead.

> BTW, what's the difference between ">" and "&>"? The latter is not
> documented in my sh man page (">&" is).

It's bash's shortcut version of 2>&1, I think. Better have the sh
version as above.

> -	echo -n $"Starting up sensors: "
> -	test -r "$CONFIG" && . "$CONFIG"
> +	echo -n $"Starting $prog: starting module "
> 
> What is the leading $ for, BTW?

Bash's "locale-specific translation of the characters between the
double quotes".

> >From a technical point of view, we are not starting modules, but loading
> them.
> 
> -		echo starting module __${module}__
> +		echo -n "__${module}__ "
> 
> Do we need these extra underscores at all? Looks ugly IMHO.

I'd also like to remove them.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041207/0dde7915/attachment.bin
