From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Apr 2010 08:18:45 +0000
Subject: Re: [lm-sensors] [RFC PATCH v3 0/2] Add sensors config tool
Message-Id: <20100411101845.30cd43c7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100331200353.GA2002@andre-laptop>
In-Reply-To: <20100331200353.GA2002@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 10 Apr 2010 23:49:16 +0200, Andre Prendel wrote:
> On Thu, Apr 01, 2010 at 08:56:31AM +0200, Hans de Goede wrote:
> > I think this all looks very good! I think the module auto loading
> > is the only remaining item to do before this could actually become
> > production ready (although we will want Jean's input on this too).
> > 
> > The module autoloading requires 2 questions to be answered:
> > 
> > 1) How do we store which modules are needed into the configuration
> >    files on the wiki
> > 
> > 2) How / where / what will these modules get loaded ? Currently we
> >    have lines like these in /etc/sysconfig/lm_sensors:
> > 
> > # The format of this file is a shell script that simply defines variables:
> > # HWMON_MODULES for hardware monitoring driver modules, and optionally
> > # BUS_MODULES for any required bus driver module (for example for I2C or SPI).
> > 
> > HWMON_MODULES="it87"
> > 
> > # For compatibility reasons, modules are also listed individually as variables
> > #    MODULE_0, MODULE_1, MODULE_2, etc.
> > # You should use BUS_MODULES and HWMON_MODULES instead if possible.
> > 
> > MODULE_0=it87
> > 
> > 
> > We could add new "keys" to this file, say:
> > AUTOMOBO_HWMON_MODULES
> > AUTOMOBO_BUS_MODULES
> > 
> > And modify the lm_sensors initscript to recognize these too, or thinking more
> > about this, as we need the script which does the copying of the config file
> > to /etc/sensors.d/automobo.conf, to extract the modules for us anyways (to
> > insert them into /etc/sysconfig/lm_sensors for example). We might just as
> > well make that script load the modules directly.
> > 
> > This also solves a problem with the HWMON_MODULES="it87" syntax, namely
> > that it does not allow specifying module parameters.
> > 
> > Jean, could we have your input on this ?

If modules need parameters, these should go
to /etc/modprobe.d/hwmon.conf or some such. /etc/sysconfig/lm_sensors
isn't the right place for them, because you want the options to be
applied even when the modules are loaded manually.

Not that this should be a big concern anyway, as module parameters
should almost never be used at this point. sensors-detect no longer
generates any for kernels >= 2.6.28.

> No reply from Jean so far. So I'd like to make a proposal.

I'm very sorry, but I simply don't have the time to look into your code
and proposals right now. Please don't let this stop you, just go ahead
with what you have, we have been in need of this feature for years, so
the sooner we have it, the better. If it needs adjustments, we can
apply them later. I have no doubt that we will discover new needs as
users start using your code anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
