From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Sep 2011 17:01:51 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <20110924190151.44e86073@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 24 Sep 2011 09:10:17 -0700 (PDT), Audio Phile wrote:
> Ah!=A0 I didn't read the output carefully.=A0 If you notice, the "core id=
" is what is causing this, nothing wrong with lm-sensors here.

Indeed, the unexpected core IDs come straight from /proc/cpuinfo.

> We can I think blame HP.=A0 Next question would be how to get this on to =
the lm-sensors wiki so that other HP Z600 users can make this addition to t=
heir configs if necessary.

What makes you think the system vendor has anything to do with this? I
would expect the core IDs to be reported by the CPU itself (someone
please correct me if I'm wrong.)

> $ grep "core id" cpuinfo.txt
> core id=A0=A0=A0 =A0=A0=A0 : 0
> core id=A0=A0=A0 =A0=A0=A0 : 1
> core id=A0=A0=A0 =A0=A0=A0 : 9
> core id=A0=A0=A0 =A0=A0=A0 : 10
> core id=A0=A0=A0 =A0=A0=A0 : 0
> core id=A0=A0=A0 =A0=A0=A0 : 1
> core id=A0=A0=A0 =A0=A0=A0 : 9
> core id=A0=A0=A0 =A0=A0=A0 : 10
> core id=A0=A0=A0 =A0=A0=A0 : 0
> core id=A0=A0=A0 =A0=A0=A0 : 1
> core id=A0=A0=A0 =A0=A0=A0 : 9
> core id=A0=A0=A0 =A0=A0=A0 : 10
> core id=A0=A0=A0 =A0=A0=A0 : 0
> core id=A0=A0=A0 =A0=A0=A0 : 1
> core id=A0=A0=A0 =A0=A0=A0 : 9
> core id=A0=A0=A0 =A0=A0=A0 : 10

I have no idea if the CPU is just reporting strange values or if the
kernel is somehow misbehaving.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
