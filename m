From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Feb 2014 18:15:11 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm63) Create attributes for LM96163 in one call
Message-Id: <52EE8B2F.1030906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390243126-19519-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390243126-19519-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/02/2014 10:02 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Mon, 20 Jan 2014 10:38:44 -0800, Guenter Roeck wrote:
>> There is no need to have both an attribute group plus an individual attribute
>> for LM96163. Add the attribute to the group and create all attributes with one
>> call.
>
> The idea of having groups (or single attributes) per extra feature
> rather than per chip was to be able to reuse them when adding support
> for a new chip implementing a subset of the extra features. It wasn't
> an overlook, it was implemented that way on purpose. You can argue that
> the extra complexity may never be needed, but nobody objected back
> then.
>
Or nobody cared ;-).

> Now I do understand that single attributes don't fit well with the way
> you implemented devm_hwmon_device_register_with_groups(). You could
> still create a group for that attribute so that you can register it
> with that function. Then you only have another group to register, no
> big deal.
>
> Would that be OK for you?
>

Sure, I can do that, no problem. As you said, no big deal.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
