From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Jul 2008 14:08:07 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <20080716140807.GB24045@secretlab.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <487331DC.2020601@grandegger.com>
	<20080708115319.111226e6@hyperion.delvare>
	<4873670C.6080204@grandegger.com>
	<20080708152935.7457bc90@hyperion.delvare>
	<487754DA.1060207@grandegger.com>
	<20080711145613.14380360@hyperion.delvare>
	<487DBB92.1070100@grandegger.com>
	<20080716113311.384d211e@hyperion.delvare>
	<487DC457.6000103@grandegger.com>
	<20080716121059.2dbbfebe@hyperion.delvare>
In-Reply-To: <20080716121059.2dbbfebe@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org, Detlev Zundel <dzu@denx.de>, Alan Clucas <alanc@pipstechnology.co.uk>

On Wed, Jul 16, 2008 at 12:10:59PM +0200, Jean Delvare wrote:
> On Wed, 16 Jul 2008 11:50:15 +0200, Wolfgang Grandegger wrote:
> > Jean Delvare wrote:
> > 
> > Yep, as probing might not be acceptable in some cases, I makes sense to 
> > add a property to suppress probing:
> 
> It'd rather make no-probing the default if possible. My understanding
> is that all systems using i2c-mpc should have proper platform data.

Total ACK.  From my perspective, probing should be off by default because the
typical use case in powerpc land is to trust data in the device tree.  Add the
property to turn on probing, not to turn it off.  Also, you'll need to
document the semantics of such a property.  ie. what exactly does it
mean when the probing property is present and the spi bus node has child
nodes?

g.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
