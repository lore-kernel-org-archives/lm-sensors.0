From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 09 May 2012 16:53:09 +0000
Subject: Re: [lm-sensors] Coretemp: Fix threshold attributes patch
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB59122495@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

[snip.]

> >
> > can discuss/decide and I can work on it to submit it again, with
> > changes needed,
> >
> > if any. Kindly help.
> >
> Hi Durga,
> 
> problem is that neither Jean nor me are happy with it. I think it is
> something that should, by its nature, reside in the thermal subsystem.

I agree with you. If 'configuring the thresholds' were to reside in the Thermal
subsystem, then, one driver in hwmon will report CPU temperature and another
driver in thermal will configure the thresholds for that temperature. Is this
a good approach ?

Or, we can include the threshold configuration in coretemp under #ifdef
CONFIG_THERMAL. This way even though the code resides in hwmon,
the functionality is enabled only by the Thermal Subsystem.

Or, we can register coretemp with thermal_sys.c, and expose 2 trip points,
(for Threshold1 and Threshold2) like other thermal drivers do.

Let me know your thoughts.

Thanks,
Durga
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
