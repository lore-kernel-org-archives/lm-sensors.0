From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 23 Jun 2013 18:07:08 +0000
Subject: Re: [lm-sensors] [PATCHv8 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <87r4fsem5v.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87a9mkttxr.fsf@natisbad.org>
	<20130623153931.GD7626@kw.sim.vm.gnt>
	<20130623160659.GB17536@roeck-us.net>
In-Reply-To: <20130623160659.GB17536@roeck-us.net> (Guenter Roeck's message of
	"Sun, 23 Jun 2013 09:06:59 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Simon Guinot <simon.guinot@sequanux.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

> On Sun, Jun 23, 2013 at 05:39:32PM +0200, Simon Guinot wrote:
>> On Thu, Jun 20, 2013 at 10:21:04PM +0200, Arnaud Ebalard wrote:
>> > 
>> > GMT G762/763 fan speed PWM controller is connected directly to a fan
>> > and performs closed-loop or open-loop control of the fan speed. Two
>> > modes - PWM or DC - are supported by the chip. Introduced driver
>> > provides various knobs to control the operations of the chip (via
>> > sysfs interface). Specific characteristics of the system can be passed
>> > either using board init code or via DT. Documentation for both the
>> > driver and DT bindings are also provided.
>> > 
>> > Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> > ---
>> > Hi Guenter,
>> > 
>> > I guess we can wait for Simon's tests against its 5Big Network to check
>> > everything is ok on another platform. Note that I also tested the patch
>> > on my (Armada 370 based) ReadyNAS 102 and it works as expected.
>> > 
>> > To be very accurate, I had to revert eda6bee6c7 to get both an out of
>> > tree driver for ISL 12057 chip and the g762 work *on the 102*, but this
>> > is an unrelated story (Debian bug #622325 [1] has more on the topic) for
>> > which I will create a separate thread. Simon, the symptom you reported
>> > for your read failures are different from those I get so I don't think
>> > the revert will fix your problem but it may be worth trying it.
>> > 
>> > [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bugb2325
>> 
>> Hi Arnaud and Guenter,
>> 
>> Actually, reverting the commit eda6bee6c7 seems to solve the -ENODEV
>> issue...
>> 
> Did you let the i2c maintainers know ?

As I wrote, I will create a separate thread on the topic. It is good to
have another unrelated example for which the problem is solved by
reverting this commit. I will keep both of you in the CC: list if you
want to follow the discussion.


>> Then, I have been able to test successfully the g762 driver against the
>> following boards:
>> 
>> - 2Big NAS (open-loop mode)
>> - 2Big Network v2 (open-loop mode)
>> - 5Big Network v2 (closed-loop mode)
>> 
>> For the last, I have also been able to configure the clock frequency
>> through the platform_data structure.
>> 
>> Tested-by: Simon Guinot <simon.guinot@sequanux.org>

Thanks for your time and efforts, Simon.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
