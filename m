From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 18 Jun 2012 02:07:04 +0000
Subject: Re: [lm-sensors] [PATCH 92/95] hwmon: (smsc47m1) Convert to use devm_ functions
Message-Id: <20120618020704.GA17389@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-93-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-93-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 17, 2012 at 04:57:05PM -0400, Jean Delvare wrote:
> On Fri, 15 Jun 2012 08:24:13 -0700, Guenter Roeck wrote:
> > Convert to use devm_ functions to reduce code size and simplify the code.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/smsc47m1.c |   40 ++++++++--------------------------------
> >  1 file changed, 8 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> > index b5aa38d..b3a38af 100644
> > --- a/drivers/hwmon/smsc47m1.c
> > +++ b/drivers/hwmon/smsc47m1.c
> > @@ -584,13 +584,11 @@ static void smsc47m1_restore(const struct smsc47m1_sio_data *sio_data)
> >  
> >  #define CHECK		1
> >  #define REQUEST		2
> > -#define RELEASE		3
> >  
> >  /*
> >   * This function can be used to:
> >   *  - test for resource conflicts with ACPI
> >   *  - request the resources
> > - *  - release the resources
> >   * We only allocate the I/O ports we really need, to minimize the risk of
> >   * conflicts with ACPI or with other drivers.
> >   */
> > @@ -642,21 +640,13 @@ static int smsc47m1_handle_resources(unsigned short address, enum chips type,
> 
> This function can now be marked __init.
> 
Done.

> Other than this, I have no issue with the patch.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
