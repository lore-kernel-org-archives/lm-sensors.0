From: Roland Stigge <stigge@antcom.de>
Date: Fri, 07 Jan 2011 10:24:21 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <4D26E9D5.7050302@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 01/07/2011 02:39 AM, Guenter Roeck wrote:
>> I'm attaching my updated patch. You can also merge from git.antcom.de,
>> repo linux-2.6, branch ds620.
>>
>> I also added a runtime configuration device attribute for the thermostat
>> functionality.
>>
> Unfortunately, that adds a non-standard and non-documented ABI attribute, so no one
> will be able to use it. Also, from reading the specification, it seems like it would more
> appropriate to set this through platform data (if it really has to be configurable).

Oops, sorry!

What can we do if we want to make it configurable at runtime? I'm not
using it currently this way, but users could be. Or should we just make
ist platform data to adhere to spec restrictions?

> Btw, can you write Documentation/hwmon/ds620 ? I completely forgot to ask for that.

It was already included in the last patches, since you already asked
about it. :-)

bye,
  Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
