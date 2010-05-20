From: Tobias Klauser <tklauser@distanz.ch>
Date: Thu, 20 May 2010 09:11:26 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon: Storage class should
Message-Id: <20100520091126.GX9489@distanz.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274344488-8918-1-git-send-email-tklauser@distanz.ch>
In-Reply-To: <1274344488-8918-1-git-send-email-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Hi Jean,

On 2010-05-20 at 11:06:48 +0200, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 20 May 2010 10:34:48 +0200, Tobias Klauser wrote:
> > The C99 specification states in section 6.11.5:
> > 
> > The placement of a storage-class specifier other than at the beginning
> > of the declaration specifiers in a declaration is an obsolescent
> > feature.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  drivers/hwmon/emc1403.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> > index 28cca34..0e4b564 100644
> > --- a/drivers/hwmon/emc1403.c
> > +++ b/drivers/hwmon/emc1403.c
> > @@ -308,7 +308,7 @@ static const unsigned short emc1403_address_list[] = {
> >  	0x18, 0x2a, 0x4c, 0x4d, I2C_CLIENT_END
> >  };
> >  
> > -const static struct i2c_device_id emc1403_idtable[] = {
> > +static const struct i2c_device_id emc1403_idtable[] = {
> >  	{ "emc1403", 0 },
> >  	{ }
> >  };
> 
> Good catch. I've folded your fix into the original patch, as it isn't
> upstream yet.
> 
> Could this error be caught by checkpatch.pl in the future? It seems
> easy enough to identify, and would save you the manual work.

I'll do that and submit a patch. Thanks for the suggestion.

Cheers Tobias


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
