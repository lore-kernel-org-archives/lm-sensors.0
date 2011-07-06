From: Jeff Rickman <jrickman@myamigos.us>
Date: Wed, 06 Jul 2011 09:55:31 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <4E143113.4060701@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/6/2011 4:04 AM, Jean Delvare wrote:
> Hi Luca,
>
> On Wed, 6 Jul 2011 10:48:43 +0200, Luca Tettamanti wrote:
>> On Wed, Jul 6, 2011 at 2:34 AM, Jeff Rickman<jrickman@myamigos.us>  wrote:
>>> Luca, would that modified F71882FG driver (from ~June last year) be
>>> useful/helpful here? In my case it was a F71862FG chip where ACPI claimed
>>> the ports but DSDT suggested something to you. I guess it really depends on
>>> the DSDT code. BTW, I still use that modified driver on that Jetway NC92-330
>>> board and it still works fine even with Fedora Core 15.
>>
>> It was an ugly hack :) I modified the driver to access the hwmon chip
>> using the methods exposed by the firmware instead of letting the
>> driver touch the chip directly. Unfortunately the hack is very board
>> specific...
>
> I still have to test this approach on a Jetway board of mine with a
> Fintek F71805F chip.
>
> Why do you say this is ugly? Of course it is vendor specific (or even
> board specific) but so is the asus_atk0110 driver. Wouldn't it be a
> proper way to deal with the ACPI resource conflict at least on the
> Jetway boards, and maybe others? If it works then I can't really see a
> reason to not do it, can you? It seems preferable to
> acpi_enforce_resources=lax people are using at the moment, at least.
>

If a "modified" F71805 driver appeared I would be happy to test it. I 
think my Jetway board (J7F4 series) is different from Jean's board.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
