From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 May 2011 20:44:28 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Fix TjMax detection
Message-Id: <1306874668.2163.649.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306851320-7851-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306851320-7851-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, 2011-05-31 at 13:15 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 31 May 2011 07:15:20 -0700, Guenter Roeck wrote:
> > Commit a321cedb12904114e2ba5041a3673ca24deb09c9 excludes CPU models 0xe, 0xf,
> > and 0x16 from TjMax temperature adjustment, even though several of those CPUs
> > are known to have TiMax other than 100 degrees C, and even though the code in
> > adjust_tjmax() explicitly handles those CPUs and points to a Web document
> > listing several of the affected CPU IDs.
> 
> Good catch. Tested on a Core Duo T2600 (model ID 0xe), your patch gets
> rid of the "TjMax is assumed as 100 C!" warning message.
> 
> > Reinstate TjMax adjustment for CPUs with model ID 0xe, 0xf, and 0x16.
> 
> But then why not 0x1a as well? The documentation lists a number of
> Nehalem-based processors with TjMax 90 or 105°C. It seems that
> adjust_tjmax() would figure it out properly, so we should just call it?
> 
Only reason is that I wasn't sure about those.

> What about 0x1e (Lynnfield)? It was already supported prior to
> Carsten's changes. I don't know when MSR_IA32_TEMPERATURE_TARGET was
> introduced, but again I see no reason why adjust_tjmax() wouldn't be
> good for Lynnfield - at least as good as blindly assuming TjMax at
> 100°C.
> 
Same here ...

> BTW, I am curious why we read MSR_IA32_TEMPERATURE_TARGET on CPU models,
> which we know do _not_ have this MSR? This leads to a warning message
> in the logs. It would seem more logical to call adjust_tjmax() directly
> if MSR_IA32_TEMPERATURE_TARGET isn't supported.
> 
I think you are right. The warning doesn't really make sense. Maybe I
should rearrange the code to just return the value reported by
adjust_tjmax() if reading TjMax through MSR_IA32_TEMPERATURE_TARGET
fails - what do you think ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
