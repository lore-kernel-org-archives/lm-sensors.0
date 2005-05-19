From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pc87360 driver
Message-Id: <20040508135438.42438f26.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sandeep,

I have been doing some changes to the pc87360 driver today.
 - Do not include SENSORS_INSMOD stuff.
 - Rework chip initialization.
 - New module parameter: init.
 - Honor pwm invert bits again.

Nothing really interesting for you, but I'd like you to test and confirm
that I did not break anything. The driver lost about 20% of its size
(with DEBUG turned off) in the process, which sounds good.

I've changed my mind about PWM inversion and handle it again. I did so
because I now have a third tester for whom this is the correct behavior
*and* for whom changing PWM values does work. I think there's something
broken on your chip (although I don't know what) so sadly I can't trust
it (for this particular point).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
