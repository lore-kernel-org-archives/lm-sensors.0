From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 13:41:49 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 2.6 additions to lm-sensors
Message-Id: <20070812154149.4286f8ce@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 26 Jul 2007 23:09:02 +0200, Krzysztof Helt wrote:
> This patch adds support for the THMC50 kernel driver to lm-sensors library (for 2.6 kernel driver).
> At least temperatures and analog output (fan) can be read.

Applied, thanks. Not sure how useful it is though, given that neither
sensors not xsensors support this chip yet. But maybe other frontends
do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
