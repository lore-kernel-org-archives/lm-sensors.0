From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] prog/init/lm_sensors.init: reduce verbosity, MAKEDEV,
Message-Id: <y3iACT1P.1102411040.6379070.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041207014837.GC23447@neu.nirvana>
In-Reply-To: <20041207014837.GC23447@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Axel,

> the attached patch is partly including some patching by Red Hat, which
> are distribution independent.
>
> It exits early on absence of config files, or empty config files (no
> MODULE_* entries) to avoid noise at startup of lm_sensors unconfigured
> systems.

Sounds sane to me.

> There is also a MAKEDEV in the start command. This may be required for
> proper udev operation.

Doesn't sound good to me. For one thing not all systems may have
/sbin/MAKEDEV, for another what is fine for udev might not be fine for
devfs or static /dev systems. Also, I thought that udev was totally
dynamic so I don't understand why we would have to create the device
files. Last, /dev/i2c* files are not needed for proper operation of the
hardware monitoring modules, only for sensors-detect and dump tools.

> It also fixes a couple of minor other things like to output of the
> usage ($0 instead of fixed "sensors.init" etc).

Sounds fine.

More comments inline:

 CONFIG=/etc/sysconfig/lm_sensors
+[ -r "$CONFIG" ] || exit 0
+egrep '^MODULE_' $CONFIG &>/dev/null || exit 0

Why egrep and not simply grep? I'd also suggest -q instead of
&>/dev/null. BTW, what's the difference between ">" and "&>"? The
latter is not documented in my sh man page (">&" is).

-	echo -n $"Starting up sensors: "
-	test -r "$CONFIG" && . "$CONFIG"
+	echo -n $"Starting $prog: starting module "

What is the leading $ for, BTW?

From a technical point of view, we are not starting modules, but loading
them.

-		echo starting module __${module}__
+		echo -n "__${module}__ "

Do we need these extra underscores at all? Looks ugly IMHO.

Thanks,
--
Jean Delvare
