From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 24 Oct 2005 10:19:04 +0000
Subject: [lm-sensors] Re: [PATCH] add back i2c_smbus_read_block_data
Message-Id: <yy6qoA8T.1130141209.1766120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051023195202.17325.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051023195202.17325.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

On 2005-10-23, Rudolf Marek wrote:
> This patch just adds back the i2c_smbus_read_block_data, it will be used
> with lm93 driver.
>
> This patch originated from Eric J. Bowersox [1], but never made it to
> mainline.
> (...)
> [1] http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013228.html

It's more likely this one:
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013235.html

I have it already in my queue:
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-add-smbus-block-read.diff

I couldn't get it into mainline without a driver using it. So you can
consider it is available for the lm93 driver, and I'll send this patch
to Greg together with the lm93 driver patch when the latter is ready for
inclusion.

Thanks,
--
Jean Delvare
