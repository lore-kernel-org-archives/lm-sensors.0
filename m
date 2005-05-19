From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: as99127f pwm registers
Message-Id: <20030722093411.25d749c5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alex,

We are having some trouble with the as99127f again, and I thought maybe
you could help us on this point.

The register we are fighting with this time is 0x5B. In our current
driver implementation, this register is supposed to be PWM1 (fan speed
control) as for the w83781d, but I did some tests on my motherboard
(Asus A7V133-C, AS99127F) yesterday and it turned out that this register
behaves like a temperature sensor mode selector (like the it87 has).
What's your opinion about this register? Where would PWM1 be if it's not
there?

Oh, by the way, I could see on your webpage that you differenciate two
revisions of the AS99127F. Which register do you use for that? What are
the differencies between these two revisions?

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
