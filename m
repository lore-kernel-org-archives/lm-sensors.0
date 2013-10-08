From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Oct 2013 16:29:05 +0000
Subject: Re: [lm-sensors] applesmc oops in 3.10/3.11
Message-Id: <20131008162905.GA20665@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131002035156.GA566@roeck-us.net>
 <20131002095339.GA2716@polaris.bitmath.org>
 <524C1FE1.4050207@roeck-us.net>
 <20131002163418.GA4557@polaris.bitmath.org>
 <20131002164718.GA7392@roeck-us.net>
 <20131002172410.GA381@polaris.bitmath.org>
 <525346D3.30500@roeck-us.net>
 <6918F624-B267-4DB5-95A2-7E09448CA3E4@colorremedies.com>
 <20131008154809.GB18402@roeck-us.net>
 <20131008162917.GA7773@polaris.bitmath.org>
In-Reply-To: <20131008162917.GA7773@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Murphy <bugzilla@colorremedies.com>, Josh Boyer <jwboyer@fedoraproject.org>, khali@linux-fr.org, lm-sensors@lm-sensors.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Tue, Oct 08, 2013 at 06:29:17PM +0200, Henrik Rydberg wrote:
> Hi Guenter,
> 
> > > > So, what should we do with this patch ? Apply it ?
> > > 
> > > So far I'm getting nothing on the original machine. As of today it's applied as the last patch on 3.12.0-0.rc4.git0.1.fc20.x86_64. Unfortunately at the moment I'm a bit too dense to figure out how to get a new kernel applied to an existing live package so I can try this on a USB stick. While maybe unrelated, the oops was occurring at least 4x as often booted from USB stick media than HDD.
> > > 
> > 
> > Seems to me we should apply it.
> > 
> > Henrik,
> > 
> > what do you think ? Did you have time for additional testing ?
> > If you think we should apply it, please send me a signed patch.
> 
> I want to make one more test tomorrow, then I'll send a proper patch. Thanks!
> 
Ok, great.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
