From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jun 2008 07:21:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (thmc50) Safer device detection
Message-Id: <20080612092104.33c612f4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080611172904.418df3a1@hyperion.delvare>
In-Reply-To: <20080611172904.418df3a1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

Switching back to the mailing list.

On Thu, 12 Jun 2008 07:20:05 +0200, Krzysztof Helt wrote:
> On Wed, 11 Jun 2008 22:41:25 +0200, Jean Delvare wrote:
> > On Wed, 11 Jun 2008 20:34:29 +0200, Krzysztof Helt wrote:
> > > This open-ended aproach for the original thmc50 worked well for us, as 
> > > user with the thmc51 was able to use the thmc50 without any modification.
> > > It doesn't show everything correctly (the thmc51 hea one temperature less)
> > > but the thmc50 compatible functionality simply works.
> > 
> > That's true, but what would have happened if the THMC51 was not
> > compatible with the THMC50? Your driver writes to some registers at
> > initialization time (and then exposes more registers via sysfs), this
> > could have done some damage.
> 
> It should not happen if I the chips are from the same family. It is actually
> true, as the thmc51/adm1028 have only missing some bits in registers
> used by previous chips. All existing bits are the same.

You are focusing on the case where a supported chip is matched
correctly, because that's what happened to you. You don't seem to
consider the case where an unsupported chip is matched. That's what I
am worried about and what my patch is trying to prevent.

> > > I would leave this open-ended construction to support next version chips
> > > from this family. I admit that I am not aware if such a chip exists (from
> > > Texas Instrument or from Analog Devices).
> > 
> > Given how old these chips are, I'd guess not, we would probably have
> > heard of them by now. But OTOH I have to admit that the THMC51 took me
> > by surprise ;)
> 
> On the other hand, do you know a chip which is not compatible with thmc50
> /thmc51 and can be misdetected by the driver?

The W83792D could be misdetected. It uses registers 0x3e and 0x3f to
store the LSBs of voltage measurements. So basically it has 2 chances
out of 2^(8+2) (i.e. 1/512) to be misdetected by the thmc50 driver.
With my proposed change we'd be at 1/1024, which is somewhat better.

The VT1211 is a possible candidate as well, it has a low voltage limit
at 0x3e those value could be basically anything the user wants, and a
stepping ID at 0x3f those value is not clearly documented and
surprisingly writable.

These are only two examples, I'm not going to check all the datasheets
for all I2C devices out there. Suffice to say that the risk exists.

> If the thmc50 did not allow detection of the thmc51 from the beginning
> I would never know about the problem with thmc51 chip.

You would have, if you and the user did the things in the right order.
That is: run sensors-detect, observe an unknown chip at 0x2e which is a
typical address for hardware monitoring chips, take a dump of the chip,
notice value 0x49 at 0x3e which suggests a chip by Texas Instruments,
read the technical documentation and see it mentions a THMC51, guess
from the name of the chip that it might be compatible with the THMC50.

> > > The only reason to accept this patch is if there is a chip from another
> > > family which has revision value greater than 0xdf in the same register.
> > > In such a case, the patch gives as protection against wrong detection of chip type.
> > > Otherwise, it is just additional code either dead (no next chip version exists) 
> > > or disabling people with next generation of sensors from the thmc50 family
> > > (their chips won't be supported at all).
> > 
> > We have no proof that such devices do not exist. 
> 
> Lack of proof is not a proof.

This one works both ways ;)

> We do not have a proof that the next version of thmc51/adm1028 does not
> exist either.

We have a strong suspicion, I'd say. As I already said, I2C doesn't
offer a standard way to identify chips so it's always a trade-off
between risk of false positives and risk of false negative.

> > We have module
> > parameters to force the i2c chip drivers to attach to arbitrary devices
> > if needed. I prefer having to point users to these parameters, than
> > having to explain to them why loading a given driver had unexpected side
> > effects.
> 
> The problem here is that an average user is not capable of guessing
> these parameters.

This is fully documented (although maybe not where it should be.) I
admit that the current interface to force a given chip is less than
user-friendly, I'm working on it.

> Even if he can find the chip on the motherboard
> how he can guess that he needs the thmc50 driver for a chip
> called, say, adm1042?

This has absolutely nothing to do with the problem at hand. We can't
document compatibility of devices we've never heard about, no matter
you look at it.

> But if he can load the thmc50 module and find out that something
> wrong is displayed (missing temperature) or something wrong
> happened (computer reset/freeze) he will usually report this
> so we will know.

So you suggest that users with unsupported chips try loading all hwmon
drivers until one works? That's a very bad thing to suggest. This could
lead to all sorts of problems. Of course we do our best to prevent our
drivers from attaching to devices they don't support, but then again
it's best effort, we really can't guarantee anything.

Interestingly enough, your suggestion is exactly the reason why I want
our drivers to be strict in what register values they accept during
detection. If a user loads drivers at random, we want to limit the risk
of false positive matches. The strategy you took in your driver is the
opposite, meaning that users really shouldn't load drivers at random.

> > Note that I didn't invent the code that is my patch, that's exactly
> > what sensors-detect does.
> 
> Who wrote it?

That would be me, in February 2007. So, OK, I did invert it after
all ;) My point was that the code has been around for some time already
and so far nobody reported about a chip that would no longer be
detected. That's why I think it is safe to to the same in the thmc50
driver.

Anyway, I'm not going to argue any longer with you on this. I said what
I think should be done. If you don't agree, and any user complains in
the future, I'll redirect him/her to you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
