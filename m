From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Mon, 17 Dec 2018 12:06:38 +0000
Subject: Re: libsensors soname bump
Message-Id: <7b96e7c3-11d6-a06f-53a6-1d61be31c3b3@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20181216124344.49d06b69@endymion>
 <514c8587-ccf3-f7af-b88d-744add6f1da2@redhat.com>
 <3799b201-38f9-d74f-273d-f819736dcfb6@redhat.com>
 <20181217115902.15e538fe@endymion>
 <20181217112713.jvobrvrmxpkfeshi@aurel32.net>
In-Reply-To: <20181217112713.jvobrvrmxpkfeshi@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org

Hi lm-sensors list,

We're currently considering reverting the undue libsensors soname change
that happened in lm_sensors 3.5.0 (see below, the whole thread should be
available on spinics [1]). Would that pose a major problem for anyone?

Thanks!

[1] https://www.spinics.net/lists/linux-hwmon/msg04837.html

Best regards
Ond=C5=99ej Lyson=C4=9Bk

On 17. 12. 18 12:27, Aurelien Jarno wrote:
> On 2018-12-17 11:59, Jean Delvare wrote:
>> On Mon, 17 Dec 2018 11:35:46 +0100, Ond=C5=99ej Lyson=C4=9Bk wrote:
>>> I mean, I would love to revert the soname change, however doing so now
>>> seems like a bad thing to do - people may have already adopted
>>> lm_sensors 3.5.0. So I'd like to avoid reverting the change unless there
>>> is a good justification to do so.
>>
>> It's not in Debian yet:
>> https://packages.debian.org/sid/lm-sensors
>=20
> It's available in the experimental suite with the soname change:
> https://packages.debian.org/experimental/lm-sensors
>=20
> And it's waiting for a transition slot to rebuild all the
> reverse dependencies in sid:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=915790
>=20
> So on the Debian side, there is still time to revert the soname change.
>=20
> Aurelien
>=20
