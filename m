From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 May 2012 15:15:49 +0000
Subject: Re: [lm-sensors] Coretemp: Fix threshold attributes patch
Message-Id: <1336576549.22553.102.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-05-07 at 11:33 -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
>  
> 
> Some time ago, you had submitted a patch to fix the usage of threshold
> attributes
> 
> in coretemp driver. But we had some discussions and it did not get
> merged.
> 
>  
> 
> I would really like to see that patch in mainline. Is there something
> that we
> 
> can discuss/decide and I can work on it to submit it again, with
> changes needed,
> 
> if any. Kindly help.
> 
Hi Durga,

problem is that neither Jean nor me are happy with it. I think it is
something that should, by its nature, reside in the thermal subsystem.

Would this be an option ?

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
