From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Dec 2008 08:57:28 +0000
Subject: Re: [lm-sensors] MSI Wind Pc 100
Message-Id: <20081207095728.20558181@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081202170230.70d8150377b688c74c15e7947e7d8d3a.340dbf3a9c.wbe@email.secureserver.net>
In-Reply-To: <20081202170230.70d8150377b688c74c15e7947e7d8d3a.340dbf3a9c.wbe@email.secureserver.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dan,

On Tue, 02 Dec 2008 17:02:30 -0700, DanO wrote:
> I wanted to know if anyone has had success getting lm_sensors
> to work with the MSI Wind Pc 100 desktop.
> 
> It detects the Intel ICH7 and seems to go fine within the sensor-detect
> but always finishes with a "No Sensors Detected" error.
> 
> Any ideas?

Please download the latest version of sensors-detect:
svn export http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect

and report the full output. Please also include the output of lspci -nn
and dmidecode.

That being said, the Wind Pc 100 is a laptop, and most laptops do not
have sensors other than the ACPI thermal management.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
