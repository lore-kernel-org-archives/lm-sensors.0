From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 13 Dec 2007 14:08:26 +0000
Subject: Re: [lm-sensors] sensord bug in lm-sensors 3.0.0
Message-Id: <47613CDA.2020105@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071211145706.31e52982@hyperion.delvare>
In-Reply-To: <20071211145706.31e52982@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> Unfortunately I introduced a bug in sensord shortly before releasing
> lm-sensors 3.0.0. It was reported yesterday:
> http://www.lm-sensors.org/ticket/2276
> 
> I've fixed it in SVN today:
> http://www.lm-sensors.org/changeset/5069
> 
> People responsible for packaging lm-sensors for a distribution will
> probably want to backport this fix. Without it, the rrd feature of
> sensord is essentially unusable.
> 

Thanks for fixing and reporting, I've just applied your fix to the fedora package.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
