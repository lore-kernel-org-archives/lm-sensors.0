From: Audio Phile <da_audiophile@yahoo.com>
Date: Sat, 24 Sep 2011 16:10:17 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <1316880617.42891.YahooMailNeo@web36601.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ah!=A0 I didn't read the output carefully.=A0 If you notice, the "core id" =
is what is causing this, nothing wrong with lm-sensors here.=A0 We can I th=
ink blame HP.=A0 Next question would be how to get this on to the lm-sensor=
s wiki so that other HP Z600 users can make this addition to their configs =
if necessary.

$ grep "core id" cpuinfo.txt
core id=A0=A0=A0 =A0=A0=A0 : 0
core id=A0=A0=A0 =A0=A0=A0 : 1
core id=A0=A0=A0 =A0=A0=A0 : 9
core id=A0=A0=A0 =A0=A0=A0 : 10
core id=A0=A0=A0 =A0=A0=A0 : 0
core id=A0=A0=A0 =A0=A0=A0 : 1
core id=A0=A0=A0 =A0=A0=A0 : 9
core id=A0=A0=A0 =A0=A0=A0 : 10
core id=A0=A0=A0 =A0=A0=A0 : 0
core id=A0=A0=A0 =A0=A0=A0 : 1
core id=A0=A0=A0 =A0=A0=A0 : 9
core id=A0=A0=A0 =A0=A0=A0 : 10
core id=A0=A0=A0 =A0=A0=A0 : 0
core id=A0=A0=A0 =A0=A0=A0 : 1
core id=A0=A0=A0 =A0=A0=A0 : 9
core id=A0=A0=A0 =A0=A0=A0 : 10

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
