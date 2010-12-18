From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 18 Dec 2010 15:31:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218153149.GB1506@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
 <1292624661-32474-1-git-send-email-mjg@redhat.com>
 <20101218042320.GA14104@ericsson.com>
 <20101218090714.GA436@polaris.bitmath.org>
 <20101218144049.GA21801@srcf.ucam.org>
In-Reply-To: <20101218144049.GA21801@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

> I tested under EFI and BIOS. NOTIFICATION_KEY is there for adding 
> interrupt support - I got that hooked up but it seems that the latest 
> Air is lacking the sudden motion sensor (probably because it's an 
> SSD-only model) so wasn't able to test it. I'll play some more and add a 
> further patch for that.

Sounds interesting. Please add the define in that patch instead.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
