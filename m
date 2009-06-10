From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Jun 2009 07:59:11 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <20090610095911.59d5fa34@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Mon, 08 Jun 2009 12:35:21 +0100, Ben Dooks wrote:
> Add support for the ADC controller on the S3C
> series of processors to drivers/hwmon for use with
> hardware monitoring systems.
> 
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>

Looks OK to me now, you can add:

Acked-by: Jean Delvare <khali@linux-fr.org>

As this patch depends on changes from the s3c tree, I guess you prefer
to merge it yourself via that tree?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
