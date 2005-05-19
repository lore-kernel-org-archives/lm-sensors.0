From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-matroxfb
Message-Id: <20030718112430.GA22673@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710182523.4ceef8fa.khali@linux-fr.org>
In-Reply-To: <20030710182523.4ceef8fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all, I'm back...

* Jean Delvare <khali@linux-fr.org> [2003-07-10 18:25:23 +0200]:
> 
> The problem I encountered is that scanning the I2C bus of my Matrox
> Mystique is very, very slow. As slow as lasting 30 minutes where scaning
> other devices last a few seconds only. The problem shows when
> sensors-detect is run, or when i2c-detect is run on the bus as well.

I saw it mentioned (maybe on LKML) that this driver has an overly long
I2C bus timeout - something like 30 seconds or so.  That's silly.

I have an ancient Millenium II to test with, if anyone needs.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
