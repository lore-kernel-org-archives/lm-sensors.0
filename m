From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Apr 2007 15:29:04 +0000
Subject: Re: [lm-sensors] Need some guidance on adhering to the sysfs
Message-Id: <20070422172904.477eade4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 19 Apr 2007 12:04:28 -0700, Juerg Haefliger wrote:
> George, Jean,
> 
> I'm struggling with the same issue for the DME1737 I'm currently
> working on. This chip also features temp zones and "hottest of x,y,z"
> PWM control. The current sysfs standard is not flexible enough to
> handle these features, especially the combination of a single PWM
> being controlled by multiple temp inputs and multiple PMWs being
> controlled by the same temp input. I believe we need another layer of
> mapping. I.e. temp->pwm is not sufficient, but rather temp->zone->pwm.
> 
> I therefore propose the add the following sysfs attributes to our standard:
> 
> zone[1-*]_auto_channels_temp   for temp-to-zone mapping
> pwm[1-*]_auto_channels_zone   for zone-to-pwm mapping
> zone[1-*]_auto_point[1-*]_temp   for zone temp auto points.

I don't see what value it adds compared to what we currently have.

We have pwm[1-*]_auto_channels_temp, which is a bit vector. We have one
file per PWM, one bit per temperature channel, so all in all we have a
Npwm x Ntemp matrix, or N-N relation between PWM and temperatures. This
already allows us to handle cases such as "the hottest of tempA and
tempB control pwmC" or "tempD controls pwmE and pwmF".

You propose to add the concept of zone. According to the above, each
zone could include any temperature channel, so we have a N-N relation
between zones and temperatures. Then you express another N-N relation
between PWM channels and zones. As far as I can see, this results in a
N-N relation between temperatures and PWM, just expressed differently.
Am I missing something? What do you think it would let us express,
which the current model doesn't?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
