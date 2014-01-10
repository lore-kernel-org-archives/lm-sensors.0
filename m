From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Jan 2014 08:16:24 +0000
Subject: Re: [lm-sensors] wrong datas ?
Message-Id: <20140110091624.71d7dedf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
In-Reply-To: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 9 Jan 2014 18:56:30 +0000 (GMT), linuxcbon wrote:
>=20
> Le Lundi 6 janvier 2014 14h03, Jean Delvare <khali@linux-fr.org> a =E9cri=
t :
>=20
> ...Most important here is the kernel version, and the board brand=20
> and model.
> ---> yahoo email does "top posting" and not "> quoting", it's bad to answ=
er.
> kernel is 3.9.11
> board is gigabyte GA-MA78GM-UD2H
>=20
> ...For example, try adding
> the following to a new file under /etc/sensors.d:
> ---> you mean /etc/sensors.conf ?

No I really mean what I said: a new file under /etc/sensors.d, for
example /etc/sensors.d/Gigabyte-MA78GM-UD2H.conf.

You _can_ edit /etc/sensors.conf directly, however your changes are
likely to be lost on package update.

> chip "it8718-*"
> =A0 =A0 compute=A0 in3=A0 @ * (6.8/10+1), @ / (6.8/10+1)
> This should make the +5V line look reasonable. The exact scaling factor
> depends on your board.
> ---> it works, now shows +5.05 V

Great.

> ...But first check if we do not already have a configuration file for your
> board...
> ---> do you know where to find it ?

http://www.lm-sensors.org/wiki/Configurations

But I did check and we have a number of configuration files for
Gigabyte MA series boards but not yours. You may still find some
inspiration in these files as these two boards use the same monitoring
chip:

http://www.lm-sensors.org/wiki/Configurations/Gigabyte/MA785GM-US2H
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/MA770-DS3

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
