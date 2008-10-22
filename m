From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 22 Oct 2008 07:36:55 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (abituguru3) match partial DMI
Message-Id: <48FED817.9030304@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1224608373-27352-4-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1224608373-27352-4-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Alistair John Strachan wrote:
> Hi Jean,
> 
> On Tuesday 21 October 2008 20:53:00 Jean Delvare wrote:
> [snip]
>> So I don't think that the implementation above is safe, unless the
>> entries in abituguru3_dmi_detect are sorted specifically to make the
>> short string comparison always correct. But that's easy to screw this
>> up later.
>>
>> An alternative would be to make a slightly more customized comparison
>> function: instead of passing strlen(dmi_name) as the length parameter
>> of strncmp(), you would compute the length by looking for the last
>> non-space character before the opening parenthesis in board_name. This
>> would require some more code, but would be more robust. Whether it's
>> worth it, I'll leave up to you: either do that or leave the code as it
>> is now.
> 
> Or drop the patch. Dropping patch 3/3 also works (at least on the boards it 
> was tested on) and the patch only plugs a theoretical problem, and ultimately 
> might pose more problems than it solves, as you outlined.
> 
> I don't think it's worth adding code which massages the length any further. 
> For example, there's nothing stopping Abit from putting out a future board 
> which uses parens in the model name too.
> 
> I'd currently vote to drop the patch, and, if it is discovered that the 
> problem we identified is more than theoretical, we can apply this patch as-is, 
> or rework it.
> 

I agree, drop the patch.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
