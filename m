From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Fri, 11 May 2012 19:15:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <D14388DA-2098-4A18-BFD7-BAE731F64473@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi @ll,

Am 11.05.2012 um 15:38 schrieb Guenter Roeck:
> On Fri, May 11, 2012 at 05:23:52AM -0400, Jean Delvare wrote:
> [ ... ]
>>=20
>>>> So my personal guess is that this bit switches VIN7 to the internal
>>>> source just as with the other chips.
>>>>=20
>>> Hmmm ... no idea what I should do. Play it safe or assume this is an er=
ror
>>> in the data sheet ? I tend towards playing safe, but not too much.
>>> Guess I am waiting for someone to convince me otherwise...
>>=20
>> I would not skip VIN7 until we know more. People will never report
>> about missing 5VSB monitoring, but they will report if 5VSB looks wrong.
>>=20
>> Do we have any tester for the IT8783F yet? What you could do for now is
>=20
> Bjoern Gerhart has been testing it quite extensively. I don't recall
> what they do with VIN7, though.
>=20
Yes, I have an IT8783F hw configuration with voltage in7 connected to 1.1V =
nominal. I can give it a re-test with the latest patches applied on beginni=
ng of next week against kernel 2.6.32. Then I can also ask if my hw colleag=
ues have an idea about the pin 91 mystery.

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
