From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Question ...
Message-Id: <3D124A33.83C92B8B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <XFMail.20020618211645.dieter.jurzitza@t-online.de>
In-Reply-To: <XFMail.20020618211645.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Almost every sensor chip has working alarm bits that _latch_ the alarm condition
until the register is read. This is much better than polling because an
intermittent condition will not be missed.
So I think the way we do it now is the best way.

It may be that you have found a bug, or perhaps something has already
been fixed (2.6.0 is one year old) - you can look at our
CHANGES document (linked on our download page) to see.

If you think you have an alarm bit that is not working then 
it is probably a bug, or caused by missing documentation.
In that case, of course,
tell us what bit, what driver, what sensor, what chip.

mds



"Dr. Ing. Dieter Jurzitza" wrote:
> 
> Dear lm_sensors people,
> first of all: many many thanks for the time you spent writing lm_sensors and
> making it public available. I am very happy with that tool because it is highly
> effective in device control (watching overheat issues with my mb for example).
> 
> One question to you: you write in the docs, that alarm triggers only occur by
> the sensor chip. This is nice - if the chip honors the limits you give
> (currently I am using a Tyan 2460 MB (amd756 / wXXX)) and want to shut it down
> in case of an overtemperature event, kernel 2.4.18 (SuSE), lm_sensors version
> 2.6.0). This is difficult if there is no alarm trigger even though the condition
> for a trigger is met (i.e. temperature above the limiting value).
> 
> Two possibilities:
> 1.) tell me upgrade here and there and things (may) get better,
> 2.) do some awk magic (this is what I did) and check for the actual reading to
> be larger than some value XY.
> 
> However, I have to run (and have) awk every other minute to ensure apropriate
> operation. Would it be bad to have an /etc/sensors.conf option that
> allows lm_sensors itself to interpret the limits given and say "alarm" if
> an "alarm" condition is met? According to my understanding there must be
> a program internal structure containing those values. Or even allow a user
> command to be executed as soon as some limiting values cross a certain border
> (shutdown -h now for example)?
> 
> Please give me your opinion on that (and again, don't take me wrong, I am
> *very* happy with this software and to have a chance to build a thermal
> supervision on my own, as long as ACPI is still in its early stages.
> Take care,
> 
> Dieter Jurzitza
> 
> --
> -----------------------------------------------------------
> E-Mail: Dr. Ing. Dieter Jurzitza <dieter.jurzitza@t-online.de>
> Date: 18-Jun-2002
> Time: 21:02:55                 |
>                                 \
>                  /\_/\           |
>                 | ~x~ |/-----\   /
>                  \   /-       \_/
>   ^^__   _        /  _  ____   /
>  <??__ \- \_/     |  |/    |  |
>   ||  ||         _| _|    _| _|
> 
> if you really want to see the pictures above - use some font
> with constant spacing like courier! :-)
> -----------------------------------------------------------
