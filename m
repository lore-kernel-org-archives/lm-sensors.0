From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jul 2012 01:52:39 +0000
Subject: Re: [lm-sensors] SYSTIN, CPUTIN, AUXTIN...
Message-Id: <20120720015239.GA5351@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <911349481.542030.1342736745161.JavaMail.www@wwinf8212>
In-Reply-To: <911349481.542030.1342736745161.JavaMail.www@wwinf8212>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jul 20, 2012 at 12:25:45AM +0200, mahimahi wrote:
> (sorry for my bad english... je double plus bas en fran=E7ais)
>=20
> Hello,
>=20
> In my Psensor frame, I've more lines that I don't understand what it to m=
atch
> SYSTIN
> CPUTIN
> AUXTIN
> PECI Agent 0
>=20
> I've tried to remove it :
> [file /etc/sensors.d/ignoreAUTRE]
> chip "nct6776-*"
> ignore temp0
> ignore CPUTIN
> ignore AUXTIN
> ignore "lmsensor nct6776-isa-0290 PECI Agent 0"
>=20
Run "sensors -u" to see the label to attribute association. SYSTIN/CPUTIN/A=
UXTIN
will be temp1..temp3.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
