From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 09 Jan 2009 13:08:01 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <49674C31.5090903@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 08 January 2009 18:09:40 Alistair John Strachan wrote:
>> On Thursday 08 January 2009 17:09:43 Jean Delvare wrote:
> [snip]
>>> Might be worth reading this discussion thread again:
>>> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024522.html
>>>
>>> We gave up on fixing it back then, but apparently there really is a
>>> need. Alistair, do you have a patch?
> 
> Find attached an alternative method which solves (I believe only potential) 
> problems Jean pointed out at the time of the last thread. I think it's safe.
> 
> I've compromised by finding the first open bracket (it's fine if there are no 
> brackets) and trimming any space from the sub-string. For example, here are 
> the existing transformations:
> 
> "AW9D-MAX       (Intel i975-ICH7)" -> "AW9D-MAX"
> "AT8 32X(ATI RD580-ULI M1575)" -> "AT8 32X"
> "IP35 Pro(Intel P35-ICH9R)" -> "IP35 Pro"
> "IN9 32X MAX(680i-MCP55PXE)" -> "IN9 32X MAX" (adding RSN)
> 
> And here are some hypothetical ones:
> 
> "AW9D      (Blah)" -> "AW9D"
> "Abit Magic" -> "Abit Magic"
> 
> In the AW9D case, "AW9D" and "AW9D-MAX" are not considered to be the same 
> motherboard, because the sub-string's length must exactly match that of the 
> string in the motherboard entry. This is different to regular "strncasecmp" 
> where they would be considered the same.
> 
> Find the patch attached. I'll probably go for this version if nobody finds any 
> issues with it, otherwise the original patch I sent out is sufficient (since 
> at the moment there are no boards falling into this hypothetical trap).

Good catch Jean!

The new version looks good to me.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
