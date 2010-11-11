From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 11 Nov 2010 18:03:31 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] intel_mid_thermal: clean up
Message-Id: <20101111180331.55d79fcd@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101111154919.12776.42338.stgit@localhost.localdomain>
In-Reply-To: <20101111154919.12776.42338.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Nov 2010 17:46:53 +0100
Luca Tettamanti <kronos.it@gmail.com> wrote:

> On Thu, Nov 11, 2010 at 4:49 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > From: Alan Cox <alan@linux.intel.com>
> >
> > Polish and tidy
> > - Use pr_fmt
> > - Printing prune
> > - Tidy comments/spelling
> > - Handle errors registering with the thermal zone
> > - Propogate errors back from conversion more cleanly
> > - Remove name based hack in identifying direct channel
> 
> Hi Alan,
> this is a new driver, why are you sending a separate incremental patch
> with fixes instead of a single one?

Was keeping the authorship straight. I'll post a merged copy for review
reference.

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
