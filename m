From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 13 Mar 2009 13:44:04 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <49BA6324.1070008@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> A number of users have asked us to support the chassis intrusion
> detection feature which some hardware monitoring chip have. I've
> created a ticket for this:
> http://www.lm-sensors.org/ticket/2370
> 
> I have made a first proposal 3 weeks ago, and got a number of
> interesting comments about it. Here comes a second version hopefully
> addressing all the concerns that had been raised. Changes include:
> * Handle multiple intrusion detection switches.
> * Let the user control whether chassis intrusion should result in
>   system beeping or not. At least the Winbond W83793G supports this, and
>   probably other chips as well.
> 
> 
> sysfs interface
> =======> 
> intrusion[0-*]_alarm
> 		Chassis intrusion detection
> 		0: OK
> 		1: intrusion detected
> 		RW
> 		Contrary to regular alarm flags which clear themselves
> 		automatically when read, this one sticks until cleared by
> 		the user. This is done by writing 0 to the file. Writing
> 		other values is unsupported.
> 
> intrusion[0-*]_beep
> 		Chassis intrusion beep
> 		0: disable
> 		1: enable
> 		RW
> 
> drivers
> ===> 
> Drivers adm9240, w83792d and w83793 implement this feature in
> non-standard ways. They should be converted to the new, standard
> interface.
> 
> libsensors
> =====
> 
> SENSORS_FEATURE_INTRUSION = 0x19
> SENSORS_SUBFEATURE_INTRUSION_ALARM = (SENSORS_FEATURE_INTRUSION << 8) | 0x80
> SENSORS_SUBFEATURE_INTRUSION_BEEP = SENSORS_SUBFEATURE_INTRUSION_ALARM + 1 
> 
> sensors
> ===> 
> Reading the value of the chassis intrusion alarm and beep subfeatures
> is done like for any other subfeature. Likewise for writing to the beep
> subfeature.
> 
> Writing to the alarm subfeature, OTOH, can't be handled the same as
> writing limits, because we certainly don't want to clear the flag
> automatically at lm_sensors start or restart time. So we could add a
> dedicated flag to clear the intrusion detection flag (e.g. "sensors
> --clear-intrusion").
> 
> 
> If anyone has objections or comments, please speak up.
> 


Looks good to me.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
