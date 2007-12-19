From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2007 11:00:35 +0000
Subject: Re: [lm-sensors] sensors-detect: unecessary suggested change to
Message-Id: <20071219120035.4981ad83@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071217000316.GA27938@intrepid.com>
In-Reply-To: <20071217000316.GA27938@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Aurelien,

On Tue, 18 Dec 2007 19:16:30 +0100, Aurelien Jarno wrote:
> Jean Delvare a =E9crit :
> > On Tue, 18 Dec 2007 08:27:45 -0800, Gary Funck wrote:
> >> 3. The advice to start the service is good.  Should the user
> >> also be advised to enable it via chkconfig, or is it enabled
> >> by default in most distro packages?
> >=20
> > In openSuse, sensors-detect is modified to call /sbin/inserv at this
> > point. I don't know about the other distributions. Admittedly it would
> > be nice to automate this step as well, however I don't know for sure
> > how this can be done in a portable way. We could do:
> >=20
> >     system("/sbin/insserv", "/etc/init.d/lm_sensors")
> >       if -x "/sbin/insserv" && -f "/etc/init.d/lm_sensors";
> >=20
> > That would work for openSuse and presumably Fedora, but I don't know
> > about Debian. Aurelien?
>=20
> On Debian, the end of sensors-detect is heavily modified, as the sensors
> modules are written to /etc/modules instead, and the format is a bit
> different. All modules from this file are loaded automatically at boot ti=
me.
>=20
> Then the /etc/init.d/lm-sensors script corresponds to a simple script
> that read the "sensors -s" twice, so that the alarms are set and
> possibly cleared.

You should not assume that "sensors -s" will clear the alarms. It does
for now because libsysfs reads all the attributes even when not told to,
however I fixed that in SVN last week, so starting with lm-sensors
3.0.1 (or whatever we number the next version) it won't be the case
anymore. You should run "sensors", not "sensors -s", if you want to
clear the alarms. You may need to wait for 2 seconds before you do if
the first "sensors -s" read the alarm registers (which is the case in
3.0.0, but should no longer be in 3.0.1.)

> For the sensord daemon we have a separate package, and the daemon is
> enabled by default (since the package is not installed by default). This
> can be changed via /etc/default/sensord (usual path on Debian).
>=20
> So in short I am not opposed to changed on this part, as anyway it is
> already different :-)

OK, fair enough. I think I'll add the optional insserv call, I guess it
cannot hurt as it is protected with the relevant conditionals. But I
want to keep sensors-detect somewhat distribution-neutral. So, if you
feel that part of the changes done to this script in Debian are general
enough, I would be happy to merge them upstream, with whatever
conditionals are needed so that it won't cause trouble on other
distributions. But I'm not forcing you either, if you want to keep the
changes in Debian to have better control over them, that's equally fine
with me. It's really up to you.

Same apply to other popular distros, BTW: changes that are general
enough will be considered for upstream inclusion.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
