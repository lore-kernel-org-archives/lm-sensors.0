From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Apr 2012 12:46:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (fam15h_power) Fix pci_device_id array
Message-Id: <20120426124652.GA5830@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335387009-16512-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1335387009-16512-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 26, 2012 at 02:21:56AM -0400, Jean Delvare wrote:
> On Wed, 25 Apr 2012 13:50:09 -0700, Guenter Roeck wrote:
> > pci_match_id() takes an *array* of IDs which must be properly zero-
> > terminated.
> 
> Good catch, sorry for not seeing it.
> 
> > Reported-by: Ben Hutchings <ben@decadent.org.uk>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/fam15h_power.c |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> > index 37a8fc9..e8e18ca 100644
> > --- a/drivers/hwmon/fam15h_power.c
> > +++ b/drivers/hwmon/fam15h_power.c
> > @@ -128,17 +128,20 @@ static bool __devinit fam15h_power_is_internal_node0(struct pci_dev *f4)
> >   * counter saturations resulting in bogus power readings.
> >   * We correct this value ourselves to cope with older BIOSes.
> >   */
> > +static DEFINE_PCI_DEVICE_TABLE(affected_device) = {
> > +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
> > +	{ 0 }
> > +};
> > +
> 
> Not sure why you move it here, you didn't have to, did you?
> 
checkpatch complains if I don't use DEFINE_PCI_DEVICE_TABLE, I was not sure what impact
the __devinitconst in DEFINE_PCI_DEVICE_TABLE has to a local variable, and I did not want
to be the first one trying. Mostly it was to play safe.

> Other than this:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
