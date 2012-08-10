From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 10 Aug 2012 08:35:59 +0000
Subject: Re: [lm-sensors] NULL dereference BUG in sch56xx_init()
Message-Id: <5024C7EF.7090408@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120809125526.GA11926@localhost> <20120809144239.GA6604@roeck-us.net>
In-Reply-To: <20120809144239.GA6604@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

On 08/09/2012 04:42 PM, Guenter Roeck wrote:
> On Thu, Aug 09, 2012 at 08:55:26PM +0800, Fengguang Wu wrote:
>> Hi Guenter,
>>
>> This commit triggered an oops which can be fixed by the attached diff.
>> Should it be folded into the original one (preferable for me), or be
>> resent as a standalone patch?
>>
> I folded it into the original commit.
>
> Thanks a lot for the test and feedback!

Fengguang, good catch, thanks!

Guenter, 2 remarks:

1) The changing of the type of the address parameter of sch56xx_device_add is
    not necessary
2) A similar change is needed for the f71882fg, there the type of the address
    variable in f71882fg_init() needs to be changed to int too.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
