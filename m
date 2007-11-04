From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Nov 2007 22:07:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gl518sm) Fix the reported fan speed
Message-Id: <20071104230739.5ecebed9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071023140224.0f8ca055@hyperion.delvare>
In-Reply-To: <20071023140224.0f8ca055@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Oct 2007 14:02:24 +0200, Jean Delvare wrote:
> The fan speeds reported by the gl518sm driver are twice as much as they
> should. It's currently reporting the number of pulses per minute, not
> rotations per minute, while typical fans emit two pulses per rotation.
> This explains why all reports with this driver had very high speed
> values (between 9000 to 12000 RPM). Odd that nobody ever actually
> complained about this bug.
> (...)

Hong-Gunn Chew tested the gl518sm driver with my 6 patches applied and
reported success.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
