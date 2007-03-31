From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Mar 2007 13:21:49 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp 2/3 Add the coretemp driver
Message-Id: <20070331152149.814ae4ee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46006650.8000603@assembler.cz>
In-Reply-To: <46006650.8000603@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On Thu, 29 Mar 2007 17:16:32 -0600, George T. Joseph wrote:
> This may be a little late, but how about a module parameter that sets
> tjmax (and suppresses the warning). This way if the detection logic
> fails for some reason, the driver can still be used if the user knows
> what the tjmax for their processor is.

If this is only an option, I guess it cannot hurt. I have no strong
opinion on the feature itself, Rudolf will know better. But at any
rate, it's not too late - open source code is _meant_ to be improved
over time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
