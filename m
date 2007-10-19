From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Oct 2007 14:46:35 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071019164635.23c02fc5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Aurelien,

On Thu, 18 Oct 2007 10:18:16 +0200, Aurelien Jarno wrote:
> Jean Delvare a =E9crit :
> > Any news on this? I am more or less waiting for this to happen before
> > we can release lm-sensors 3.0.0 final.
>=20
> I have just given a try. It works nicely here.

Great, thanks for the testing and report.

> However I have a remark to ease the transition from version 2.x.x to
> version 3.0.0: it is currently possible to have the two libraries
> installed, but they both use the same configuration file. What about
> having different config files for the two versions (e.g. sensors.conf
> and sensors3.conf) ?

Technically speaking, the libraries themselves don't have default
configuration files. Applications do. That makes the matter only worse.

For openSuse, my plan was to get plain rid of lm-sensors 2 and all
applications using it as soon as possible, so that no such conflict
happens. I don't think we'll package libsensors v2.10.x in the next
release. I don't know what Hans' plans are for Fedora. Of course, if
you intend to guarantee backwards compatibility by shipping the old
libsensors for a longer time in Debian, then indeed you have a problem.

The fact that applications, rather than the library, set the default
configuration file name, means that it's essentially out of our control.
We could change sensors and sensord in lm-sensors 3.0.0 to use a
different default, but that won't solve the problem for all the 3rd
party applications out there. You'd need to change them all. Either the
authors do, or the packagers will have to.

If you want to use /etc/sensors3.conf as the default for applications
using lm-sensors 3 in Debian, there's nothing preventing you from doing
that. This doesn't really have to be done upstream. That being said, I
agree that it would become confusing if different distributions come up
with different naming schemes.

Coming to think about it, I think it's silly to have the default
configuration file name in applications. There's really no reason why
an application would want to use a different default, is there? So it
might be the right time to change this and put the default
configuration file name in libsensors. Calling sensors_init(NULL) would
use that default. It would make it easier to change the default if a
distribution wants to, and it would enforce a common default for
applications using the new library. Opinions?

I don't much like the idea of using /etc/sensors3.conf for lm-sensors
3. Soon enough, lm-sensors 2 will be history, sensors.conf will no
longer exist, and we'll be stuck with /etc/sensors3.conf. That's a bit
unaesthetic, isn't it? A slightly different approach would be to
use /etc/sensors3.conf if it exists, and /etc/sensors.conf otherwise
(as was done for the XFree86 configuration file from version 3.x to
version 4.x; remember?) This approach preserves compatibility with
existing installations and offers a nice upgrade path. But of course
this can only be (easily) implemented if the default is handled in
libsensors rather than in the applications themselves, as I proposed
above.

We have to decide ourselves quickly, as 3.0.0 is almost there now.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
