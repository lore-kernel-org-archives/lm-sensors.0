From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 15:36:24 +0000
Subject: Re: [lm-sensors] xsensors ported to the future libsensors
Message-Id: <20070722173624.5c0186d2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070720213455.644b5f50@hyperion.delvare>
In-Reply-To: <20070720213455.644b5f50@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 20 Jul 2007 22:33:17 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I just finished porting xsensors to the version of libsensors we have
> > in branch lm-sensors-3.0.0. I wanted to have a second application using
> > it at hand, because I don't think that sensors is representative of the
> > rest of the libsensors users: it's one-shot nature make it different.
> > As I want to improve the API, having more than one application will
> > make it less likely that I overlook an important need.
> > 
> > You can download the patch from here:
> > http://jdelvare.pck.nerim.net/sensors/xsensors-libsensors4.patch
> > I'll keep it up-to-date as the libsensors API evolves.
> > 
> > Note: I don't know how to force an application to link with
> > libsensors.so.4 rather than libsensors.so.3, so you'll have to make
> > sure that libsensors.so.4 is found first when building xsensors.
> 
> Good work! Gnome sensors-applet or the gkrellm libsensors code might also be 
> interesting, as those both already use libsensors as a generic chip abstraction 
> layer, iow they do not contain any chip specific code, like xsensors it seems 
> used to.

The chip-specific code in xsensors is really only to tell which feature
numbers need to be used for each chip. It really could have been data
tables rather than code. That left apart, xsensors has a greater level
of abstraction than even the new libsensors. For example it describes
the subfeatures "relatively" to the main feature, independent of its
type (e.g. tempX_max and inX_max are handled the same way.) Compare
this to "sensors" which has specific code for each sensor type. This
might be something to consider for libsensors (SENSORS_FEATURE_TEMP_MAX
= SENSORS_FEATURE_IN_MAX)... or not, I'm not sure yet.

I'm curious how gnome sensors-applet and gkrellm managed to use the
current libsensors without chip-specific code at all, as it definitely
wasn't designed to be used that way. But anyway this will be
interesting to see how they can be converted to the new libsensors.
I'll leave it to someone else though. For one thing, I'll be busy
enough with xsensors and later sensord. For another, letting others
comment on the new API will be very valuable.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
