From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 24 Apr 2013 10:50:12 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <87ehe06w4b.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
 <20130424053758.GC8710@lunn.ch> <87obd4wb4e.fsf@natisbad.org>
 <20130424100458.GA17771@kw.sim.vm.gnt>
In-Reply-To: <20130424100458.GA17771@kw.sim.vm.gnt> (Simon Guinot's message of
 "Wed, 24 Apr 2013 12:04:59 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Guenter Roeck <linux@roeck-us.net>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Simon,

Simon Guinot <simon.guinot@sequanux.org> writes:

>> It can be used if the default params (or those configured by u-boot I
>> guess) fit your needs. I think it would be fairly easy to extend the
>> driver later to expose g762_config struct to allow parameters to be set
>> w/o using OF. If someone wants to do that, I think it is better to not
>> depend on OF in Kconfig at the moment but I have not strong argument
>> other that that one. I'll let you decide.
>
> A g762 device is embedded on the 2Big Network v2 board (net2big_v2),
> which is not DT compliant. Then, I think it could be nice to allow
> device registration from board setup files.

ok, I will try and provide that for v2 then. :-)

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
