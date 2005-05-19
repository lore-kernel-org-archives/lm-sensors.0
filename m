From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040804125311.0d23f34d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You can see at j1 (jean.tar.bz2) directory, the results you
> asked for. Please take a look.

Makes me think that fan speed stops being monitored when PWM is enabled
and have value (duty cycle) 0. I would call it a design flaw since it
will make the driver code more complex and becomes bogus if the fan
being monitored and the fan being controled are not the same one (which
is the case with somt revisions of that Intel board, it seems).

Nevermind, we'll have to handle this. Could you please try the following
test to confirm my point?

echo 1 > fan2_pwm_enable
for i in 252 236 220 204 188 172 156 140 124 108 92 76 60 44 28 12 0
do
	echo $i > fan2_pwm
	sleep 4
	cat fan2_input
done

I think I will have to force the fan reading to 0 when PWM is enabled
and PWM value is 0, regardless of what the register holds.

> Please, take a look at j2 (jean.tar.bz2) directory. There are
> the tests you asked for. Oh, check if the .sh is ok to you.
> I don't matter about the ALARMS. I just tried to give you
> the more information I could.

That one looks fine, min limit is preserved as it should :)

> I was wondering, are there some other things that can influence
> the behaviour of sensors? I mean, that could be affecting the
> results?

Well, ambient temperature obviously affects the temperature readings.
The heavy use of specific devices (such as the graphics adapter) may
have an impact on voltage readings. For the rest, it shouldn't change
unless you explicitely ask for it (changing PWM values, changing the CPU
speed, etc...)

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
