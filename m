From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: "probe" module param broken for it87 in Linux 2.6.6
Message-Id: <20040512201421.GC15789@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Becides the issues already brought up...

On Wed, May 12, 2004 at 04:38:03PM +0200, Bj?rn Mork wrote:
> +	if (!it87_find(&addr)) {
> +		printk("it87.o: new ISA address: 0x%04x\n", addr);

That printk is wrong (no KERN_ level, or dev_printk() style use).
Please fix it in your next revision of this patch.

thanks,

greg k-h
