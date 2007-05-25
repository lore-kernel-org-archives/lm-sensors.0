From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 07:53:48 +0000
Subject: Re: [lm-sensors] dynamic chip support
Message-Id: <20070525095348.5c257297@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461B7F5C.5080409@hhs.nl>
In-Reply-To: <461B7F5C.5080409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Sorry for the late answer.

On Tue, 10 Apr 2007 14:13:16 +0200, Hans de Goede wrote:
> I just committed a rewrite of parts of the dyn chip support, changes:
> -rewrite dyn chip code, it now uses sensors_feature_get_type() to
>   identify sysfs entries. Reasons for this rewrite / bugs fixed:
>   -Don't give features like alarms / sensor type / fault flag a
>    compute mapping only a normal mapping
>   -Don't generate features for sysfs entries like uvent, modalias, etc.
>    instead only generate features for features known by
>    sensors_feature_get_type()
>   -Sort the list of found features logically instead of sorted in alphabet order
>    of the sysfs entry. So now it starts with all in entries, then all fan and
>    then all temp. Just like the order of most entries in lib/chips.c. Also
>    this means that it now contains in0 - in10 in that order and not in0, in10,
>    in1 - in9

Thanks for doing this, it sounds good (even though I didn't have the
time to look into the code itself yet) and is much appreciated.

> Some observations, in an ideal world this dyn chipsupport could replace most of 
> the 5000 lines of code in prog/sensors/chips.c, however some chips seem to use 
> non standard sysfs names <sigh> like remote_temp and zone_xxxxx, etc. I'm 

A Linux 2.6 driver creating a sysfs file named remote_temp? I can't
believe that. Can you please double-check, and point me to it if it
really exists? Some Linux 2.4 driver did that, I know, but the feature
should have been renamed to temp2_input when the driver was ported to
Linux 2.6.

The zone_* files are advanced features that can be safely ignored in
libsensors, methinks.

> thinking of adding support to often used non standard names to 
> sensors_feature_get_type(), but all in all not having a standard API is not good.

If you have a list of these often used non-standard names, we can
discuss them on a case-by-case basis. But my preference would be to
either change the names to fit the standard, or extend the standard to
include the names. Except for the advanced fan control stuff, of
course, on which we have agreed we wouldn't enforce a standard, but
libsensors won't support that anyway.

My plan was indeed to get rid of (the non-generic) chips.c entirely in
the long run.

> Also I've not added support for pwm features, because AFAIK libsensors is about 
> sensors, thus I also was amazed to still see eeprom and edid "feature" lists in 
> lib/chips.c

Eeprom and edid support are gone by now, I've ripped them off.

And I agree that the pwm features can be omitted.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
