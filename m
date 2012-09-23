From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Sep 2012 17:06:11 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon, fam15h_power: Tweak runavg_range on resume
Message-Id: <20120923190611.312cf6fd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120920103408.GD4602@alberich>
In-Reply-To: <20120920103408.GD4602@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 20 Sep 2012 09:35:39 -0700, Guenter Roeck wrote:
> On Thu, Sep 20, 2012 at 12:34:08PM +0200, Andreas Herrmann wrote:
> > 
> > The quirk introduced with commit
> > 00250ec90963b7ef6678438888f3244985ecde14 (hwmon: fam15h_power: fix
> > bogus values with current BIOSes) is not only required during driver
> > load but also when system resumes from suspend. The BIOS might set the
> > previously recommended (but unsuitable) initilization value for the
> > running average range register during resume.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > ---
> >  drivers/hwmon/fam15h_power.c |   15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > Hi Jean,
> > 
> > Thanks for spotting the issues.
> > Here's a new patch version, esp. to fix the section mismatch.
> > 
> > Please apply.
> > 
> > 
> > Thanks,
> > 
> > Andreas
> > 
> > diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> > index 2764b78a784b..af69073b3fe8 100644
> > --- a/drivers/hwmon/fam15h_power.c
> > +++ b/drivers/hwmon/fam15h_power.c
> > @@ -129,12 +129,12 @@ static bool __devinit fam15h_power_is_internal_node0(struct pci_dev *f4)
> >   * counter saturations resulting in bogus power readings.
> >   * We correct this value ourselves to cope with older BIOSes.
> >   */
> > -static DEFINE_PCI_DEVICE_TABLE(affected_device) = {
> > +static const struct pci_device_id affected_device[] = {
> 
> I would prefer if we could keep DEFINE_PCI_DEVICE_TABLE to avoid the
> checkpatch warning. Should be easy to implement, by moving pci_match_id
> into the probe function and only call tweak_runavg_range() if it returns true.
> You could keep the response in fam15h_power_data, as a flag such as needs_tweak,
> for use in fam15h_power_resume().
> 
> Just my $0.02, though. I'll leave it up to Jean to decide if the patch is ok
> as-is. 

I'll apply the patch as is. The warning from checkpatch is a false
positive, it happens sometimes and that's no reason for changing
working, tested code. Especially for a code change I'll push upstream
right before a release, and which should go to stable kernels, keeping
the patch simple is a must.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
