From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: lm_sensors troubles with asus a7m-266
Message-Id: <20030926222917.7928a6c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F73F49E.10806@oceanography.ru>
In-Reply-To: <3F73F49E.10806@oceanography.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Using lm_sensors on asus a7m-266, I get pwr fan reporting 0.
> The same stuff with asus probe in windoze - 1400
> (but allows the min setting not lower that 2400 or smth).
> Any ideas?

PWM support is known to be broken in as99127f. BTW, you are luckier than
me. I can't get PWM to work with Asus Probe under Windows. It just
doesn't show, as if my hardware did not support it (is an A7V133-C).
With SpeedFan, controls show but have no effect.

We can't fix PWM in as99127f until Asus release a datasheet. Ask them to
release one if you want us to support it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
