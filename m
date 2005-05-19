From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040612154233.32481cc0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> But I really wonder about these ones. the /250 makes me guess that the
> temperature has a 0.25 degree resolution. So, limiting to -127,+127
> means -31 to +31 degrees. It hardly makes sense. Same probably goes
> for the /25. Could you please check with the datasheet and code and
> confirm whether these -127,+127 limits make sense?

I just checked:

EXTTEMP_TO_REG is used on -32,+32 0.25 degree/bit registers, so it's OK
(except that the low limit could be -128 instead of -127, but it doesn't
really matter).

OFFSET_TO_REG is not used anywhere (neither is OFFSET_FROM_REG) so you
can discard them completely.

Please update your patch and submit to Greg. I'll backport to 2.4 then.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
