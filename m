From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 27 Nov 2011 23:58:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: convert drivers/hwmon/* to use
Message-Id: <CAF+7xWmJLNho1ToUbGJhmnkVQG4Ca_XexesNCkgGBuSBzhqOeg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322204787.11718.1.camel@phoenix> <20111125165708.GA11317@ericsson.com>
 <20111127173204.GA31171@ericsson.com>
In-Reply-To: <20111127173204.GA31171@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Dirk Eibach <eibach@gdsys.de>, David George <david.george@ska.ac.za>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, "Hans J. Koch" <hjk@hansjkoch.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Steve Glendinning <steve.glendinning@smsc.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

2011/11/28 Guenter Roeck <guenter.roeck@ericsson.com>:
> On Fri, Nov 25, 2011 at 11:57:08AM -0500, Guenter Roeck wrote:
>> On Fri, Nov 25, 2011 at 02:06:27AM -0500, Axel Lin wrote:
>> > This patch converts the drivers in drivers/hwmon/* to use the
>> > module_i2c_driver() macro which makes the code smaller and a bit
>> > simpler.
>> >
>> > Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
>> > Cc: Dirk Eibach <eibach@gdsys.de>
>> > Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
>> > Cc: Steve Glendinning <steve.glendinning@smsc.com>
>> > Cc: Riku Voipio <riku.voipio@iki.fi>
>> > Cc: Guillaume Ligneul <guillaume.ligneul@gmail.com>
>> > Cc: David George <david.george@ska.ac.za>
>> > Cc: "Hans J. Koch" <hjk@hansjkoch.de>
>> > Cc: Marc Hulsman <m.hulsman@tudelft.nl>
>> > Cc: Rudolf Marek <r.marek@assembler.cz>
>> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
>>
>> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
>>
>> What is the plan for those patches ? Are they expected to all go through the same tree,
>> or through individual trees after the necessary defines are introduced into mainline ?
>>
> My question was answered in another thread related to the misc subsystem.
> The patch this one depends on will only be available in 3.3-rc1. It would have been
> nice to let us know ahead of time, because I _did_ find out the hard way.
>
> I would suggest to resubmit the i2c and spi patches against a working baseline
> once it is available, to make sure it does not miss some new drivers.

I'll resend the patches once module_i2c_driver and module_spi_driver is merged.
Pls ignore this patch now.

Thanks,
Axel
>
> On a side note, this patch does miss the drivers in hwmon/pmbus, but I can take care
> of those myself.
>
> Guenter
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
