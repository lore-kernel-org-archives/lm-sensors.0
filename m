From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 14:48:07 +0000
Subject: Re: [lm-sensors] Misc API changes for libsensors4
Message-Id: <20070821164807.5391c3ba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817225454.2e3bc43d@hyperion.delvare>
In-Reply-To: <20070817225454.2e3bc43d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Tue, 21 Aug 2007 11:40:52 +0200, Ivo Manca wrote:
> As we saw with my struggle for supporting the PCChips motherboard with 
> the sis5595 chip, we had a problem with a voltage channel which was 
> connected to a temperature sensors. However, there was no way to let 
> sensors know that the in4 was actually temperature instead of voltage. 
> I've added the related mail below (14/06/2007). Is this something for 
> libsensors4?

Good point. I seem to remember that we had excluded the possibility to
handle this at the driver level, as virtually every chip can be wired
that way and we didn't want to modify all the drivers. And I can't think
of an easy way to centralize it in a single kernel module either.

To handle it in libsensors, the only missing part as far as I can see
is a way to change the channel type, so that "sensors" displays the
right things using the right units. We already have the value conversion
support in place (using compute statements) so this part is OK.

Channel types could be changed with a new statement in sensors.conf, say
"type in4 temp" or something similar. Then feature types would be
changed on the fly, just like we drop features with "ignore" statements.

Changing channel types would probably be easier if we were using the
same numbers for all channel type subfeatures, which isn't currently
the case. I seem to remember that we were discussing this with Hans a
few weeks ago. Back then I had no strong argument to change it, but
this may be a good one. I'll look into this later.

One thing that might cause problem is that the limits may need to be
swapped depending on the thermistor type. I see no easy way to detect
this though [1]. This is somewhat similar to some of the negative
voltages, and although people sometimes ask about this, we seem to be
able to live with it (with a FAQ entry maybe.)

It would be great if you could create a trac ticket to track this
feature request, so that it doesn't get overlooked.

Thanks.

[1] Well I do see a way, we could analyze the compute statement to find
out in which direction the result changes depending on the raw value
variations. Still I'm not sure if it's worth the effort.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
