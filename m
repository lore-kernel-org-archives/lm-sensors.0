From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 May 2010 12:36:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add sch5127 support to dme1737
Message-Id: <20100519143615.54087d3e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
In-Reply-To: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 13 Apr 2010 10:49:15 +0200, Jean Delvare wrote:
> On Fri, 9 Apr 2010 10:20:40 -0700, Juerg Haefliger wrote:
> > I don't understand your proposal. Could you elaborate?
> 
> I propose that you don't change the value of force_id in the driver.
> This value can be set by the user and should be considered read-only by
> the driver itself. The resulting code might be slightly larger, but it
> is also more correct:
> 
> 	/* Skip chip detection if module is loaded with force_id parameter */
> 	switch (force_id) {
> 	case SCH5127_ID:
> 		data->type = sch5127;
> 		break;
> 	case SCH3112_ID:
> 		data->type = sch311x;
> 		break;
> 	default:
> 		company = dme1737_read(data, DME1737_REG_COMPANY);
> 		device = dme1737_read(data, DME1737_REG_DEVICE);
> 
> 		if ((company = DME1737_COMPANY_SMSC) &&
> 		    (device = SCH311X_DEVICE)) {
> 			data->type = sch5127;
> 		} else if ((company = DME1737_COMPANY_SMSC) &&
> 			   (device = SCH5127_DEVICE)) {
> 			data->type = sch311x;
> 		} else {
> 			err = -ENODEV;
> 			goto exit_kfree;
> 		}
> 	}
> 
> 	data->name = data->type = sch5127 ? "sch5127" : "sch311x";

Any progress with this patch? Would be nice to finally have support for
the SCH5127 in kernel 2.6.35.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
