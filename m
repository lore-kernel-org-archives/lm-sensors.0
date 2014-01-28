From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jan 2014 20:54:03 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <20140128215403.29b59697@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 28 Jan 2014 12:17:41 -0800 (PST), John wrote:
> > John, can you please test:
> > http://jdelvare.nerim.net/devel/lm-sensors/fancontrol
> > and confirm that it works fine with your old configuration file under
> > kernel 3.13?
>=20
> Glad to give back by testing. =A0Yes, your new script uses my old config =
file under 3.13 just fine:

Sweet, thanks for testing. I'll commit the fix now.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
