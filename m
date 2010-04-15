From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 15 Apr 2010 01:27:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for intel PCI thermal
Message-Id: <20100414212748.ad4c3187.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1260546750-6206-1-git-send-email-mjg@redhat.com>
	<20100403170917.GA11397@srcf.ucam.org>
	<20100411102414.15b9b394@hyperion.delvare>
In-Reply-To: <20100411102414.15b9b394@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sun, 11 Apr 2010 10:24:14 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> Hi Matthew,
> 
> On Sat, 3 Apr 2010 18:09:17 +0100, Matthew Garrett wrote:
> > On Fri, Dec 11, 2009 at 10:52:30AM -0500, Matthew Garrett wrote:
> > > Recent Intel chipsets have support for a PCI device providing access
> > > to on-board thermal monitoring. Previous versions have merely used this
> > > to allow the BIOS to set trip points, but Ibex Peak documents a set of
> > > registers to read values. This driver implements an hwmon interface to
> > > read them.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > Jean, did you pick this up at any point? I can't see it in your git 
> > tree.
> 
> Maybe because I don't have a git tree ;) I'm using quilt for my hwmon
> patches.
> 
> Anyway, no, I did not pick this driver, I don't think I saw a public
> review of it, and normally I only pick patches which have been reviewed
> by someone I trust. Remember I am not the maintainet of the hwmon
> subsystem any longer. I'm trying to help as my time permits, but I make
> no guarantee.

I handle hwmon patches which Jean doesn't take or nack.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
