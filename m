From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 28 Nov 2008 16:17:27 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-watchdog-v4.patch
Message-Id: <20081128171727.1d911fbc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <493007E2.4070101@redhat.com>
In-Reply-To: <493007E2.4070101@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 28 Nov 2008 16:01:54 +0100, Hans de Goede wrote:
> Hi Jean,
> 
> Today I had access to my FSC test machine for the first time in a while. So 
> here is the latest version of my watchdog support for Siemens hwmon IC's patch. 
> This fixes the last 2 issues you spotted during review. Can you please queue 
> this for 2.6.29 ? If Wim comes up with anything during his review I'll fix that 
> with a follow up patch,

Applied, thanks. Now I'm waiting for the patch which deprecates fscher
and fscpos :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
