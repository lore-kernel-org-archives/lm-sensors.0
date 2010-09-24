From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Sep 2010 18:50:08 +0000
Subject: Re: [lm-sensors] x86/hwmon: fix module init for
Message-Id: <20100924185008.GA20110@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E139F0200007800015AA5@vpn.id2.novell.com>
In-Reply-To: <4C8E139F0200007800015AA5@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Beulich <jbeulich@novell.com>
Cc: fenghua.yu@intel.com, khali@linux-fr.org, gong.chen@linux.intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Sep 13, 2010 at 10:05:51AM -0000, Jan Beulich wrote:
> In commit 0dca94baeab4a1a514841b0a4c8e3a51dfb4d5ae the call to
> platform_driver_unregister() was made conditional upon !HOTPLUG_CPU,
> but the return value from coretemp_init() was left to indicate an
> error. This isn't correct, as the negative return value indicates to
> the module loader that initialization failed, which isn't intended
> here and results in dangling pointers.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Chen Gong <gong.chen@linux.intel.com>
> 
Looks like my previous mail got lost or stuck in our e-mail system.
Trying again. Sorry if this message is received twice.

I have not seen an Acked-by for this set of patches, nor a Nack. Since 
(most of) the patches fix real bugs, I applied the ones which do into
my staging tree, and the others into my -next tree.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
