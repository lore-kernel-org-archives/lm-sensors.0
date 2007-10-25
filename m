From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Oct 2007 14:55:17 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <20071025165517.180259b7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071019232531.3c767d99@hyperion.delvare>
In-Reply-To: <20071019232531.3c767d99@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 25 Oct 2007 12:01:59 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Wed, 24 Oct 2007 14:39:06 +0200, Hans de Goede wrote:
> >> There are 3 reasons to do the scaling in the driver:
> >> 1) The used scale values are taken 1 on 1 from the fscher "datasheet"
> > 
> > Do we really have the same datasheet? Mine states that the scaling
> > factor is computed from values present in the DMI table. Could you
> > please send me (in private) the output of dmidecode for your test
> > system? I'd like to take a look. The Poseidon datasheet OTOH indeed
> > lists hard-coded values.
> 
> Jean, you are amazing (in a positive way), you are completely right. I've 
> totally overlooked this when comparing the datasheets for creating the unified 
> drivers (oops).

Once in a while, there has to be some positive effects to me bugging
everyone all the time with silly questions and remarks ;)

> I don't have access to my FSC (her) machine until monday, then I'll take a look 
> at this. I'll also mail my FSC contact to ask if the DMI based scaling should 
> be used for other models and for which models.
> 
> 
> My plan is to implement DMI value based scaling for the relevant models for DMI 
> enabled kernels, and fallback to the current constants for non DMI enabled kernels.
> 
> I feel a big discussion coming up here, like with the uguru3 on doing this in 
> the kernel versus userspace, I hope we can come to an agreement a bit quicker / 
> easier this time :)
> 
> Arguments to do it in the kernel:
> 1) With lm_sensors-3.x.x we've made userspace completely free of chip specific
>     knowledge, I would like to keep it this way

Not exactly. The libsensors code and applications using libsensors are
free of chip-specific (or, for that matter, motherboard-specific)
knowledge. sensors.conf still holds motherboard-specific knowledge, and
there's nothing wrong with this.

> 2) The kernel already includes a DMI parser, so it is not going to add a whole
>     lot of code

I'm not sure what exactly is parsed in the kernel. It seems that it's
only extracting a couple identification strings and specific data and
doesn't give you access to arbitrary record data. So you'll probably
have to add your own FSC-specific handler, and to find a way to export
the data. Not sure if that will be accepted upstream.

> 3) We could avoid 1) by creating an FSC specific userspace tool to generate a
>     sensors.conf, but then this tool still needs to be run, so either we need to
>     hack this into our initscripts somehow, or we need to document this and
>     users must run it manualy. Having this in the driver will make things "just
>     work (tm)".

Most users will need to tweak their configuration file manually, at
least until we have our config file database in place. I don't think
it's a big issue if FSC chip users have to do the same as all other
users in this respect.

Writing a user-space tool on top of dmidecode to generate compute
statements automatically for FSC motherboards would probably not be
difficult. We'll soon depend on dmidecode anyway.

> 4) Its device specific knowledge and device specific knowledge belongs in the
>     driver.

It's actually motherboard-specific knowledge we're discussing here.

If you can hook up the DMI table parser in the kernel in a clean way,
that's completely fine with me. I'm just not sure if you'll be able to
do that. If you aren't, doing it in userspace still sounds doable.

As a side note, I would _love_ if other manufacturers could follow
FSC's track here and include voltage scaling information in their DMI
tables in a documented way. Even if each vendor has its own encoding
for that, it would still be very helpful when setting up the initial
sensors.conf file for a new motherboard.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
