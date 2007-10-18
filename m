From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 18 Oct 2007 08:18:16 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471716C8.7080605@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare a =E9crit :
> Hi Hans,
>=20
> On Wed, 26 Sep 2007 23:02:31 +0200, Hans de Goede wrote:
>> Excellent work Jean! I've given this a test run on all my systems / test=
 rigs=20
>> and it works great everywhere. I'll create patches for ksensors, gkrellm=
, and=20
>> gome's sensors-applet as time permits. I'm afraid this will take a while=
 as=20
>> currently I'm very busy with stuff regarding the upcoming Fedora 8.
>=20
> Any news on this? I am more or less waiting for this to happen before
> we can release lm-sensors 3.0.0 final.
>=20

I have just given a try. It works nicely here.

However I have a remark to ease the transition from version 2.x.x to
version 3.0.0: it is currently possible to have the two libraries
installed, but they both use the same configuration file. What about
having different config files for the two versions (e.g. sensors.conf
and sensors3.conf) ?

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
