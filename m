From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Tue, 21 Oct 2008 20:27:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (abituguru3) Cosmetic
Message-Id: <200810212127.50171.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FE0EF3.8040206@redhat.com>
In-Reply-To: <48FE0EF3.8040206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tuesday 21 October 2008 20:23:05 Jean Delvare wrote:
> On Tue, 21 Oct 2008 17:59:31 +0100, Alistair John Strachan wrote:
> > @@ -523,8 +523,8 @@ static const struct abituguru3_motherboard_info
> > abituguru3_motherboards[] = { { "+3.3V",		10, 0, 20, 1, 0 },
> >  		{ "5VSB",		11, 0, 30, 1, 0 },
> >  		{ "CPU",		24, 1, 1, 1, 0 },
> > -		{ "System ",		25, 1, 1, 1, 0 },
> > -		{ "PWM ",		26, 1, 1, 1, 0 },
> > +		{ "System",		25, 1, 1, 1, 0 },
> > +		{ "PWM",		26, 1, 1, 1, 0 },
>
> I'm curious if this one isn't supposed to be "PWM Phase1"?

You have a keen eye.

It turns out on the IP35 Pro, the PhaseN readings are always zero, and not 
reported by the uguru BIOS. I'll consult the vendor's INI file and if they 
have been subsequently removed, I'll send a follow up patch.

For the moment, "PWM" on its own does return a valid temperature reading and 
is named consistently with the BIOS interface, so it can be left alone.

On Tuesday 21 October 2008 21:19:40 Jean Delvare wrote:
> BTW, thanks a lot for sending perfectly formatted patches as you've
> been doing tonight, that's really a pleasure to work with you!

If you do me the kindness of reviewing and commenting so deeply on even these 
trivial patches, it's the least I can do.

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
