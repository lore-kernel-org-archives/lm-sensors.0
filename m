From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Jun 2006 06:37:44 +0000
Subject: [lm-sensors] Patch: hwmon-abituguru-override-bank1detect.patch
Message-Id: <20060627083744.598e04d5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449E7AD5.4060908@hhs.nl>
In-Reply-To: <449E7AD5.4060908@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:
> > +module_param_array(bank1_types, int, NULL, 0);
> > +MODULE_PARM_DESC(bank1_types, "Bank1 sensortype autodetection override:\n"
> > +	"   -1 autodetect\n"
> > +	"    0 volt sensor\n"
> > +	"    1 temp sensor\n"
> > +	"    2 not connected");
> 
> The "-1" is a detail implementation, user-space doesn't need to know
> about it.

I take that back, the user might need to pass -1 if he/she wants to
override some sensor types but leave the others in autodetection mode.

-- 
Jean Delvare

