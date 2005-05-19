From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030811202849.1413ee1a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Tom,

We would need a bit more details about your patch before we can apply
it.

1* What is the register that cause the problems? How did you come to it,
starting from the problem you encountered on that motherboard?

2* What are these values 0x02 and 0xFD you are using? Why do you say
that having 0x02 in that register is an "unknown" state?

3* How well-tested is your patch? Did you test it on a "standard" piix4
chipset?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
