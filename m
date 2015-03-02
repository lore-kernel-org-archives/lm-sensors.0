From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 02 Mar 2015 07:39:53 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <20150302083953.37dd3029@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Taz,

On Sat, 28 Feb 2015 14:13:07 +0100, Taz wrote:
> 
> I had to revert to first patch set : new patch consumes 30%  CPU
> on my system (or 6% global CPU on Atom D510@1.66GHz).
> 
> I let it ran a few minutes from 13h56 to 14h00, then when seeing 
> abnormal CPU consumption, I reverted it.

Yes, I see the same here :( What happens is that there is no stdin to
read from when the script is run by systemd, so the read command
returns immediately with an error instead of actually waiting.

I'll revert to the previous solution for now, finish the investigation
and see if I can come up with something better, report to upstream
again if needed, and commit the result.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
