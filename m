From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2007 19:02:35 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] lm-sensors: add detection for
Message-Id: <20070625210235.3060ffeb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706250907x92f1189gb62ffbe5ec800172@mail.gmail.com>
In-Reply-To: <191fb4ca0706250907x92f1189gb62ffbe5ec800172@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 25 Jun 2007 09:07:59 -0700, Juerg Haefliger wrote:
> This patch adds detection logic for non-standard SMSC Super I/Os.
> These chips have their device ID register at address 0x0d rather than
> 0x20.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
