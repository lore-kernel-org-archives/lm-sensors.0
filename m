From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 May 2012 17:26:50 +0000
Subject: Re: [lm-sensors] Coretemp: Fix threshold attributes patch
Message-Id: <1336584410.22553.115.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-05-09 at 12:53 -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> [snip.]
> 
> > >
> > > can discuss/decide and I can work on it to submit it again, with
> > > changes needed,
> > >
> > > if any. Kindly help.
> > >
> > Hi Durga,
> > 
> > problem is that neither Jean nor me are happy with it. I think it is
> > something that should, by its nature, reside in the thermal subsystem.
> 
> I agree with you. If 'configuring the thresholds' were to reside in the Thermal
> subsystem, then, one driver in hwmon will report CPU temperature and another
> driver in thermal will configure the thresholds for that temperature. Is this
> a good approach ?
> 
> Or, we can include the threshold configuration in coretemp under #ifdef
> CONFIG_THERMAL. This way even though the code resides in hwmon,
> the functionality is enabled only by the Thermal Subsystem.
> 
> Or, we can register coretemp with thermal_sys.c, and expose 2 trip points,
> (for Threshold1 and Threshold2) like other thermal drivers do.
> 
Actually, the thermal subsystem registers itself with the hwmon
subsystem. I don't see a hwmon driver registering itself as thermal
device. I was thinking more along the mine of
drivers/platform/x86/intel_mid_thermal.c, though I don't really know if
that model applies.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
