From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Oct 2011 06:20:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon:lm75 add ADT75 support - requires
Message-Id: <20111013082017.660dbd34@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Oct 2011 13:45:48 -0700, Guenter Roeck wrote:
> Maybe it would make sense to add a note to lm75_detect, indicating that
> it is not _supposed_ to work on LM75 compatible chips.

Good point, as this isn't the first time users (or developers) report
with different expectations. Will you write the patch, or do you want
me to?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
