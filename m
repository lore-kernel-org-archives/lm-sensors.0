From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Apr 2010 08:49:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add sch5127 support to dme1737
Message-Id: <20100413104915.7bc5d5fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
In-Reply-To: <191fb4ca1001192115u22b07199h1fb4eceff0f795f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Fri, 9 Apr 2010 10:20:40 -0700, Juerg Haefliger wrote:
> Sorry for the slow response. The past few months have been quite hectic..

I can understand that...

> >> @@ -2329,10 +2431,10 @@
> >>       dme1737_sio_enter(sio_cip);
> >>
> >>       /* Check device ID
> >> -      * We currently know about SCH3112 (0x7c), SCH3114 (0x7d), and
> >> -      * SCH3116 (0x7f). */
> >> +      * We currently know about SCH3112, SCH3114, SCH3116, and SCH5127 */
> >>       reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
> >> -     if (!(reg = 0x7c || reg = 0x7d || reg = 0x7f)) {
> >> +     if (!(reg = SCH3112_ID || reg = SCH3114_ID || reg = SCH3116_ID ||
> >> +           reg = SCH5127_ID)) {
> >>               err = -ENODEV;
> >>               goto exit;
> >>       }
> >> @@ -2428,19 +2530,31 @@
> >>               company = dme1737_read(data, DME1737_REG_COMPANY);
> >>               device = dme1737_read(data, DME1737_REG_DEVICE);
> >>
> >> -             if (!((company = DME1737_COMPANY_SMSC) &&
> >> -                   (device = SCH311X_DEVICE))) {
> >> +             if ((company = DME1737_COMPANY_SMSC) &&
> >> +                 (device = SCH311X_DEVICE)) {
> >> +                     force_id = SCH3112_ID;
> >> +             } else if ((company = DME1737_COMPANY_SMSC) &&
> >> +                        (device = SCH5127_DEVICE)) {
> >> +                     force_id = SCH5127_ID;
> >> +             } else {
> >
> > I'm not fond of abusing force_id that way. I admit that it should work
> > in practice, however it could break in theory, for example if more than
> > one chip were present on a given system. I don't expect to see this any
> > time soon, but this shows the danger of writing to a global variable
> > that way. I'd rather do force_id => data->type => data->name, this is
> > cleaner and shouldn't require much mode code.
> 
> I don't understand your proposal. Could you elaborate?

I propose that you don't change the value of force_id in the driver.
This value can be set by the user and should be considered read-only by
the driver itself. The resulting code might be slightly larger, but it
is also more correct:

	/* Skip chip detection if module is loaded with force_id parameter */
	switch (force_id) {
	case SCH5127_ID:
		data->type = sch5127;
		break;
	case SCH3112_ID:
		data->type = sch311x;
		break;
	default:
		company = dme1737_read(data, DME1737_REG_COMPANY);
		device = dme1737_read(data, DME1737_REG_DEVICE);

		if ((company = DME1737_COMPANY_SMSC) &&
		    (device = SCH311X_DEVICE)) {
			data->type = sch5127;
		} else if ((company = DME1737_COMPANY_SMSC) &&
			   (device = SCH5127_DEVICE)) {
			data->type = sch311x;
		} else {
			err = -ENODEV;
			goto exit_kfree;
		}
	}

	data->name = data->type = sch5127 ? "sch5127" : "sch311x";

> >>                       err = -ENODEV;
> >>                       goto exit_kfree;
> >>               }
> >>       }
> >> -     data->type = sch311x;
> >>
> >> -     /* Fill in the remaining client fields and initialize the mutex */
> >> -     data->name = "sch311x";
> >> +     if (force_id = SCH5127_ID) {
> >> +             data->type = sch5127;
> >> +             data->name = "sch5127";
> >> +     } else {
> >> +             data->type = sch311x;
> >> +             data->name = "sch311x";
> >> +     }
> >
> > This assumes that force_id MUST be either SCH5127_ID or any of
> > SCH311x_ID. This is true, but this is enforced in a different function
> > (dme1737_isa_detect), so it's hard to guarantee that it will always be
> > the case in the future.
> 
> Is this just a comment or do you want me to make changes? What would
> be your suggestion?

This is related to the issue above, so the problem will go away if you
follow my advice above.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
