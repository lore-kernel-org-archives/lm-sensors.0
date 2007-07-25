From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 25 Jul 2007 07:29:19 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] libsensors4: Delete
Message-Id: <46A6FBCF.4030503@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Delete sensors_do_all_sets(). I couldn't find any application using it,
> and sensors_do_chip_sets() can be used instead if really needed.
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
