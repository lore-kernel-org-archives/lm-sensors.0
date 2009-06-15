From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Jun 2009 20:02:24 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] hwmon: (abituguru3) DMI probing on
Message-Id: <20090615220224.6db894f6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1244913674-9633-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1244913674-9633-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alistair,

On Sat, 13 Jun 2009 18:21:11 +0100, Alistair John Strachan wrote:
> These patches have been compile and runtime tested.
> 
> They switch AB9, AB9 QuadGT and IX38 QuadGT mainboards over to using
> the DMI probe method. The testers have been credited appropriately.
> 
> (The driver currently supports 17 models, 7 are now using DMI.)

I think it's somewhat overkill to split these changes into 3 patches. I
don't really expect a regression here, and if it were to happen, I'm
reasonably certain we would figure out which change is faulty without
reverting the patches.

Care to resubmit as a single patch?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
