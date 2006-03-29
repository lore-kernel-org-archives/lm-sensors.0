From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 29 Mar 2006 13:38:35 +0000
Subject: [lm-sensors] I2C_PCA_ISA causes boot delays (was re: sis96x
Message-Id: <20060329133835.GB8309@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060329034510.GA8309@jupiter.solarsys.private> <20060329092628.16392.qmail@web26908.mail.ukl.yahoo.com>
In-Reply-To: <20060329092628.16392.qmail@web26908.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>, Ian Campbell <icampbell@arcom.com>

Hello Etienne:

* Etienne Lorrain <etienne_lorrain at yahoo.fr> [2006-03-29 11:26:28 +0200]:
> --- "Mark M. Hoffman" <mhoffman at lightlink.com> wrote:
> > > 885c885
> > > < # CONFIG_I2C_PCA_ISA is not set
> > > ---
> > > > CONFIG_I2C_PCA_ISA=y
> > 
> > This alone is the cause of the delay.  (I have confirmed it by running some
> > similar .configs here.)  You almost certainly don't own this specialized
> > piece of hardware.  Worse still, that particular driver has no code to detect
> > whether or not the hardware is present.  I cc'ed the listed driver author
> > (Ian) just in case this might be corrected... but I guess there is no way
> > to fix it.
> > 
> > So the delay is (1) an I2C bus driver that is not actually present, trying to
> > probe for (2) seven different sensors chip drivers that certainly aren't present
> > on the nonexistent bus.  Timeouts ensue.
> > 
> > So unless Ian knows a better way to detect that bus driver... the best I can
> > advise is to *not* build in those drivers for hardware that you do not have.
> 
>  OK, I know the I2C protocol, and I can imagine a hardware board which does
>  not have a way to detect its own presence - or the presence of its own ISA bus.
>  What I dislike the most is that, after the driver has taken more than 20
>  seconds to probe something it did not find, it did not display anything to
>  say "either there is a hardware problem, or you should disable me".

I repeat just once more: the supported method for identifying hwmon/sensors
chips is a Perl script called sensors-detect that is distributed with the
lm-sensors package.  

>  Are you sure that there isn't any distribution around trying to insert
>  _all_ the modules to do hardware detection?

No, because that is not supported.  All of the major distributions package
lm-sensors, and AFAIK they all build hwmon/sensors as modules.  They don't
insert any of them by default.  If a distro was silly enough to blindly
insert them all... then it would take forever to boot and nobody would use
it.

>  Note that most I2C driver detect abscence of the hardware in a lot less than
>  a second: most of the I2C system is fine.

Feel free to write a patch for drivers/busses/i2c/i2c-pca-isa.c;  I don't
have that hardware myself.  Otherwise, my final advice is:

	Patient: It hurts when I do this.
	Doctor: Don't do that.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


