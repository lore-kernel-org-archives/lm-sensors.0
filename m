From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [CONTRIBUTION] DDC/CI tool for lm_sensors package
Message-Id: <20040822092017.0893fe37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093114999.11260.22.camel@proxima>
In-Reply-To: <1093114999.11260.22.camel@proxima>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've recently finished writing a tool which is suitable for
> communication with DDC/CI (DDC2Bi) enabled monitors (Samsung,
> NEC/Mitsubishi are known to support it) and allows querying monitor
> capabilities, reading and writing monitor controls, such as contrast,
> brightness, geometry, etc...
> 
> I'm believe, that there is some interest on this, at least googling
> shows that. ;-) The reason for contributing is simple - I've spent
> some time on this, and do not want to just this into the wastebasket.
> ;-)
> (...)
> Attached please find a patch against lm_sensors-2.8.7. I would like if
> someone will review this stuff and commit it to the CVS.

The project itself looks interesting and all, but how exactly does this
belong to lm_sensors?

I agree that there are other related drivers and tools in the lm_sensors
package already, such as the eeprom and ddcmon drivers, and the eeprom
decoding scripts. But they don't really belong there either. The only
reason they are part of the lm_sensors package is that they were written
by the lm_sensors team. It was also convenient to keep all drivers in
the same place while the interfaces and internal structures were
stabilizing, and to keep the scripts with the drivers for the same
reasons. Convenient, but certainly not very clean.

So I'd suggest that you distribute your DDC/CI tool as a separate
package. I'd rather move non-sensors things out of lm_sensors than
include new non-sensors things in it. Also, your work is more likely to
catch potential users eyes as a separata package. I doubt anyone will be
looking for such a tool in our package.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
