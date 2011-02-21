From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 21 Feb 2011 09:45:49 +0000
Subject: Re: [lm-sensors] [PATCH-v2:RFC][hwmon]:Merging_Pkgtemp_with_Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109471C58B0@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Sorry for the delayed response due to the weekend.

> I tried to install your patch, but must have done something wrong - it crashes
> for
> me with a null pointer access. System is running 2.6.35, so it might not be the
> driver's fault but something I missed while backporting it.
> 

Yes. This patch will apply cleanly on any kernel version above 2.6.36-stable.
I prefer creating these patches on 2.6.38-rc4.
I should have specified it while sending the patch..Sorry that I missed it.


> > +static DEFINE_MUTEX(update_lock);
> >
> Not a good idea. You don't want any global variables.

Ok. Shall move it back into the structure.

> > +/* Attributes per physical CPU */
> > +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, DRV_NAME);
> > +static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_tjmax, NULL, 0);
> > +/* Coretemp attributes */
> > +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, COREID);
> > +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_ttarget, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_crit_alarm, NULL,
> 0);
> > +/* Packagetemp attributes */
> > +static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_name, NULL,
> PHYS_PROCID);
> > +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> > +static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_ttarget, NULL, 1);
> > +static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_crit_alarm, NULL,
> 1);
> >
> Still not the right approach here. I could not test the driver, but since you
> only have two sets of sensors it can not do what it is supposed to do if there
> are multiple cores. Again, we would expect a single instance of the driver
> to handle all cores plus the package sensor. Looks like you merged core temp
> with pkg temp, but you still create an instance of the driver per core.
> And I am not sure if the package temp now shows up on each core.

I think we are missing something here.

In 2.6.35 version of the coretemp, there is no #ifdef CONFIG_SMP
in the probe function. This creates a hwmon device for every core
Of the CPU. (In fact I verified this in one board that was running
2.6.35 kernel. Though the board had only One physical CPU, there were
two instances of the hwmon device, Created by Coretemp. And both of them
showed exactly same temperature always.)
The same board running a 2.6.37 showed only one hwmon device.
Then I figured out that this is due to the SMP check in the probe
function. This check eliminates the creation of redundant coretemp attributes.
(These were created for all cores in a Physical CPU in older kernels)
Hence, in newer kernels, there will be one set of attributes(temp1*) for all cores
in a Physical CPU created by Coretemp and other set (temp2*) of attributes for PKG temp.

Kindly correct me if I am wrong.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
