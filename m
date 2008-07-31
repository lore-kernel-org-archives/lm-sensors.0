From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 31 Jul 2008 16:48:26 +0000
Subject: Re: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <20080731094826.b6af62a2.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 31 Jul 2008 12:30:05 +0200 Hans de Goede <j.w.r.degoede@hhs.nl> wrote:

> Hi Andrew,
> 
> As discussed I'm sending this patch directly to you for 2.6.27 inclusion as 
> Mark seems to be out of the loop at the moment.
> 
> Alistair John Strachan wrote:
> 
> "After updating my BIOS (from 16 to 17) the driver has stopped loading
> again. This is with 2.6.26-rc8. The reason is that the command byte has
> changed value to 0xFF (this is reproducible across cold and warm starts).
> 
> The following diff fixes it."
> 

OK, I'll prepare a hwmon patchbombing over the next few days.

Regarding this patch:

a) "abituguru3-fix-detect.patch" isn't a nice title.  I retitled it
   to "hwmon: fix loading of abituguru3 on Abit IP35 Pro with BIOS 17"

b) The way you presented this email would cause the patch to be
   attributed to yourself.  However I have a suspicion that Alistair
   wrote it.

   If this was the case then the way to communicate that authorship
   is to put his From: line right at the start of the changelog.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
