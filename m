From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 03 Jul 2014 13:55:47 +0000
Subject: Re: [lm-sensors] [PATCH] systemd units rework
Message-Id: <20140703155547.37b495b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jaromir,

Sorry for the late reply. I seem to recall we discussed this briefly
over IRC, but let me write down my updated views here so that the can be
discussed.

On Fri, 24 Jan 2014 08:56:16 -0500 (EST), Jaromir Capik wrote:
> The attached patch fixes several things our users complained about.

I get complaints on my side as well, that's even why I remembered this
old thread:
https://bugzilla.novell.com/show_bug.cgi?id=882719
https://bugzilla.novell.com/show_bug.cgi?id=882720

> The patch introduces 3 wrappers for the service files and example
> /etc/sysconfig/* configuration files
>=20
> The lm_sensors-modprobe*wrapper scriptlets change the way how
> the modprobe failures look like as the users had no idea that
> the failures are caused by missing configuration and that
> led to frequent bug reports. The wrapper checks whether the
> modprobe is called with any arguments and leaves a hint
> message when no modules are passed to the modprobe.

I see which problem you are trying to solve with that. However I do not
like wrappers much. One of the key design goals of systemd was to avoid
running scripts every now and then, because scripts are slow. I am not
necessarily a big fan of systemd, but if you switch to it, you have to
do it right, otherwise you get the pain without the benefits.

Also, some hwmon drivers are loaded automatically. At this time these
are mostly CPU and GPU sensors, but I hope that in the future some
mainboard sensors drivers can be loaded automatically too. This means
that running sensors-detect will become optional (it already is on some
machines, laptops in particular.) The lack of configuration file should
thus not be a problem and should not prevent the service from starting.
It should also not spam the logs forever, which your wrappers scripts
are doing.

My plan to solve this specific issue is to have sensors-detect write a
file to /etc/modules-load.d instead of /etc/sysconfig. Systemd has a
service to load modules, I want to use that instead of doing it on my
own. Then the lm_sensors service itself would simply depend on
systemd-modules-load.service, and its only task would be to call
"sensors -s". I think this is elegant and it requires no wrapper script.

The only issue which my approach does not solve is that the user gets
no clue that running sensors-detect may get him/her additional sensor
values. I'm not sure that writing that message to the system log is the
best way anyway, both because of a lack of visibility and because it
keeps filling the system log. Mentioning it in sensors(1), sensord(8)
and as a comment in lm_sensors.Service itself might be more
appropriate. It can also be explained better on the lm-sensors wiki and
in distribution documentation pages / wiki.

> Te sensord-service-wrapper enhances the sensord service so that
> it supports all relevant switches needed by the users which
> were previously omitted and thus unsupported.

We (openSUSE) don't really have a need for that at the moment because we
only support two options: $INTERVAL (-i) and $LOG_INTERVAL (-l). Same
as the upstream service file supports, actually. These options can be
passed to sensord unconditionally, so all I had to do it put default
values in a template sysconfig file (which I agree is missing upstream,
I'll add it.)

If we ever decide to support extra options in openSUSE, then I think I
would rather add a generic variable EXTRA_OPTIONS
in /etc/sysconfig/sensord and let the user pass everything he/she needs
there. This way, no wrapper script is needed, and you don't have to
change anything if sensord gets new options added. In fact I would
question why things where not implemented that way from the beginning.

Anyway, before this happens, I think we want to clean the rrd-related
code in sensord a lot. It's way too fragile the way it is right now, any
change in the sensors setup will break the rrd logging. On my own
systems I am running separate instances of sensord for each sensor chip
to workaround this weakness, but I do not expect all users to do that,
and that can't be easily integrated in a generic way anyway. There must
be a better way to make sensord rrd databases handle device additions
or removal. I have been willing to tackle that issue for a long time
but I can never find the time to actually look into it :(

> The service files now contain a placeholder for the target
> wrapper directory and distribution build scripts can do
> the substitution easily with two sed calls ...
>=20
> Example for RPM based distributions:
> sed -i "s|\@WRAPPER_DIR\@|%{_libexecdir}/%{name}|" sensord.service
> sed -i "s|\@WRAPPER_DIR\@|%{_libexecdir}/%{name}|" lm_sensors.service
>=20
> The patch is applicable on the latest trunk.
> Please, check it and apply if you find it worthy.

I don't really want to apply it, sorry. This is one way of handling the
existing issues, but there are others, and I don't think that your
approach is the best one. I'm not saying mine is perfect either, they
are just different.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
