From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040805092114.684e671f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The results are attached, including the shell script I used.
> I sent you the results for fan2, as you asked, and for fan1,
> because fan2 here appears to be the CPU cooler. Anyway, using
> fan1 the corresponding fan was stopped at the end of the script.
> :-)

OK, so it must be working. I should have told you to set the fan clock
divider to 8 before starting the test, but the results are still
significant.

I've updated the driver:
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-rc1.diff

It should now force the fan speed reading to 0 when PWM is enabled with
a duty cycle of 0%. So for example the following sequence should work
fine:

echo 0 > fan1_pwm_enable
echo 0 > fan1_pwm
sleep 4
cat fan1_input (should return 3000 or so)
echo 1 > fan1_pwm_enable (fan should stop)
sleep 3
cat fan1_input (should return 0)

With the previous version if would have returned the last known speed or
some other random non-zero value (it seems) while the fan would clearly
be stopped.

If you confirm that this version of the driver works fine for you, I'll
submit it for incorporation into Greg's tree.

> Ok. I was just wondering if some strange values could be the
> result of some interference.

Unless you refer to interference in the designers brains, I don't think
so ;)

Thanks a lot for testing, it looks like we finally came to a working 2.6
driver.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
