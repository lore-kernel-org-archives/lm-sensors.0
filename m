From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 Jun 2010 14:51:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100622165142.21f9901c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Tue, 22 Jun 2010 13:24:03 +0200, Andreas Herrmann wrote:
> On Tue, Jun 22, 2010 at 01:35:33PM +0200, Jean Delvare wrote:
> > I would like to avoid having to update this list each time a new CPU
> > model is released. Are there more K8 models scheduled to be released?
> 
> I am not aware of other models. I think the ASB1 parts were the last
> updates of that CPU family. Those Athlon/Turion Neo CPUs are on the
> market for quite some time now. I've encountered that problem because
> I have such a CPU in my Laptop.
> 
> > If there are, we should come up with a better test, either by
> > defaulting to no offset if all newer models don't need it, or by using
> > a socket-based detection as we do in the k10temp driver, assuming this
> > is available on the K8 as well.
> 
> Unfortunately on K8 socket type information is not provided with CPUID
> like its done for family 0x10. Thus the socket type must be derived
> from the CPU revision and information contained in the CPU revision
> guide.
> 
> I think (hope) that this list needs no update anymore.

OK, let's keep the code the way it is then. I'll send the patch to
Linus for 2.6.35 with the next batch.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
