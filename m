From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 18:25:03 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (pmbus) Improve fan detection
Message-Id: <20110703202503.25ceb9e4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309454993-8641-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309454993-8641-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 3 Jul 2011 09:27:46 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Sun, Jul 03, 2011 at 04:14:32AM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Thu, 30 Jun 2011 10:29:52 -0700, Guenter Roeck wrote:
> > > Some PMBus devices return no error when reading fan speed registers, but don't
> > > really support fans. Strengthen fan detection by also checking if fan
> > > configuration registers exist.
> > > 
> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > >  drivers/hwmon/pmbus.c |    6 ++++--
> > >  1 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
> > > index 98e2e28..b0ea00b 100644
> > > --- a/drivers/hwmon/pmbus.c
> > > +++ b/drivers/hwmon/pmbus.c
> > > @@ -47,12 +47,14 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
> > >  	if (info->func[0]
> > >  	    && pmbus_check_byte_register(client, 0, PMBUS_STATUS_INPUT))
> > >  		info->func[0] |= PMBUS_HAVE_STATUS_INPUT;
> > > -	if (pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_1)) {
> > > +	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_12) &&
> > > +	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_1)) {
> > >  		info->func[0] |= PMBUS_HAVE_FAN12;
> > >  		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_12))
> > >  			info->func[0] |= PMBUS_HAVE_STATUS_FAN12;
> > >  	}
> > > -	if (pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_3)) {
> > > +	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_34) &&
> > > +	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_3)) {
> > >  		info->func[0] |= PMBUS_HAVE_FAN34;
> > >  		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_34))
> > >  			info->func[0] |= PMBUS_HAVE_STATUS_FAN34;
> > 
> > Then wouldn't it be sufficient to only test PMBUS_FAN_CONFIG_12 and
> > PMBUS_FAN_CONFIG_34, respectively? This would make the function
> > somewhat faster.
> 
> I'd rather keep both. Devices should not return a valid value or should at least set 
> the command error flag in the status register if they don't support fans and the fan speed
> register is read. If I can't trust that (and I can't because Intersil devices do just that),
> I can not trust the configuration register either. 

I think that what worries me is the asymmetry. Is it not possible for a
device to have FAN_SPEED_2 and not FAN_SPEED_1? If not then your code
is fine, I agree. But if it is possible, then we need smarter code.

But also note that I don't know a thing about PMBus, so there may be
nothing to worry about.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
