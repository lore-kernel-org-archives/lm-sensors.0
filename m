From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Apr 2012 10:15:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7314) Fix build warning
Message-Id: <20120421121538.3ed30efc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334936357-12432-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1334936357-12432-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Apr 2012 09:18:35 +0200, Jean Delvare wrote:
> The original code looks a little weird though. Some of the defined
> constants aren't used, "offset" is used where "shift" should be.
> Introducing function sign_extend16 would also make the code more
> readable. I'll send a patch...

... or not. My patch makes the binary larger, so it's pointless.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
