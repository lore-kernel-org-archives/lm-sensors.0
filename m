From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Date: Tue, 10 Nov 2009 13:23:20 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <4AF96948.1010408@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Op 10-11-09 13:47, Daniel Mack schreef:
> Hi,
Hi
> On Tue, Nov 03, 2009 at 02:25:18PM +0100, =C9ric Piel wrote:
>>  * I don't know any userspace program which would be affected by this
>> change (they only rely on the relative difference). Arguably, I know
>> only few programs.
>=20
> Hmm. Maybe I don't understand the change then. I thought the patch will
> alter the _scale_ of the values to something more standard? If that's
> the case, also applications that take relative changes will be affected,
> right?
Ah, yes, you are right, my mistake. Scale do change the relative
difference as well! But what I actually meant was that the programs
either look if "it's getting smaller/bigger" (aka neverball), or "it's
positive/negative" (aka rotate screen).


>>  * Eventually, we should converge to a userspace API compatible with any
>> accelerometer device and exposed by all the accelerometer drivers. So
>> for now I consider the userspace interface of the lis3 driver quite
>> "soft", and any move toward this goal good.
>>  * Having platform data to select between old unit/new unit will add
>> complexity to the driver, which should be avoided whenever possible.
>=20
> True, and I'm not against dropping legacy. However, if it affects every
> user space application, we cannot simply change it. I happen to be
> copied in this thread, so I can react on it, but all other users are
> not.
Yes in general I completely agree with you: if we define some interface
that userspace is supposed to use, "we shall never change it". However,
in this specific case I'm willing to accept the possibility of breakage.
Because in the little chance that a program depends on this specific
metric it is making too much assumption on the hardware anyway: so far,
depending on the type of sensor (8b/12b, hdaps...) the values could be
very different.

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
