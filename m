From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Nov 2008 15:30:58 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <20081123163058.0f3fc004@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marco,

On Sun, 23 Nov 2008 16:23:52 +0100, Marco Chiappero wrote:
> [1] By the way, I patched the lm-sensors package too, the compilation
> runs fine but "sensors" is still unable to show the atk readings.

If you use lm-sensors 3.0.2 or later and if the atk0110 driver
implements the standard sysfs interface (it really should), then you
shouldn't have to patch anything, it should work out of the box.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
