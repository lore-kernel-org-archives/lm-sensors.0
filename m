From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 30 Mar 2006 21:31:16 +0000
Subject: [lm-sensors] asm58 for 2.10.0, linux 2.6.15
Message-Id: <442C4E24.9030603@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <9328bcc00602262007h79e1b9ffu5f9c463b486b1da@mail.gmail.com>
In-Reply-To: <9328bcc00602262007h79e1b9ffu5f9c463b486b1da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rigel Freden wrote:
> thank you for the review; i believe i made every change you requested,
> except the sysfs attribute array and device file creation thing, which
> i'm too tired or coded out or just plain stupid to understand (perhaps
> my google-fu is weak tonight).  attached are the resultant patches to
> kernel 2.6.16 and lm sensors 2.10.0.  My former system instability
> turned out to be a power supply fan failure rather than my hwmon
> driver.  now to install a i2c sensor on my psu heatsink...

Good.

Jean, care to take a look and eventualy accept it?

Rigel depending on the comments from Jean you will need to send the patch
with the Signed-Off-By stuff + a classic descripotion what the patch does.


Regards
Rudolf

