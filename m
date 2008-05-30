From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 May 2008 11:51:35 +0000
Subject: Re: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <20080530135135.3779ed35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 23 May 2008 16:10:41 +0200, Hans de Goede wrote:
> It has been reported that the abituguru3 driver fails to load after a BIOS
> update. This patch fixes this by loosening the detection routine so that it
> will work after the BIOS update too. To compensate for the now very loose
> detection an additional check is added on the DMI Base Board vendor string to
> make sure we only load on Abit motherboards, this is the same as the check in
> the abituguru (1 / 2) driver.
> 
> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

I'm trading the review of this patch for the review of one of mine, for
example:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022998.html
Or any other you'd like. Deal?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
