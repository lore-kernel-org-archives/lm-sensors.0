From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Jun 2008 19:02:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (thmc50) Safer device detection
Message-Id: <20080611210200.2e90c74e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080611172904.418df3a1@hyperion.delvare>
In-Reply-To: <20080611172904.418df3a1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 11 Jun 2008 20:34:29 +0200, Krzysztof Helt wrote:
> On Wed, 11 Jun 2008 17:29:04 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > Accepting all values >= 0xc0 as the ADM1022/THMC50 device ID is too
> > permissive. Only allow the ID range we know these devices may use.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > Krzysztof, can you please review and ack this patch? Thanks.
> 
> The patch is simple but I don't see a point of this patch.

The point is to avoid misdetection of other chips as THMC50-compatible.
Your current check uses 11 bits, which isn't much. With my change we're
up to 12 bits, which is still not much, but a little bit better.

> The thmc50 datasheet states that the first thmc50 version has revision 0xc0
> and that the next version will be 0xd0.
> Today, we know that thmc51/adm1028 have revisions starting from
> 0xd0. The adm1028 datasheet states that the first adm1028 version is 0xd0
> and that the next version would be 0xe0.

Given what we know, the datasheet THMC50 and the ADM1022 are wrong.
0xd0 is used for the THMC51 and ADM1028, respectively, not the next
revision of the THMC50 and ADM1022. Which is pretty obvious when you
think of it: the 4 LSBs are there for the revision (or stepping). So
I'm reasonably certain that the ADM1028 datasheet is equally wrong.

> This open-ended aproach for the original thmc50 worked well for us, as 
> user with the thmc51 was able to use the thmc50 without any modification.
> It doesn't show everything correctly (the thmc51 hea one temperature less)
> but the thmc50 compatible functionality simply works.

That's true, but what would have happened if the THMC51 was not
compatible with the THMC50? Your driver writes to some registers at
initialization time (and then exposes more registers via sysfs), this
could have done some damage.

> I would leave this open-ended construction to support next version chips
> from this family. I admit that I am not aware if such a chip exists (from
> Texas Instrument or from Analog Devices).

Given how old these chips are, I'd guess not, we would probably have
heard of them by now. But OTOH I have to admit that the THMC51 took me
by surprise ;)

> The only reason to accept this patch is if there is a chip from another
> family which has revision value greater than 0xdf in the same register.
> In such a case, the patch gives as protection against wrong detection of chip type.
> Otherwise, it is just additional code either dead (no next chip version exists) 
> or disabling people with next generation of sensors from the thmc50 family
> (their chips won't be supported at all).

We have no proof that such devices do not exist. That's the whole point
of my patch. As I2C/SMBus doesn't offer standard device identification
mechanisms, the rule of thumb is: play it safe. We have module
parameters to force the i2c chip drivers to attach to arbitrary devices
if needed. I prefer having to point users to these parameters, than
having to explain to them why loading a given driver had unexpected side
effects.

Note that I didn't invent the code that is my patch, that's exactly
what sensors-detect does.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
