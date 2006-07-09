From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 09 Jul 2006 19:22:53 +0000
Subject: [lm-sensors] Unresolved symbols in i2c-ipmi
Message-Id: <44B1578D.1030804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1152258427.2658.21.camel@localhost.localdomain>
In-Reply-To: <1152258427.2658.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Hubert,

Sorry for the delay.

> ipmi_destroy_user_Rsmp_74848fb7

It seems like modvesions problem to me. Does the i2c-impi directly include the
modversions.h file?

Anyway, you have the RedHat E. Linux so I would suggest to ask RedHat for that
(or impi people)

The kernel 2.4.21 is very old and unfortunately I cannot recall anything special
about it. I would focus on the modversion problems -> most likely it is the case
of troubles.

I hope it helps,

Regards
Rudolf


