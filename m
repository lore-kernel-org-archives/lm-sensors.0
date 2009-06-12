From: Ben Dooks <ben@simtec.co.uk>
Date: Fri, 12 Jun 2009 09:04:01 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <4A321A01.4020209@simtec.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben,
> 
> On Mon, 08 Jun 2009 12:35:21 +0100, Ben Dooks wrote:
>> Add support for the ADC controller on the S3C
>> series of processors to drivers/hwmon for use with
>> hardware monitoring systems.
>>
>> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> 
> Looks OK to me now, you can add:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> As this patch depends on changes from the s3c tree, I guess you prefer
> to merge it yourself via that tree?

RMK currently has a large number of patches queued,
it would be nicer to him to merge this directly and
then pass him only the s3c specific bits to reduce
the chance of any conflicts. It isn't as if we've
currently got this enabled in the .config, so it
won't affect the autobuilders.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
