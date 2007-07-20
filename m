From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 20 Jul 2007 20:33:17 +0000
Subject: Re: [lm-sensors] xsensors ported to the future libsensors
Message-Id: <46A11C0D.1040301@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070720213455.644b5f50@hyperion.delvare>
In-Reply-To: <20070720213455.644b5f50@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> I just finished porting xsensors to the version of libsensors we have
> in branch lm-sensors-3.0.0. I wanted to have a second application using
> it at hand, because I don't think that sensors is representative of the
> rest of the libsensors users: it's one-shot nature make it different.
> As I want to improve the API, having more than one application will
> make it less likely that I overlook an important need.
> 
> You can download the patch from here:
> http://jdelvare.pck.nerim.net/sensors/xsensors-libsensors4.patch
> I'll keep it up-to-date as the libsensors API evolves.
> 
> Note: I don't know how to force an application to link with
> libsensors.so.4 rather than libsensors.so.3, so you'll have to make
> sure that libsensors.so.4 is found first when building xsensors.
> 

Good work! Gnome sensors-applet or the gkrellm libsensors code might also be 
interesting, as those both already use libsensors as a generic chip abstraction 
layer, iow they do not contain any chip specific code, like xsensors it seems 
used to.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
