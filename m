From: Arnaud Lacombe <lacombar@gmail.com>
Date: Fri, 10 Jun 2011 16:30:59 +0000
Subject: Re: [lm-sensors] [GIT] kbuild fixes for 3.0
Message-Id: <BANLkTinA2S55fn5nNb1WOo=T0dKX3cBzfQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110609214241.GA4849@sepie.suse.cz>
	<BANLkTim84t=yeqykZydEjHrVYGnO4xc5ew@mail.gmail.com>
	<BANLkTi=qaA_AMvq_78eon3Lr86wT2R497g@mail.gmail.com>
	<BANLkTinbXpFp43+EebWbWvs1Uu5wWvhxQQ@mail.gmail.com>
	<BANLkTinKMmYG7=KBHr2LfOYzcgbtszwy5g@mail.gmail.com>
	<BANLkTinQ2mL1eNPzMHjDjXnLyv58annZmA@mail.gmail.com>
	<BANLkTi=wQaUSagZjptGnvUHNpJeMm0C6yw@mail.gmail.com>
In-Reply-To: <BANLkTi=wQaUSagZjptGnvUHNpJeMm0C6yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@lm-sensors.org
Cc: Michal Marek <mmarek@suse.cz>, pefoley2@verizon.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

[following-up to lm-sensors@lm-sensors.org for bug-report.]

On Fri, Jun 10, 2011 at 1:16 AM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 9, 2011 at 11:57 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Jun 9, 2011 at 8:45 PM, Arnaud Lacombe <lacombar@gmail.com> wrot=
e:
>>>
>>> For the record, this should have been fixed by Michal in:
>>
>> You're missing the problem: we can't assume that people have updated use=
r land.
>>
> I absolutely agree with you. But I am not the one about to decide to
> break a 15 years old interface :) [I gave me a 5 year delta as I have
> no idea how the version number was at that time; moreover, do not get
> me wrong, I do not really care about the kernel version being 2 or 3
> digits.].
>
>> Furthermore, the very pull request I'm responding to actually tries to
>> handle this, see commit bfe5424a8b31 ("kbuild: Hack for depmod not
>> handling X.Y versions"), but it's just not working for me.
>>
>> And it's not working, because it only handles the "modules_install"
>> case, not the case where the system install scripts do their own
>> depmod.
>>
> I totally agree! But, it is a technical challenge to give a 2 digit
> version number to an application expecting a 3 digit version number
> without much control over its environment.
>
> Beside that, no matter what, you are about to break
> `/usr/sbin/sensors-detect' (from my Fedora 14), which rely on a 3
> digits version number:
>
> # [0] -> VERSION
> # [1] -> PATCHLEVEL
> # [2] -> SUBLEVEL
> # [3] -> EXTRAVERSION
> #
> use vars qw(@kernel_version $kernel_arch);
>
> sub initialize_kernel_version
> {
> =A0 =A0 =A0 =A0`uname -r` =3D~ /(\d+)\.(\d+)\.(\d+)(.*)/;
> =A0 =A0 =A0 =A0@kernel_version =3D ($1, $2, $3, $4);
> =A0 =A0 =A0 =A0chomp($kernel_arch =3D `uname -m`);
>
> =A0 =A0 =A0 =A0# We only support kernels >=3D 2.6.5
> =A0 =A0 =A0 =A0if (!kernel_version_at_least(2, 6, 5)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "Kernel version is unsupported (too =
old, >> 2.6.5 needed)\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit -1;
> =A0 =A0 =A0 =A0}
> }
>
`sensors-detect's kernel version detection regexp is unable to parse 2
digits kernel version number and dies with:

[From Fedora 14's /usr/sbin/sensors-detect]

Use of uninitialized value $kernel_version[0] in numeric gt (>) at
./sensors-detect line 2442.
Use of uninitialized value $kernel_version[0] in numeric eq (=3D) at
./sensors-detect line 2442.
Kernel version is unsupported (too old, >=3D 2.6.5 needed)

I just checked the SVN repository, the issue still seems to be
present. I am not sure if other lm-sensors part are affected. This
will becomes an issue with the upcoming 3.x kernel serie.

Regards,
 - Arnaud

> sub kernel_version_at_least
> {
> =A0 =A0 =A0 =A0my ($vers, $plvl, $slvl) =3D @_;
> =A0 =A0 =A0 =A0return 1 if ($kernel_version[0] > $vers ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($kernel_version[0] =3D $vers &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0($kernel_version[1] > $plvl ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($kernel_version[1] =3D $plvl=
 &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0($kernel_version[2] >=3D $=
slvl)))));
> =A0 =A0 =A0 =A0return 0;
> }
>
> would fail with:
>
> Kernel version is unsupported (too old, >=3D 2.6.5 needed)
>
> with "uname -r" being "3.0-rc2"
>
> =A0- Arnaud
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
