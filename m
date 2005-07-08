From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 08 Jul 2005 18:19:12 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <1120839491.6794.12.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2005-07-08 at 04:27, Rudolf Marek wrote:
> Both subclients are disabled.
> It seems our driver
> 
>           val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);
>                 data->lm75[0]->addr = 0x48 + (val & 0x07);
>                 data->lm75[1]->addr = 0x48 + ((val >> 4) & 0x07);
>         }
> 
> Does not expect this.  You must be using force_subclients parameter to get around this?!
> Maybe setting the subclients reset the chip.
> 
>   if (data->lm75[0]->addr = data->lm75[1]->addr) {
>                 dev_err(&new_client->dev, "duplicate addresses 0x%x "
>                                 "for subclients\n", data->lm75[0]->addr);
>                 err = -ENODEV;
>                 goto ERROR_SC_2;
>         }
> 
> 
> Please make sure you are not using force_subclients param,
> To allow driver load comment out calling of w83792d_detect_subclients.

Rudolf, it seems you were right about the use of an extra parameter
causing the problem...but it wasn't force_subclients.  One of the
configuration files had an extra "init=1" parameter setting which must
have been causing the reset.  Removing that parameter, while leaving the
force_subclients parameter and the subclient initialization code intact,
caused the driver to load *without* starting the overtemperature light
blinking!

(Incidentally, just commenting out the call to w83792d_detect_subclients
caused the module to utterly fail to load, emitting an error saying that
the module "falsely claims to have parameter force_subclients."  I tried
commenting out bits of the w83792d_detect_subclients function code
instead; that worked better.  But I removed those comment delimiters,
leaving the code as it was before, before I tried again without the
init=1 parameter.)

And you were right that I *did* have to use force_subclients to get the
driver to load in the first place.  I also had to use "ignore=0,0x2d"
because there appears to be another chip (possibly a W83627HF?) at
address 0x2d that was causing the w83792d driver to stop there, try to
load, and fail.  The chip at address 0x2d does load with the w83781d
driver, but its sensor inputs don't appear to be connected to anything.

Looks like we've found a solution.  Thanks for being patient with me and
for all your assistance.

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

