From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 26 Sep 2007 13:13:50 +0000
Subject: [lm-sensors] possible ACPI vs w83627hf conflict,
Message-Id: <46FA5B0E.6040801@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

James wrote:
> G'day all,
>=20
> I'm having problems with what seems to be lm_sensors and the kernel=20
> having an argument in fedora! Instead of re-writing the content of my=20
> posts to fedora forum and bugzilla I will post the links here if that is =

> ok? If anyone could help me resolve this issue I'd appreciate it!=20
> lm_sensors isnt vital for my system but it is handy!
>=20
> System:
> Fedora 7, (Linux JamesFedora 2.6.22.5-76.fc7 #1 SMP Thu Aug 30 13:47:21=20
> EDT 2007 i686 athlon i386 GNU/Linux)
>=20
> Original questions on:
> http://www.fedoraforum.org/forum/showthread.php?p=871271#post871271
>=20
> Reported to bugzilla about lm_sensors but then moved as explained...
> https://bugzilla.redhat.com/show_bug.cgi?id06801
>=20
> Can I provide any more information to help the problem?
> I've temporarily disabled lm_sensors to try to prevent filesystem damage =

> while im work on an important document, in a week or so I can continue=20
> testing it.
>=20

Indeed there is no need to type your Fedora report again, but next time ple=
ase=20
copy and paste it for reader convenience (I've done that for you now):

---

Description of problem:
System freezes completely. Scanning logs only turns up kernel null-pointer =
bugs
that appear to be linked in to the sensors files....see my post
http://www.fedoraforum.org/forum/showthread.php?p=871271#post871271

Version-Release number of selected component (if applicable):
lm_sensors-2.10.4-1.fc7

How reproducible:
Random, but a couple of times per day. Causes file system damage when the s=
ystem
has locked up and needs a hard reset.

Steps to Reproduce:
1.Impossible to tell, however usually doing something fairly intensive when=
 it
occurs, but never in the same package. Always listening to music over and N=
FS
shared mount at the time.
2.
3.

Actual results:
-

Expected results:
-

Additional info:
I'm not sure if this is an lm_sensors fault, but it seems that the last sys=
 file
used every time is the hardware monitor file:
/devices/platform/w83627hf.656/....

---

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
