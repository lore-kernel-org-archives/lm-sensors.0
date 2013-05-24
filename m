From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 May 2013 12:57:42 +0000
Subject: Re: [lm-sensors] sensord systemd unit
Message-Id: <20130524145742.0320c382@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nikola,

Sorry for the late reply :(

On Mon, 13 Feb 2012 14:37:22 +0100, Nikola Pajkovsky wrote:
> --- prog/init/sensord.systemd	(revision 0)
> +++ prog/init/sensord.systemd	(revision 0)
> @@ -0,0 +1,11 @@
> +[Unit]
> +Description=Sensor Information Logging

I added:
After=syslog.target

> +
> +[Service]
> +Type=forking
> +EnvironmentFile=-/etc/sysconfig/sensord

I removed the "-", as the environment file is mandatory, otherwise the
ExecStart below will fail, right?

> +PIDFile=/run/sensord.pid
> +ExecStart=/usr/sbin/sensord -i $INTERVAL -l $LOG_INTERVAL -f daemon
> +
> +[Install]
> +WantedBy=multi-user.target

Applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
