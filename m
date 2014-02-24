From: ianp <braveheart_leo@yahoo.com>
Date: Mon, 24 Feb 2014 22:13:58 +0000
Subject: Re: [lm-sensors] Sensors configuration for ASRock G41C-GS
Message-Id: <1393280038.6703.YahooMailNeo@web160502.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
In-Reply-To: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,


I wish to submit some corrections regarding this configuration.


### Fans

=A0=A0 ### Ignore fan4 and fan5. There are
=A0=A0 ### only 3 fan connectors on this board.

=A0=A0 label=A0 fan1=A0 "POW Fan"=A0=A0=A0=A0=A0=A0 # was incorrectly label=
ed "CHA Fan"
=A0=A0 label=A0 fan2=A0 "CPU Fan"
=A0=A0 label=A0 fan3=A0 "CHA Fan"=A0=A0=A0=A0=A0=A0 # was incorrectly label=
ed "PSU Fan"
=A0=A0 ignore fan4
=A0=A0 ignore fan5


I was able to verify this after having acquired a fan that provided speed m=
onitoring. I have changed "PSU Fan" to "POW Fan" so that it matches the lab=
eling on the motherboard as well, which is POWER_FAN.

Thanks,

ianp


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
