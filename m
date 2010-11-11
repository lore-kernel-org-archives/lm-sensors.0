From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 11 Nov 2010 19:35:48 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] intel_mid_thermal: clean up
Message-Id: <1289504148.22931.350.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101111154919.12776.42338.stgit@localhost.localdomain>
In-Reply-To: <20101111154919.12776.42338.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2010-11-11 at 13:31 -0500, Guenter Roeck wrote:
> On Thu, 2010-11-11 at 13:03 -0500, Alan Cox wrote:
> > On Thu, 11 Nov 2010 17:46:53 +0100
> > Luca Tettamanti <kronos.it@gmail.com> wrote:
> > 
> > > On Thu, Nov 11, 2010 at 4:49 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > From: Alan Cox <alan@linux.intel.com>
> > > >
> > > > Polish and tidy
> > > > - Use pr_fmt
> > > > - Printing prune
> > > > - Tidy comments/spelling
> > > > - Handle errors registering with the thermal zone
> > > > - Propogate errors back from conversion more cleanly
> > > > - Remove name based hack in identifying direct channel
> > > 
> > > Hi Alan,
> > > this is a new driver, why are you sending a separate incremental patch
> > > with fixes instead of a single one?
> > 
> > Was keeping the authorship straight. I'll post a merged copy for review
> > reference.
> 
> Alan,
> 
> if you don't mind, it would be great if you could send a copy of the
> merged patch to the linux kernel mailing list. That would give me a
> chance to pull it from patchwork.kernel.org if our mailer acts up.
> 
Never mind - turns out I can pull the raw patches from marc.info. Thanks
to Jean for the information.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
