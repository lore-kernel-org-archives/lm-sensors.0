From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 07 Jul 2007 14:48:39 +0000
Subject: [lm-sensors] TEMP_HYST and TEMP_LOW difference for 2.4 kernel?
Message-Id: <468fa7c736845@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I want to add support for the THMC50 sensor to the lmsensors=20
2.x. I found that original THMC50 does not work with 2.6 kernel=20
because it expects a value tempX_max_hyst instead of tempX_min.

I found that the 2.4 driver returns TEMP, TEMP_HYST and=20
TEMP_OVER. The 2.4 equivalent to the tempX_min is called=20
TEMP_LOW.

Is there any difference between TEMP_LOW and TEMP_HYST?=20

May I change the 2.4 THMC50 driver (which should be cleaned and=20
extended for the adm1021 anyway) to report TEMP_LOW instead of=20
TEMP_HYST?=20

Regards,
Krzysztof

----------------------------------------------------
12 Festiwal Gwiazd z gwiazdorsk=B1 obsad=B1! 5-8 lipca w Gda=F1sku!
Wi=EAcej: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Ffe=
stival3.html&sid=1216



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
