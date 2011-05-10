From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 May 2011 17:03:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110510190308.08b7d526@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

On Tue, 10 May 2011 10:46:07 -0400, Martin Hicks wrote:
> This is a new driver for the INA219 current and power monitor.  This
> device does require manual configuration via sysfs files in order to
> provide the current and power information.  By default it does provide
> voltage information for the monitored bus.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>

Ira Snyder (Cc'd) once submitted a driver for the INA209. It never got
reviewed due to lack of time and difficulties to make the driver fit in
the standard hwmon interface, but maybe you two can work together if
the parts are compatible enough.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
