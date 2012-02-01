From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Feb 2012 07:12:49 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm
Message-Id: <20120201081249.70f414f1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 31 Jan 2012 14:03:02 -0800, Guenter Roeck wrote:
> On Tue, 2012-01-31 at 16:38 -0500, Jean Delvare wrote:
> > On Wed, 25 Jan 2012 04:43:34 -0800, Guenter Roeck wrote:
> > > +MODULE_PARM_DESC(vrm, "VRM/VRD version, multiplied by 10");
> > 
> > This is no longer always true, as explained in doc/vid in the
> > lm-sensors source tree. This document should probably be updated and
> > moved to the kernel tree.
>
> Makes sense. Documentation/hwmon/hwmon-vid ?

Yes.

> > > (...)
> > > @@ -288,19 +305,38 @@ u8 vid_which_vrm(void)
> > >  		vrm_ret = get_via_model_d_vrm();
> > >  	if (vrm_ret = 0)
> > >  		pr_info("Unknown VRM version of your x86 CPU\n");
> > > -	return vrm_ret;
> > > +
> > > +	vrm = vrm_ret;
> > 
> > Isn't this overriding the module parameter passed by the user?
>
> Yes. That was on purpose, since the resulting vrm can then be accessed
> by userland through the respective sysfs entry. I thought that was a
> good idea. Maybe not ?

Forget about this. Being unable to apply the patch, I couldn't read the
function in its entirety. I was commenting on a code flow which cannot
actually happen.

> > > (...)
> > > +static void __exit vid_exit(void)
> > > +{
> > > +}
> > 
> > Do you really have to create that stub?
>
> I think so. The driver refuses to unload if it does not exist.

OK, good to know.

> (...)
> To retain the ability to compile the code, I'll have to provide a single
> patch for all affected files. Is that ok ?

If you have to do that, it's OK. We've seen much much larger patches
before.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
