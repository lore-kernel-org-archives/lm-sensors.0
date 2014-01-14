From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Jan 2014 21:52:51 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.5
Message-Id: <20140114225251.5a1f7dbf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140114165101.4958fc13@endymion.delvare>
In-Reply-To: <20140114165101.4958fc13@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jan 2014 11:00:16 -0800, Phil Pokorny wrote:
> On Tue, Jan 14, 2014 at 10:49 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Tue, 14 Jan 2014 10:39:41 -0800, Phil Pokorny wrote:
> >> On Tue, Jan 14, 2014 at 8:17 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >> New PCI ID:  141d  aka  PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 for A10-7850K
> >> and others in Kaveri family for k10temp driver.
> >>
> >> I suppose I should send a new e-mail with just the patch and description...
> >
> > Ideally two: one for the kernel and one for sensors-detect.
> >
> > But if you can't / don't want to deal with sensors-detect, just say so
> > and I'll take care of it based on the kernel patch.
> 
> It's been a while since I messed with the lm-sensors code.  I'm not
> sure of the right command to generate the patch you want.  This is the
> "svn diff" output...
> 
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect  (revision 6208)
> +++ prog/detect/sensors-detect  (working copy)
> @@ -2408,7 +2408,7 @@
>         }, {
>                 name => "AMD Family 15h thermal sensors",
>                 driver => "k10temp",
> -               detect => sub { amd_pci_detect('1603', '1403') },
> +               detect => sub { amd_pci_detect('1603', '1403', '141d') },
>         }, {
>                 name => "AMD Family 15h power sensors",
>                 driver => "fam15h_power",
> 

Committed, thanks.

New time please try to get your e-mail client configuration fixed to
not convert tabs to spaces...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
