From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 14:26:12 +0000
Subject: Re: [lm-sensors] Intel DP35DP - P35 Sensor Support?
Message-Id: <20071028152612.63bd58e5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071015T022008-788@post.gmane.org>
In-Reply-To: <loom.20071015T022008-788@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 15 Oct 2007 02:23:17 +0000 (UTC), d.d. wrote:
> I'm seeing only 2 CPU core temperatures, but am unable to pick off any other
> sensors (but I know they are there...)
> 
> Any luck with the Intel Desktop DP35DP Motherboard / P35 / ICH9 ?

The ICH9 integrates sensors we don't support yet. Your motherboard may
or may not use these.

> Running Linux Kernel:
> 2.6.22.9-91.fc7 #1 SMP Thu Sep 27 20:47:39 EDT 2007 x86_64 x86_64 x86_64
> GNU/Linux

Did you try running the latest version of sensors-detect? What did it
find?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
