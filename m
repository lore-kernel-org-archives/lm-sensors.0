From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pwmconfig fix
Message-Id: <20040508133219.622c5dc8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> [little bug report + fix]
> 
> On my Asus P4P800 motherboard with a w83627thf sensor chip, pwmconfig
> from lm_sensors-2.8.6 doesn't detect the pwm-files by default
> (2.6.6-rc3, module w83627hf).
> (...)
> As you can see the pwm files are called 'fan[1-9]_pwm'. Likewise for
> the fan inputs, which are called fan[1-9]_input.
> 
> After changing this in pwmconfig to take those files into account,
> your script worked. Thanks.

I've changed that, hopefully in the proper way. Thanks for reporting.
Unfortunately I don't have pwm-capable system to test with here. Would
you please be kind enough and checkout the latest CVS version of the
script, and ensure it works OK?

Thanks again.

-- 
Jean Delvare
http://khali.linux-fr.org/
