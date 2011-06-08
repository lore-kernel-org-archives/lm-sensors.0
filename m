From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 08 Jun 2011 06:36:19 +0000
Subject: Re: [lm-sensors] Question about coretemp ttarget
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095AFBD6A4@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110607212722.14cafbfb@endymion.delvare>
In-Reply-To: <20110607212722.14cafbfb@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean/Guenter,

I did not forget about the To Do patch..and was working on it..
Suddenly got to do other things..

Will submit it in a couple of days.
Sorry about the delay.

Thanks,
Durga
> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Wednesday, June 08, 2011 1:06 AM
> To: Jean Delvare
> Cc: Yu, Fenghua; R, Durgadoss; LM Sensors
> Subject: Re: Question about coretemp ttarget
>=20
> On Tue, Jun 07, 2011 at 03:27:22PM -0400, Jean Delvare wrote:
> > Hi Durgadoss, Fenghua and Guenter,
> >
> > With commit 199e0de7f5df31a4fc485d4aaaf8a07718252ace (hwmon: (coretemp)
> > Merge pkgtemp with coretemp), the following piece of code was added to
> > the coretemp driver:
> >
> > +static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
> > +                               struct device *dev)
> > +{
> > +       int err;
> > +       u32 eax, edx;
> > +
> > +       /*
> > +        * Initialize ttarget value. Eventually this will be
> > +        * initialized with the value from MSR_IA32_THERM_INTERRUPT
> > +        * register. If IA32_TEMPERATURE_TARGET is supported, this
> > +        * value will be over written below.
> > +        * To Do: Patch to initialize ttarget from MSR_IA32_THERM_INTER=
RUPT
> > +        */
> > +       tdata->ttarget =3D tdata->tjmax - 20000;
> >
> > I have questions and concerns about this (on top of the fact that this
> > side change was not documented and should have been submitted as a
> > separate patch, if it is really correct.)
> >
> > 1* Where does the magic 20=B0C constant come from? Is this just an
> >    arbitrary approximation, or is it really correct?
> >
> > 2* Do all Intel CPUs with DTS really have a target temperature? So far,
> >    the tempX_max limit (which corresponds to ttarget) was only created
> >    conditionally, on new CPU models. Older models did not have it. As a
> >    matter of fact, the documentation file says that the feature is only
> >    available since Core 2. Please remember that we do NOT want to
> >    present fake limits to user-space. Any limit exposed to user-space
> >    should correspond to a real attribute of the CPU (or core.)
> >
> > 3* Why is the "to do" item not done yet? We have already just made
> >    significant changes to the coretemp driver, which break user-space
> >    compatibility to some degree. I don't want to do it again with the
> >    next kernel version. So if MSR_IA32_THERM_INTERRUPT can be used to
> >    get a better value for tdata->ttarget, then please let's implement
> >    it properly right now, for kernel 3.0.
> >
> > If anyone has comments on this, please speak up.
> >
> Durgadoss wanted to submit a separate patch to address the "To Do".
> I don't know what happened to it.
>=20
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
