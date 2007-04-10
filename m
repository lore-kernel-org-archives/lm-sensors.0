From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Tue, 10 Apr 2007 06:12:16 +0000
Subject: [lm-sensors] What to do ta have new sensor patch included in 2.6
Message-Id: <461b2ac080b93@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I tried to port THMC50/ADM1022 driver for 2.6 kernel tree. Where
should I post the patch?

I sent it one month ago to this list, but it seemed to get ignored.=20

I can report that I happily use this driver in the Compaq AP550
workstation with two ADM1022 chips for over a month now.

The sensors command does not handle it correctly (lack of board
definition and new 2.6 kernel interface). I can also patch the
sensors command, but I need to have accepted interface to the
chip (pwm1, tempX_input files).

Regards,
Krzysztof

----------------------------------------------------
Rozlicz si=EA sercem - przeka=BF 1% podatku.
1% Twojego podatku mo=BFe uratowa=E6 =BFycie dziecka!
Jak przekaza=E6 1% podatku potrzebuj=B1cym? Kliknij i zobacz:
http://klik.wp.pl/?adr=3Dwww.jedenprocent.wp.pl&sid=1086



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
