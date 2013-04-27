From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Apr 2013 14:12:04 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130427161204.3957686c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
	<63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
	<20130427140331.GL17771@kw.sim.vm.gnt>
In-Reply-To: <20130427140331.GL17771@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Arnaud Ebalard <arno@natisbad.org>, Guenter Roeck <linux@roeck-us.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Olivier Mouchet <olivier.mouchet@gmail.com>

On Sat, 27 Apr 2013 16:03:31 +0200, Simon Guinot wrote:
> On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
> > +	/*
> > +	 * Set default configuration values before passing the structure
> > +	 * to OF helpers to overload them using those provided by .dts
> > +	 * file (if any). Final config is then commited.
> > +	 */
> > +	g762_config_init(&conf);
> > +	g762_config_of_overload(client, &conf);
> > +	err = g762_config_commit(client, &conf);
> > +	if (err)
> > +		goto out;
> 
> One more comment... Sorry for the multiple replies :)
> 
> I am not sure that applying a configuration anyway is a good idea.
> I think it could be best to stick with the bootloader configuration if
> no platform data nor device tree data are given.

FWIW, the common policy for hwmon drivers is actually to not change the
device configuration unless they really have to.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
