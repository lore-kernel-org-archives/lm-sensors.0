From: linuxcbon <linuxcbon@yahoo.fr>
Date: Thu, 09 Jan 2014 18:56:30 +0000
Subject: Re: [lm-sensors] wrong datas ?
Message-Id: <1389293790.73879.YahooMailNeo@web173202.mail.ir2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
In-Reply-To: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Le Lundi 6 janvier 2014 14h03, Jean Delvare <khali@linux-fr.org> a =E9crit :

...Most important here is the kernel version, and the board brand=20
and model.
---> yahoo email does "top posting" and not "> quoting", it's bad to answer.
kernel is 3.9.11
board is gigabyte GA-MA78GM-UD2H

...For example, try adding
the following to a new file under /etc/sensors.d:
---> you mean /etc/sensors.conf ?

chip "it8718-*"
=A0 =A0 compute=A0 in3=A0 @ * (6.8/10+1), @ / (6.8/10+1)
This should make the +5V line look reasonable. The exact scaling factor
depends on your board.
---> it works, now shows +5.05 V

...But first check if we do not already have a configuration file for your
board...
---> do you know where to find it ?

thanks in advance

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
