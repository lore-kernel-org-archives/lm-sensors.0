From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 18 Sep 2009 08:01:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090918080151.GA7905@sortiz.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 18, 2009 at 09:42:41AM +0200, Jean Delvare wrote:
> Hello Samuel,
> 
> On Thu, 17 Sep 2009 16:34:45 +0200, Samuel Ortiz wrote:
> > On Thu, Sep 17, 2009 at 03:34:50PM +0200, Jean Delvare wrote:
> > > But then again I don't know if there is already a policy regarding this
> > > for MFD drivers. Samuel?
> >
> > If your subdevice driver is calling some of the MFD core routines, or if
> > there's a platform dependency, then your subdevice driver (w83627hf in that
> > case) Kconfig should depend on MFD_W83627HF.
> 
> Isn't it allowed to do it the other way around, using select? Due to
> the history of the w83627hf driver, I fear that users will just see the
> hwmon driver they were using disappear, and they will not necessarily
> think of checking in MFD. So I expect a high number of support requests
> about this.
Makes sense. In that case, it'd be perfectly fine to select the MFD core from
the hwmon Kconfig entry, yes.

Cheers,
Samuel.


> -- 
> Jean Delvare

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
