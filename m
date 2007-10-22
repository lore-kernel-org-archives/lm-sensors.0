From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 22 Oct 2007 22:25:53 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471D2371.9010502@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare a =E9crit :
Hi Jean,

>> However I have a remark to ease the transition from version 2.x.x to
>> version 3.0.0: it is currently possible to have the two libraries
>> installed, but they both use the same configuration file. What about
>> having different config files for the two versions (e.g. sensors.conf
>> and sensors3.conf) ?
>=20
> Technically speaking, the libraries themselves don't have default
> configuration files. Applications do. That makes the matter only worse.

I agree that the library itself doesn't have any default. However, the
scripts in the source tarball install the configuration file as sensors.conf

> For openSuse, my plan was to get plain rid of lm-sensors 2 and all
> applications using it as soon as possible, so that no such conflict
> happens. I don't think we'll package libsensors v2.10.x in the next
> release. I don't know what Hans' plans are for Fedora. Of course, if
> you intend to guarantee backwards compatibility by shipping the old
> libsensors for a longer time in Debian, then indeed you have a problem.

I still don't know if we want to support backward compatibility in
Debian, but we have a lot more applications to port, so I don't know how
long it will take.

> The fact that applications, rather than the library, set the default
> configuration file name, means that it's essentially out of our control.
> We could change sensors and sensord in lm-sensors 3.0.0 to use a
> different default, but that won't solve the problem for all the 3rd
> party applications out there. You'd need to change them all. Either the
> authors do, or the packagers will have to.
>=20
> If you want to use /etc/sensors3.conf as the default for applications
> using lm-sensors 3 in Debian, there's nothing preventing you from doing
> that. This doesn't really have to be done upstream. That being said, I
> agree that it would become confusing if different distributions come up
> with different naming schemes.

Yes I agree the code can be changed, and having a common policy for all
distributions is a good point for the users.

> Coming to think about it, I think it's silly to have the default
> configuration file name in applications. There's really no reason why
> an application would want to use a different default, is there? So it
> might be the right time to change this and put the default
> configuration file name in libsensors. Calling sensors_init(NULL) would
> use that default. It would make it easier to change the default if a
> distribution wants to, and it would enforce a common default for
> applications using the new library. Opinions?

Looks like a really good idea, I vote for it.

> I don't much like the idea of using /etc/sensors3.conf for lm-sensors
> 3. Soon enough, lm-sensors 2 will be history, sensors.conf will no
> longer exist, and we'll be stuck with /etc/sensors3.conf. That's a bit
> unaesthetic, isn't it? A slightly different approach would be to
> use /etc/sensors3.conf if it exists, and /etc/sensors.conf otherwise
> (as was done for the XFree86 configuration file from version 3.x to
> version 4.x; remember?) This approach preserves compatibility with
> existing installations and offers a nice upgrade path. But of course
> this can only be (easily) implemented if the default is handled in
> libsensors rather than in the applications themselves, as I proposed
> above.

I think it is a good option. In case it is chosen, I advise to explain
that in the doc, otherwise the users may be confused.

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
