From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 20:21:48 +0000
Subject: Re: [lm-sensors] [PATCH] Allow it87.c to handle IT8720
Message-Id: <20081007222148.1664a16b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
In-Reply-To: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc, Frank,

On Tue, 07 Oct 2008 09:55:29 -0400, Frank Myhr wrote:
> Hi Jean-Marc,
> 
> Your patch looks good to me with a few niggles:
> 
> 
> > To:
> > LKML <linux-kernel@vger.kernel.org>, "LM Sensors"
> > <lm-sensors@lm-sensors.org>
> 
> I don't know if it's necessary/recommended to submit directly to LKML in
> addition to the lm-sensors list. (Maybe somebody else can comment on that.)

My personal opinion is that flooding LKML with patches which can be
handled on specific mailing lists is pointless. I don't expect anyone
on LKML to pay attention to this patch, so it's only adding to the
160k+ mails that go to the LKML every year.

But I've been bashed in the past for asking people to not post to LKML,
so now I'm keeping quiet.

> 
> 
> > The goal of this patch is to allow it87.c to handle IT8720 chipset
> > like IT8718 in order to retreive voltage, temperatures and fans speed
> > from sensors tools.
> > 
> > JMS
> > 
> > Patch also attached.
> 
> Good description but the "Patch also attached" is superfluous; your
> [PATCH] subject line already says that. I believe these comments are
> copied verbatim into the kernel git changelog, so it's important to keep
> them succinct.
> 
> More importantly, you need to sign your patch with:
> 
> Signed-off-by: [your real name] [your email address]
> ---
> 
> 
> > --- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02
> > 09:04:44.000000000 -0400
> > +++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-06
> > 13:27:08.000000000 -0400
> 
> Please make sure your mailer is not wrapping lines, it looks here like
> it is.

And it is also converting tabs to space, so I can't apply the patch. At
least the attached copy doesn't have this problem, but if you can get
your e-mail client to behave so that you no longer have to provide the
patches as attachments, it's preferred.

I second everything else Frank said above.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
