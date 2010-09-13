From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Sep 2010 18:29:21 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100913182921.GC2099@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2010 at 02:44:32AM -0400, Lars Ivar Igesund wrote:
[...]
> 
> > It may simply be that your new kernel _is_ running hotter. There was a
> 
> > discussion about such an issue on the kernel mailing list a few weeks ago.
> 
> > The fix should be in the latest kernel. Maybe it isn't included in the
> 
> > Ubuntu 10.10 release yet.
> 
> The current latest kernel appear to be 2.6.35-20. Do you know which version should contain the fix?
> 
The mailing list thread is "high power consumption in recent kernels".
There are a couple of proposed patches, but I don't know if anything
has been integrated into the kernel. The discussion is still ongoing.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
