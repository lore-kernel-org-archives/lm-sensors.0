From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Dec 2007 13:29:27 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <20071218142927.5e8a0bb0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 17 Dec 2007 16:56:24 +0100, Hans de Goede wrote:
> I finally found / made some time to try out using your below patch in the 
> fschmd driver. Your patch works as advertised, I'll send a mail with a patch to 
> the fschmd driver using its functionality right after this mail. I guess this 
> is 2.6.25 material and that we should queue both patches for 2.6.25.

OK, great. I agree that this is 2.6.25 material

My patch is not hwmon-specific so even if it is easier to push it
through Mark's hwmon tree, I'd like to know what other developers think
about it; I'll post it to LKML for comments later today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
