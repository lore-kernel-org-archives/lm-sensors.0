From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Sat, 11 Apr 2009 15:52:28 +0000
Subject: Re: [lm-sensors] AMD 10h core temperatures
Message-Id: <49E0BCBC.6040801@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <49DE2B23.90900@aei.mpg.de>
In-Reply-To: <49DE2B23.90900@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

Rudolf Marek schrieb:
> Unless I made some mistake in the overview the temps looks like very
> similar to reported IPMI ones right?
>

Yes and no. When I first started I had a peculiar temperature offset
which caused one CPU to be reported at 2-4K below ambient temperature
after running idle for a few minutes. Given that this is real hardware I
suspected that this business is not done yet ;)

> So far all fam10h CPUs have same bug making the temps via the k8temp
> driver inaccurate. It might work for you it might not. This is the
> reason why is still there no driver.

Pity that, since I'm growing weary of IPMI based sensors, they simply
fail too often... If there is a way to help you (or others) please let
me know, otherwise, I'll crouch back onto my heels and wait.

Cheers

carsten

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
