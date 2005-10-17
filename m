From: sevans@vmetro.com (Steve Evans)
Date: Mon, 17 Oct 2005 13:35:16 +0000
Subject: [lm-sensors] Support for Linux 2.6 only drivers
Message-Id: <507CF24DDCB8114C82ABCC09CBC1E9EE75C251@transtech-2000.transtech.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
In-Reply-To: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> >                         Is this still the current 
> development model, 
> > or are you now moving away from 2.4 support? I see from lib/chips.c 
> > that the W83627EHF device is not supported for 2.4 (yet), 
> so perhaps 
> > this is the way things are moving?
> 
> Writing drivers for Linux 2.6 only if fine. You may want to 
> add user-space support though, and this happens in the 
> lm_sensors2 project.
> There is still a minor issue with 2.6-only drivers (related to alarm
> flags) but this is being worked on. If you don't need 
> user-space support, this part can be skipped.

I will be needing user-space support, so an i2c-id.h allocation will be
required. What's the procedure there besides "You will also need to ask
us to have an ID reserved"?

> > o The driver has been written such that it should support 
> the AD7416 
> > and
> > AD7418 as well as the AD7417. These devices provide a subset of the 
> > functionality of the AD7417 (fewer inputs etc.). Unfortunately I am 
> > not able to test my code with these devices as my hardware only 
> > supports the AD7417. Would you prefer to see such support 
> present, but 
> > with an "untested" comment, or removed completely?
> 
> Depends on the amount of additional code and the probability 
> that someone needs it. It also depends on how reliable the 
> chip detection is. If the detection is poor, we can't afford 
> listing too many possible addresses.

Unfortunately the detection is a little poor. I wish vendor/device IDs
had been a compulsory part of the i2c spec! Given that the devices are
very similar I think it would be best to conditionally include (or
rather exclude) support for the AD7416 and AD7418 so that anybody
needing support for these devices will at least have a good starting
point. 
 
> It'll be easier to answer that question once we see the 
> actual driver code.

Should I send a copy of the driver to the <sensors at stimpy dot
netroedge.com> alias for comments before proceeding?

Cheers,

Steve
