From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 03:31:50 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392780710.53579.YahooMailNeo@web160506.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Minor correction:

> You can see that in3 is "+3.3V". Of course I tried modifying in3 in my=20
> configuration as follows:
>=20
> label in3 "+5V"
> set in3_min 5 * 0.95
> set in3_max 5 * 1.05
> compute=A0 in3=A0 @*((20/10)+1), @/((20/10)+1) #### was in4

Could this perhaps be a bug in the w83627ehf kernel module?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
