From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 18 Dec 2007 10:20:46 +0000
Subject: Re: [lm-sensors] sensors.conf.eg bug in lm-sensors 3.0.0
Message-Id: <47679EFE.2010708@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071217231109.3d6d26f3@hyperion.delvare>
In-Reply-To: <20071217231109.3d6d26f3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> Aurelien Jarno just reported to me that lm-sensors 3.0.0 prints error
> messages for some chips (specifically: gl520sm, lm80 and pc87366). This
> is due to missing symbol name conversions in compute statements in the
> default configuration file.
> 
> I've just fixed it in SVN:
> http://www.lm-sensors.org/changeset/5076
> 
> People responsible for packaging lm-sensors for a distribution will
> probably want to backport this fix.
> 

Thanks,

Applied to the Fedora package.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
