From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Clean up of i2c-elektor.c build for 2.6.11
Message-Id: <20050311110948.4a8404f6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <422E2417.7020707@aeroflex.com>
In-Reply-To: <422E2417.7020707@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

> This patch changes the flags variable type from long to unsigned long
> in  one function. This removes a couple of warnings from the compile 
> messages for elektor i2c bus driver.
> 
> Signed-Off-By Frank Beesley

Should be "Signed-off-by: Frank Beesley <some email address>".

Also, care to resend your patch *without* embedded ANSI colorization? I
wonder how you did that. It's nice and all, but such a patch cannot be
applied by "patch" so it's not exactly useful to us.

Thanks,
-- 
Jean Delvare
