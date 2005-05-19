From: pete4abw@comcast.net (Peter Hyman)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <1065886230.8606.7.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, I will try the latest sensors-detect and report back to you.  I
won't be able to do it until much later today or tomorrow as my daughter
is in a soccer tournament and I will be away most of today and tomorrow
(if she makes the finals -- on esp?re toujours.).

One question.  If I do NOT insert the lm90 driver, but decide to use
adm1021 (gulp), do I still need to ignore ports 0x4c and 0x4e?  I would
imagine I would ignore 0x18 and 0x4e since lm90 appears to be at 0x4c. 
Maybe I'll back up again and try.....

I'll keep you informed.  Thanks again!

On Sat, 2003-10-11 at 07:48, Jean Delvare wrote:
> > > In your original mail, you said the line was:
> > > options adm1021 ignore=0,0x18,0,0x4c,0,0x4e
> > > That is, all potential addresses disabled.
> > 
> > If that's the case, I goofed! because in my original modules.conf, I
> > had left out the 0x4e! Maybe that is what caused the failure?
> 
> Yes, that's what I think too.
> 
> > When I ignore all three addresses and type sensors, it says no sensors
> > found. I suppose I'm loading the driver and telling it to skip
> > everything it would poll?
> 
> Yes, that's it.
> 
> > I got the latest sensors-detect, and have attached the output.  It
> > still prompts me to install the adm1021 driver, and here is the
> > probing output.
> > 
> > Client found at address 0x18
> > Probing for `Analog Devices ADM1021'... Failed!
> > Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> > Probing for `Maxim MAX1617'... Failed!
> > Probing for `Maxim MAX1617A'... Failed!
> > Probing for `TI THMC10'... Failed!
> > Probing for `National Semiconductor LM84'... Failed!
> > Probing for `Genesys Logic GL523SM'... Failed!
> > Probing for `Onsemi MC1066'... Failed!
> > Probing for `National Semiconductor LM82'... Failed!
> > Probing for `National Semiconductor LM83'... Failed!
> > Client found at address 0x37
> > Client found at address 0x4c
> > Probing for `National Semiconductor LM75'... Failed!
> > Probing for `Dallas Semiconductor DS1621'... Failed!
> > Probing for `Analog Devices ADM1021'... Failed!
> > Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> > Probing for `Maxim MAX1617'... Success!
> >     (confidence 3, driver `adm1021')
> > ....clipped
> 
> It's better. Now sensors-detect leaves whatever is at 0x18 alone.
> 
> > If you notice, the chip Maxim MAX1617 is listed twice.  Near the top,
> > the probe fails.  At the bottom where I clipped the listing, it
> > succeeds!
> 
> This is normal. It isn't probing the same device each time. The first
> time, it probes the device at 0x18, which is an unknown device. With my
> new code, sensors-detect now knows it can't reasonably be an ADM1021
> clone. Good. Next, 0x4c. This is different, because the device here is a
> LM90, which is partly compatible with the ADM1021, so it *could* be a
> MAX1617, requiring the adm1021 driver. Actually, you could unload the
> lm90 driver, load the adm1021 driver instead and it would return
> resonable temperatures and limits (better believe me and don't do it, we
> know how much your system loves the adm1021 driver).
> 
> > I don't recall if this is what occurred previously.  I think I had
> > emailed you a sensors-detect listing though, so you can check there if
> > you need to.  As of now, the sensors-detect changes are still missing
> > something on my config.
> 
> I took a look, it used to detect an adm1021 clone for all three
> addresses (0x18, 0x4c and 0x4e). After my first fix, 0x18 is left apart
> (great), 0x4c is detected but the lm90 driver if prefered (great too)
> and 0x4e is still detected (*not* great). I added one extra check in
> sensors detect for the MAX1617 and the LM84 (and also for the LM75),
> which should fix the problem. Could you check it out and give it a try?
> Would be nice.
> 
> BTW, I'd be interested in a dump of devices 0x18 and 0x4e. You already
> sent them once, but they obviously changed (the one at 0x4e at least, or
> it couldn't be detected as a LM84 - and it is).
> 
> > Nonetheless, I really do appreciate your taking the time to respond!
> > Best wishes, and enjoy the weekend!!!
> 
> Thanks a lot. I also appreciate you decided to share your painful
> experience with us and the rest of our users, for the benefit of
> everyone :)
-- 
Peter Hyman
Home:(609)395-1211 Office: (609)655-1184, Fax:(609)655-0285
Stop Telemarketers.  Sign up for Do Not Call at http://donotcall.gov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 193 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031011/3d5a15b1/attachment.bin
