From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 18:06:02 +0000
Subject: Re: [lm-sensors] xsensors ported to the future libsensors
Message-Id: <46A39C8A.50807@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070720213455.644b5f50@hyperion.delvare>
In-Reply-To: <20070720213455.644b5f50@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 20 Jul 2007 22:33:17 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> I just finished porting xsensors to the version of libsensors we have
>>> in branch lm-sensors-3.0.0. I wanted to have a second application using
>>> it at hand, because I don't think that sensors is representative of the
>>> rest of the libsensors users: it's one-shot nature make it different.
>>> As I want to improve the API, having more than one application will
>>> make it less likely that I overlook an important need.
>>>
>>> You can download the patch from here:
>>> http://jdelvare.pck.nerim.net/sensors/xsensors-libsensors4.patch
>>> I'll keep it up-to-date as the libsensors API evolves.
>>>
>>> Note: I don't know how to force an application to link with
>>> libsensors.so.4 rather than libsensors.so.3, so you'll have to make
>>> sure that libsensors.so.4 is found first when building xsensors.
>> Good work! Gnome sensors-applet or the gkrellm libsensors code might also be 
>> interesting, as those both already use libsensors as a generic chip abstraction 
>> layer, iow they do not contain any chip specific code, like xsensors it seems 
>> used to.
> 
> The chip-specific code in xsensors is really only to tell which feature
> numbers need to be used for each chip. It really could have been data
> tables rather than code. That left apart, xsensors has a greater level
> of abstraction than even the new libsensors. For example it describes
> the subfeatures "relatively" to the main feature, independent of its
> type (e.g. tempX_max and inX_max are handled the same way.) Compare
> this to "sensors" which has specific code for each sensor type. This
> might be something to consider for libsensors (SENSORS_FEATURE_TEMP_MAX
> = SENSORS_FEATURE_IN_MAX)... or not, I'm not sure yet.
> 
> I'm curious how gnome sensors-applet and gkrellm managed to use the
> current libsensors without chip-specific code at all, as it definitely
> wasn't designed to be used that way.

They both basically have there own version of sensors_get_feature_type, both 
assuming to be running on a 2.6 kernel, and thus have sysfs interface standard 
feature names.

Converting them thus should be easy. (I wrote the gkrellm libsensors code 
myself, so I will probably also be the one converting it).

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
