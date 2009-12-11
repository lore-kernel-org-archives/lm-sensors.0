From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Fri, 11 Dec 2009 16:38:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for intel PCI
Message-Id: <20091211163822.GA1869@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1260546750-6206-1-git-send-email-mjg@redhat.com> <68676e00912110828q26e511edt52546f09490c9431@mail.gmail.com> <20091211163328.GA1596@srcf.ucam.org> <68676e00912110836p278985cfv3d052e16a22916b1@mail.gmail.com>
In-Reply-To: <68676e00912110836p278985cfv3d052e16a22916b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Dec 11, 2009 at 05:36:59PM +0100, Luca Tettamanti wrote:
> On Fri, Dec 11, 2009 at 5:33 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >> Does it plays nice with other drivers?
> >> More specifically: is it possible to load the native driver and this
> >> one (which I presume pokes at the same chip) at the same time?
> >
> > What do you mean by native driver? This is a native driver for the chip
> > in question.
> 
> I mean the driver for the hwmon chip attached to I2C/SMB bus.

This is the hwmon chip.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
