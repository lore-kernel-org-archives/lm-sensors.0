From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: i2c sub system
Message-Id: <20040208112116.1b9ab749.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4025D1B5.3090205@linuxmail.org>
In-Reply-To: <4025D1B5.3090205@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Perry,

Sorry for not answering your previous posts. Busy as usual. I was hoping
that someone else would take some time to answer, but it looks like the
other developers are as busy as I am myself.

Also, I guess that most people here do not have a Voodoo3 card to make
tests on. I do have one here, but never actually used it. Taking a quick
look at it, I think it only provides TV-out through a BT869 chip, no
TV-in. Anyway, I don't have much time for testing it, I'm already
fighting against my brand new Radeon 9200 video card. Maybe someday I'll
give it a try... But not now.

> I've a couple of questions regarding the i2c sub system.  The work
> I'm doing is on the 2.4.23 kernel.  For some background,  I've been
> updating the v3tv.sourceforge.net project to work with the i2c 2.8.2
> api. Previously v3tv used it's own versions of tvmixer, msp3400, and
> tuner, as well a vpx322x module.  With a few trivial patches to the
> kernel version of the first three, v3tv now uses the kernel modules. 
> I've written a new vpx3224 module, based on the vpx3220 found in the
> 2.6 kernel.  I've also stripped the i2c adapter that was part of the
> v3tv module, and am now using the i2c-voodoo3 module in the kernel.

Your project sounds very good. Using already existing stuff rather than
rewriting it is the right thing to do. The i2c subsystem was written in
a very clever way that makes busses and chips independant, so having a
single driver handle one bus and several chips at once wasn't correct.

> Since v3tv no longer provides the i2c adapter, I need to get a
> pointer to the i2c-voodoo3 adapter.  One option would be to use a
> dummy driver. From my perspective the more efficient method would be
> to have i2c_get_adapter available.
> 
> The first question, is this patch a good thing?  It adds
> i2c_get_adapter and i2c_put_adapter, based on those found in 2.6.  If
> this patch would not fly with the 2.4 maintainers, would my only
> option for getting the i2c_adapter structure pointer be to use a dummy
> i2c driver in the v3tv module?

The fact that your patch is good or not doesn't matter. No change will
be made to the i2c core in Linux 2.4 anymore. We've tried ourselves...

I don't really get why you would need it anyway. AFAIK, you don't have
to tell the i2c core on which to adapter it needs to connect a given
chip driver. It should figure that out by itself. It'll try all known
adapters and succeed where it has to.

Did I miss something?

> The second question is regarding i2c-voodoo3.  It's still somewhat
> vauge to me the distinction between the i2c and smbus protocols.
> i2c-voodoo3 uses i2c-algo-bit, which returns functionality
> I2C_FUNC_SMBUS_EMUL, as well as I2C_FUNC_10BIT_ADDR and
> I2C_FUNC_PROTOCOL_MANGLING. The i2c_adapter->id is assigned
> I2C_HW_B_VOO.  Would I2C_HW_SMBUS_VOODOO3 be more appropriate?

Basically, smbus is a subset of i2c. i2c doesn't define much things
above the way one sends raw bits on the bus. smbus defines standard ways
to dialog with chips (send bytes, words, blocks, receive them). This
subset is what most people need and is usually sufficent.

No, I2C_HW_SMBUS_VOODOO3 wouldn't be more appropriate. We use HW_SMBUS
to designate adapters that have a hardware smbus master on them (i.e.
chips you can control with commands such as "send byte X to address Y"
without having to care about bit details. We use HW_B for so-called
bit-bangers adapters, i.e. adapters for which "send byte X to address Y"
is a software command, and we have to change bits on the bus by
ourselves. The Voodoo3 boards enter this second category, so the
original name is correct.

> Looking at the 2.6 version of i2c-voodoo3, i2c_adapter->id is not 
> assigned at all.  Neither is class.  There are versions of the
> Voodoo3 that provide just a bt869 tv-out interface, and others that
> also provide tv-in.  Would it be appropriate to have class assigned 
> I2C_ADAP_CLASS_TV_ANALOG only for the tv-in version, or also for the 
> tv-out only version.

The use of IDs is not mandatory. In fact they are not used anywhere as
far as I can tell. Maybe they have been before, or original i2c coders
thought they would be someday, I can't tell. Now updating the IDs lists
is more of a burden than anything else, and we are seriously thinking of
getting rid of them all, although the step was not taken yet.

The class is something that belongs to the adapter driver. And we'll
have a single driver (i2c-voodoo3) for both tv-in and tv-out-only
boards, so there's no way we can set the class to
I2C_ADAP_CLASS_TV_ANALOG for the former and not to the later. Anyway,
that class doesn't refer to -in or -out, it's just all about analog TV,
so it's OK. I agree that the Linux 2.6 i2c-voodoo driver should declare
its class as I2C_ADAP_CLASS_TV_ANALOG, and I'll submit a patch to Greg
KH to correct that, unless you want to do so (which I would appreciate
since I am busy, as usual).

One more question: which kernel is your new driver for? You mention the
2.6 kernel but provides a patch for Linux 2.4, and also referenced i2c
2.8.2, which is a different thing again. I think that you should
concentrate on Linux 2.6. This is where new developments and important
evolutions belong.

I hope I've been of some use answering your questions, although I can't
give you much more time I fear, nor speak about things I don't
necessarily know better than you do. My views of the i2c subsystem are
mostly sensors-centric, so I may be missing the point when it comes to
video devices.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
