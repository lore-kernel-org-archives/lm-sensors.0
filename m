From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 06 Jun 2006 12:00:43 +0000
Subject: [lm-sensors] [v4l-dvb-maintainer] Re: [PATCH 1/3] i2c: allow
Message-Id: <20060606120043.GB3748@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44802319.4050609@gmail.com>
In-Reply-To: <44802319.4050609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Manu:

* Manu Abraham <abraham.manu at gmail.com> [2006-06-03 15:21:58 +0400]:
> Mark M. Hoffman wrote:
> > Hi Manu:
> >
> > * Manu Abraham <abraham.manu at gmail.com> [2006-06-02 15:38:01 +0400]:
> >> The proper way to handle this, is that only the right device is 
> >> attached. Rather than making i2c to do this, subsystems should be 
> >> handling this.
> >>     
> >
> > Are you saying that the probing which is absolutely necessary for hwmon
> > should be moved out of i2c-core and into a separate hwmon subsystem?
> >   
> 
> When i say we don't do probing, i mean that the environment that which 
> hosts the device, knows what device is present. DVB does that way. There 
> might be people who doesn't like this way, but it is a fool proof 
> system, where it doesn't fail under any circumstances.
> 
> When i say probing, we search for something known. In the case of the 
> PCI subsystem this exists, but for i2c this does not exist in many 
> cases, ie the device id does not exist in many cases. So a probe is 
> meaningless, technically the other name for it is just say attach to 
> this address , rather than calling it probe, since it doesn't really probe.
> 
> 
> When this discussion comes along it reminds me of the PCI - ISA 
> discussions, why not probe for ISA devices like PCI devices ..

Yes, I understand that some devices are difficult or impossible to
detect.  And of course it is better, if you already know what device
is present, to simply attach to it rather than try to detect it on
the bus.  Nathan's patch would allow for this.  What is the problem?

> > If so, that's interesting, I guess... do you then disagree with the
> > *premise* of Nathan's patches?  I mean, "DVB which no longer probes"
> > is one of its goals after all.
> >
> > Actually, Manu: may I ask a favor?  Could you please point out what are
> > some of the most difficult and/or sticky "problem drivers" regarding
> > DVB vs. I2C, and perhaps even describe what makes each particular
> > instance such a pain for you?  I would appreciate it.
> >
> >   
> 
> Well Johannes has really clarified the issues in  the other post.

Let me first say:  if DVB people are content to use i2c_transfer() directly,
then I'm not interested in forcing anyone otherwise.  Nonetheless, there
are other people who are interested in moving the I2C subsystem forward.

I repeat: I'm not interested in forcing anyone to change their code!

> Other than what he mentioned, there are newer devices too which work 
> differently, we may like to to classify them as buggy hardware, but 
> these are not buggy (believe me)

non-sequitor

> well, these issues come up as new devices churn out, it is not becoming 
> lesser, but in fact it is just increasing. Trying to figure out 
> workarounds for all these in i2c core seems to be something that doesn't 
> seem to work at all.

What workarounds?  If you have an example driver, something *concrete*,
please point me to it.

> What i would make it in short, would be that in the end, a new device 
> comes out, and lo  patch [5/20] make i2c core adaptable to device "x" 
> This will keep on repeating and at one stage, and thus we have a huge 
> fight, i2c guys stating that this should not go into i2c. Well, where 
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> else should it go then ?

I was about to write "show me where this happened" but I guess you're
talking about the i2c_client 'command' method.  Is there anything else?

> Just stating that don't use the devices, or that manufacturers have to 
> make devices complying to Linux subsystems is no way to go about. Or 
> cripple the device such that we don't use features 1 --- 9 out of the 
> supported 10 too is not the way to go. (Just got a bit carried away, 
> been annoyed with these problems lately, eventhough not relating to this 
> discussion)

irrelevant strawman

> Other than what Johannes said and my statement above, there are 
> multiplexed devices, which the i2c core can never find out without 
> knowing the host environment, ie what card it is. So in fact to make it 
> work, we will be passing DVB subsystem specifics to i2c subsystem, which 
> is IMHO wrong.

No.  DVB would be passing I2C subsystem specifics to the I2C subsystem.
That makes perfect sense to me.  PCI is able to self-discover and doesn't
need any help.  I2C core needs help to do that.  So what?  We do what we
have to do.  Especially with bus muxes, I don't see why you would want
every I2C-using subsystem to have to solve that problem separately.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


