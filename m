From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH] prog/sensors and CONFIG_SYSCTL
Message-Id: <20040509223839.0e311259.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040416194744.GD31563@pc.aurel32.private>
In-Reply-To: <20040416194744.GD31563@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On a 2.4 kernel, the sensors program displays an error message when in
> can't open the /proc/sys/dev/sensors/. It suggests to load the
> i2c-proc module. However the problem could also comes from the
> CONFIG_SYSCTL parameter which is not enabled in the kernel.
> 
> The attached patch make the error message a little more verbose.
> Please feel free to apply it or not.

I chose a different fix. i2c-proc now fails to compile if sysctl support
is missing, so the case above cannot happen anymore.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
