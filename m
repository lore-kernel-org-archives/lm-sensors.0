From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jul 2007 17:34:35 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <20070713193435.23d9c99c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690D52A.7040402@hhs.nl>
In-Reply-To: <4690D52A.7040402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Jul 2007 17:09:57 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Thinking about it some more... You may want to skip the DMI test if the
> > force module parameter is used, in case Abit stops being consistent for
> > the DMI board vendor name field.
> 
> Good point, attached is an updated version which does that.

Acked-by: Jean Delvare <khali@linux-fr.org>

Mark, please apply.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
