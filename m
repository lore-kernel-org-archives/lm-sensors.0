From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Oct 2008 08:35:16 +0000
Subject: Re: [lm-sensors] [RFC v2] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081015103516.76a842ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081014224325.GC27799@ovro.caltech.edu>
In-Reply-To: <20081014224325.GC27799@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Hans,

(thanks for reviewing this driver)

On Wed, 15 Oct 2008 10:22:47 +0200, Hans de Goede wrote:
> Ira Snyder wrote:
> > +power1_input		12v power usage (mW)
> > +power2_input		5v  power usage (mW)
> > +power3_input		3v  power usage (mW)
> > +power4_input		Vee (-12v) power usage (mW)
> 
> These should be in micro Watt so μW not mW, I know this is not consistentent 
> with all other input's being in milli something, but the first piece of 
> supported power measuring hardware we had has sub milliWatt precision, hence 
> this decision.

This is actually totally consistent: mV * mA = µW.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
