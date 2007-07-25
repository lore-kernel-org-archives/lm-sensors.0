From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 25 Jul 2007 07:28:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] libsensors4: Make
Message-Id: <46A6FBA2.20309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070724131723.133f54e7@hyperion.delvare>
In-Reply-To: <20070724131723.133f54e7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Don't export sensors_chip_name_has_wildcards(). I don't know of any
> application using it, and I can't think of any use case for it outside
> of libsensors. I'm not even sure if the inside calls are all legitimate.
> 
> Hans, can you please check if gnome sensors-applet or gkrellm use this
> function?
> 

This function isn't used be gkrellm, gnome sensors-applet or ksensors.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
