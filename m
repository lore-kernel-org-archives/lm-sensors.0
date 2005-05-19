From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <20040528193729.3239c8a3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Unfortunately, I was unable to note any differences in the voltages 
> after setting all pwm values back to 0. I also played around with it 
> some more, but nothing changed in the output of sensors.
> (...)
> The chip dump is also attached.

I read the dumps and actually the values are completely different from
what they were. Something changed in your chip, I don't know what... The
configuration registers didn't change.

If rebooting this box is an option, I'd suggest that you:
* (preferably cold) reboot
* dump
* load driver
* dump
* do sensors -s
* dump

And send all three dump sets. Maybe any of these steps will revert to
the old value or break readings again.

BTW, did you find out which of temp4-6 was the CPU temp? temp5 is higher
that the others in your latest output, this is an interesting hint.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
