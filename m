From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Jun 2013 21:17:38 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <87txkzjcp9.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87li6bmjwi.fsf@natisbad.org>
	<20130615182500.GA32205@roeck-us.net>
In-Reply-To: <20130615182500.GA32205@roeck-us.net> (Guenter Roeck's message of
	"Sat, 15 Jun 2013 11:25:00 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

Hi Guenter,

Thanks for the fast feedback. I will resend a version to handle your
comments. I also noticed I forgot to correctly balance
clk_prepare_enable() by some clk_disable_unprepare() call in case of
error.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
