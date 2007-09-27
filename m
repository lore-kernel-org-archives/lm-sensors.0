From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 Sep 2007 14:32:55 +0000
Subject: Re: [lm-sensors] possible ACPI vs w83627hf conflict,
Message-Id: <20070927163255.79263e7b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46FA5B0E.6040801@hhs.nl>
In-Reply-To: <46FA5B0E.6040801@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 26 Sep 2007 15:13:50 +0200, Hans de Goede wrote:
> James wrote:
> > I'm having problems with what seems to be lm_sensors and the kernel=20
> > having an argument in fedora! Instead of re-writing the content of my=20
> > posts to fedora forum and bugzilla I will post the links here if that i=
s=20
> > ok? If anyone could help me resolve this issue I'd appreciate it!=20
> > lm_sensors isnt vital for my system but it is handy!
> >=20
> > System:
> > Fedora 7, (Linux JamesFedora 2.6.22.5-76.fc7 #1 SMP Thu Aug 30 13:47:21=
=20
> > EDT 2007 i686 athlon i386 GNU/Linux)

Is there no newer kernel available? Upstream stable kernel is at
2.6.22.9 by now.

> > Original questions on:
> > http://www.fedoraforum.org/forum/showthread.php?p=871271#post871271
> >=20
> > Reported to bugzilla about lm_sensors but then moved as explained...
> > https://bugzilla.redhat.com/show_bug.cgi?id06801
> >=20
> > Can I provide any more information to help the problem?
> > I've temporarily disabled lm_sensors to try to prevent filesystem damag=
e=20
> > while im work on an important document, in a week or so I can continue =

> > testing it.
>=20
> Indeed there is no need to type your Fedora report again, but next time p=
lease=20
> copy and paste it for reader convenience (I've done that for you now):
>=20
> ---
>=20
> Description of problem:
> System freezes completely. Scanning logs only turns up kernel null-pointe=
r bugs
> that appear to be linked in to the sensors files....see my post
> http://www.fedoraforum.org/forum/showthread.php?p=871271#post871271
>=20
> Version-Release number of selected component (if applicable):
> lm_sensors-2.10.4-1.fc7
>=20
> How reproducible:
> Random, but a couple of times per day. Causes file system damage when the=
 system
> has locked up and needs a hard reset.
>=20
> Steps to Reproduce:
> 1.Impossible to tell, however usually doing something fairly intensive wh=
en it
> occurs, but never in the same package. Always listening to music over and=
 NFS
> shared mount at the time.
> 2.
> 3.
>=20
> Actual results:
> -
>=20
> Expected results:
> -
>=20
> Additional info:
> I'm not sure if this is an lm_sensors fault, but it seems that the last s=
ys file
> used every time is the hardware monitor file:
> /devices/platform/w83627hf.656/....

This can be explained easily if you have an application repeatedly
polling the temperature values: the last read file will always be the
same, but that doesn't mean that it has anything to do with the crash.
ksensors is such an application.

As I stated in bugzilla already, the backtraces in your forum post do
not point at a hwmon driver problem, nor to ACPI. The few hwmon vs. ACPI
issues we've seen lately had completely different symptoms. The
backtraces seem to point to networking and/or filesystem issues. So for
now I need to be convinced (with additional testing) that the w83627hf
driver has anything to do with the crashes.

I would be grateful if users could stop blaming hwmon and ACPI for
being the cause of all bugs that happen in the kernel ;)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
