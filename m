From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Apr 2011 13:30:54 +0000
Subject: Re: [lm-sensors] PATCH: systemd integration version 2
Message-Id: <20110427153054.32e1b546@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DB81486.2010700@redhat.com>
In-Reply-To: <4DB81486.2010700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 27 Apr 2011 15:05:10 +0200, Hans de Goede wrote:
> Hi,
> 
> The attached patch:
> 1) uses systemd's systemctl to start / stop / enable the lm_sensors service on
> systemd systems (such as Fedora 15)
> 2) recognizes the new /run dir for run time info (as used by systemd systems)
> as a possible place where the udev db can live
> 3) adds a lm_sensor.service file to install under /lib/systemd/system
> 
> Version 2:
> 1) adds detection that the lm_sensor.service still needs to be installed
>     under /lib/systemd/system to sensors-detect
> 2) has a better description for the .service file
> 
> Please review, I'll push it to svn myself once acked.

One thing:

> +		if (-x "/bin/systemctl" && -d "/lib/systemd/system" &&
> +		    ! -f "/lib/systemd/system/lm_sensors.service") {
> +			print "Copy prog/init/lm_sensors.service to /lib/systemd/system\n".
> +			      "And run systemctl enable lm_sensors.service\n".

Should be "and" not "And". Might be good to have quotes around the
suggested commands too, for clarity. Other than this, you have my ack,
please go ahead and commit. Please don't forget to mention the change
in file CHANGES.

> +			      "for initialization at boot time.\n";
> +			return;
> +		}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
