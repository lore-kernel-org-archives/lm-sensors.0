From: Riku Voipio <riku.voipio@movial.fi>
Date: Thu, 05 Jun 2008 14:57:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <4847FED2.9020904@movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 5 Jun 2008 13:14:01 +0100, Ben Hutchings wrote:
>   
>> The point is to allow platform_data to provide all the settings and to
>> allow polling of the values, without exposing any of the implementation
>> variables.
>>     
>
> The question is: why do you want to provide the "settings" (I think you
> mean the high and low limits of each sensor?) and allow polling of the
> values inside the kernel, when we have a standard user-space interface
> and library that takes care of this, with a dozen applications that can
> be used on top of it? It makes sense to pass _some_ settings as
> platform data (e.g. fan polarity) but passing all the limits doesn't
> make any sense to me.
>   
I don't see why this is a problem to you - on PC's sensible defaults
are set at BIOS. If there is no BIOS to set it up, someone needs to
set it up. If the settings are platform-specific, the most natural
place is the platform_data. The limits depend on what is being
monitored (CPU? mainboard? ambient temperature? Network card?),
and it's not easy to figure what's being monitored by the userland.

Actually, at a second look, the current lm87_init_client already sets
limits to hardcoded values... :) So if Ben's patch only makes it more
flexible.
>   
>> I did consider splitting this into two patches, but there is no point
>> in creating those two structures except to support the rest of the
>> changes.  Howver, I can repost as two if you like.
>>     
I believe it's quite common to post patches in style of

[PATCH 1/2] reorganize code in preparation of foo
[PATCH 2/2] implement foo

I'd also like to see the change of moving setting the platform_data
changes to a separate function from .probe, is it was before.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
