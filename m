From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 09 May 2008 06:46:04 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <4823F32C.6070901@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> I am very interested in opinions about this heuristic, and in test
> results. Ideally I'd like to have this committed quickly so that it
> makes it in lm-sensors 3.0.2. But I can only do that if I get enough
> positive test results in the next few days.
> 

I've tested the patch on a machine with a Siemens fscher hwmon ic and on an 
Asus motherboard with in adt 7475, both are still detected correctly with this 
patch.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
