From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Fri, 11 Dec 2009 16:33:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for intel PCI
Message-Id: <20091211163328.GA1596@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1260546750-6206-1-git-send-email-mjg@redhat.com> <68676e00912110828q26e511edt52546f09490c9431@mail.gmail.com>
In-Reply-To: <68676e00912110828q26e511edt52546f09490c9431@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Dec 11, 2009 at 05:28:37PM +0100, Luca Tettamanti wrote:
> On Fri, Dec 11, 2009 at 4:52 PM, Matthew Garrett <mjg@redhat.com> wrote:
> > Recent Intel chipsets have support for a PCI device providing access
> > to on-board thermal monitoring. Previous versions have merely used this
> > to allow the BIOS to set trip points, but Ibex Peak documents a set of
> > registers to read values. This driver implements an hwmon interface to
> > read them.
> 
> Does it plays nice with other drivers?
> More specifically: is it possible to load the native driver and this
> one (which I presume pokes at the same chip) at the same time?

What do you mean by native driver? This is a native driver for the chip 
in question.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
