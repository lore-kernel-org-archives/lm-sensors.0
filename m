From: John <da_audiophile@yahoo.com>
Date: Tue, 28 Jan 2014 20:57:27 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <1390942647.15163.YahooMailNeo@web140003.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Tue, 28 Jan 2014 12:17:41 -0800 (PST), John wrote:

>>  > John, can you please test:
>>  > http://jdelvare.nerim.net/devel/lm-sensors/fancontrol
>>  > and confirm that it works fine with your old configuration file under
>>  > kernel 3.13?
>>=20
>>  Glad to give back by testing. =A0Yes, your new script uses my old confi=
g file=20
> under 3.13 just fine:
>=20
> Sweet, thanks for testing. I'll commit the fix now.


Cool... consider bumping the official version number (i.e. to 3.3.6 for exa=
mple) which will make it much easier for distro packagers to see it and to =
get it out to the masses.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
