From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 May 2014 03:15:12 +0000
Subject: Re: [lm-sensors] [RFC][PATCH v2] hwmon: add support for Sensirion SHTC1 sensor
Message-Id: <536853C0.8020406@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398985530.17142.15.camel@ltli10.sensirion.lokal>		 <5362FDA9.8080300@roeck-us.net>		 <1399064369.3019.83.camel@ltli10.sensirion.lokal>		 <20140502231528.GA5157@roeck-us.net>	 <1399338214.24993.10.camel@ltli10.sensirion.lokal>	 <53683D38.7010904@roeck-us.net> <1399341707.24993.20.camel@ltli10.sensirion.lokal>
In-Reply-To: <1399341707.24993.20.camel@ltli10.sensirion.lokal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomas Pop <tomas.pop.mff@gmail.com>
Cc: "jdelvare@suse.de" <jdelvare@suse.de>, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, johannes.winkelmann@sensirion.com

On 05/05/2014 07:01 PM, Tomas Pop wrote:
> Hi Guenter,
>
> Thanks a lot for comments and patience - with the testing you are right,
> I'm still waiting for board, where I will be able to run latest kernel
> and have the chip wired in - sorry for this...
>

No problem. Please make sure that the driver has been tested with the real
chip before the final submission.

Just wondering - don't you have a little test board to make the i2c pins
more readily available ? Such a board could be connected to any i2c adapter
and/or to a mainboard which exposes i2c pins. That is usually how I test
the various sensors I am working with. You could even sell that to the
hobbyists :-).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
