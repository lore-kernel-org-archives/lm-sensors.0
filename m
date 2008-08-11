From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Aug 2008 07:05:35 +0000
Subject: Re: [lm-sensors] [2.6 patch] make ad7414_update_device() static
Message-Id: <20080811090535.3b3a23ca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080810210836.GA5480@cs181140183.pp.htv.fi>
In-Reply-To: <20080810210836.GA5480@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 10 Aug 2008 19:46:05 -0400, Sean MacLennan wrote:
> On Mon, 11 Aug 2008 00:08:36 +0300
> "Adrian Bunk" <bunk@kernel.org> wrote:
> 
> > This patch makes the needlessly global ad7414_update_device() static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> Sorry, my mistake. This is a leftover from when I was calling this
> function from another driver.
> 
> Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Added to jdelvare-hwmon for 2.6.28.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
