From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 23 Jul 2007 17:14:46 +0000
Subject: Re: [lm-sensors] xsensors ported to the future libsensors
Message-Id: <46A4E206.7090507@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070720213455.644b5f50@hyperion.delvare>
In-Reply-To: <20070720213455.644b5f50@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sun, 22 Jul 2007 20:06:02 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> I'm curious how gnome sensors-applet and gkrellm managed to use the
>>> current libsensors without chip-specific code at all, as it definitely
>>> wasn't designed to be used that way.
>> They both basically have there own version of sensors_get_feature_type, both 
>> assuming to be running on a 2.6 kernel, and thus have sysfs interface standard 
>> feature names.
> 
> I'm surprised, as the feature names exposed by libsensors are the old
> (non-standard) ones, even for 2.6 kernels. The mapping to the new
> symbols is internal as far as I can see. "sensors -u" returns the old
> feature names. So I guess they assume that old names are somewhat
> standard, and it doesn't work for all drivers?
> 

Correct, but gkrellm does for example contain code to also work with the 
via686a 2.0V style volt feature names

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
