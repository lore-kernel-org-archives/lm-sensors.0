From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 May 2011 15:44:08 +0000
Subject: Re: [lm-sensors] Testing results for Nuvoton W83677HG-I
Message-Id: <20110529174408.41efbba0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD783EB.5010606@gmail.com>
In-Reply-To: <4DD783EB.5010606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 29 May 2011 17:47:18 +0400, Arseny Klimovsky wrote:
> With this driver I created a configuration for my board. It can be added 
> to wiki, but I have some questions:
> 1. Multiplier for +12V is strange (11), but it gets exactly correct 
> results (12.14V switching to 12.23V and back). Can this be correct?

It is perfectly possible, yes.

> 2. Statement "ignore temp5" does not take effect. I see line about "PECI 
> Agent 1"

Maybe it's not temp5 but temp6 or more. Try "sensors -u" to find out
the right number.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
