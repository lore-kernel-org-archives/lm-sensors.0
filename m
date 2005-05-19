From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040731134806.02e9f624.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please, take a look at probs4.txt attached.

The good point is that you seem to be able to control fan 1's speed. But
the reported value goes weird as soon as the fan is stopped. Either the
value isn't updated anymore (i.e. last value is reported) or random
values are reported. Since it reported 5851 RPM once, which doesn't seem
possibe, I would opt for the second case. However, I would like you to
do some more tests to confirm that.

Please stop the fan (pwm_enable=1, pwm=0) and run sensors several times
in a row, with some delay between each run. Check if the (obviously
wrong value) which is reported is the same each time, or not.

> Please, take a look at results_jean.txt

My code was obviously bogus, fan min was not preserved at all when
changining fan div. I just took a look and have to say I'm a bit
ashamed, since it was caused by... a misplaced parenthesis.

Fixed patch is available:
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-beta3.diff
if you can please test again using the same script. Oh, BTW:

> modprobe i2c_sensor
> modprobe i2c-i801
> modprobe i2c-isa
> modprobe adm1025
> modprobe smsc47m1

You don't need to explicitly modprobe i2c_sensor, it'll be loaded as
needed automatically.

> and results_jean_dump.txt.

Fan alarms are not set on the dump you sent, so there's nothing I can
check. The case I'm interested in is when "sensors" show an alarm which
you think should not be there. If you provide both the output of
"sensors" and the dump at that instant, I may be able to check if
sensors' output matches the registers dump or not. If you are not able
to reproduce that corner case or are not worried about it, just forget
about it, it's not critical.

> From today, I can delay a little more to answer because I am back to
> college classes. (The end of vacation)

Oh, I wish you well then :)

> P.S. My english is not good enough. :-)

Like mine is perfect? ;) Come on, you must be kidding, your English is
honest to say the least. You have no idea what bad English is.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
