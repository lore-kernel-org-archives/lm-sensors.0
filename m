From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Apr 2006 11:33:06 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <20060407133306.9c4bbad8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> > It is making sure the two temp sensors are enabled while preserving
> > the reserved bits (the w83792 driver is doing this also). If you reset
> > the chip the HW takes care of this. Guess I can remove the code and
> > assume the BIOS is doing the right thing when reset=0...
> 
> I dont like this "reset" or "init", i would like to drop this parameter
> and do nothing about temp2,temp3 configuration.
> because we may lose MB specific configuration if we reset the chip,
> What's your opinion?

I share your worries about possibly losing the configuration set by the
BIOS. I believe that the BIOS should always configure the hardware
monitoring chips properly (because they know exactly what features the
board has) and even if most BIOSes unfortunately don't do that, we must
respect the ones that do.

Now, having a module parameter to control what kind of reset and/or
initialization is done is fine by me, as long as the default is to
preserve the BIOS settings as much as possible.

So, enabling temp2 and temp3 should indeed not be done unconditionally.

Charles, you might want to have three degrees of initialization: only
start monitoring, or enable temp2 and temp3 beforehand, or reset the
chip beforehand. This can be done using two boolean module parameters
(reset and init), or just one parameter (init) with three values, at
your option.

-- 
Jean Delvare

