From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Feb 2007 10:34:39 +0000
Subject: [lm-sensors] W83627DHG on ASUS P5W-DH Deluxe
Message-Id: <20070219113439.88a44f81.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D907E1.9040906@gmail.com>
In-Reply-To: <45D907E1.9040906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Berck,

On Sun, 18 Feb 2007 19:13:53 -0700, Berck E. Nash wrote:
> Using 2.6.20-mm1, I get the following error:
> 
> luna:~# sensors
> w83627dhg-i2c-9191-290
>  ERROR: Can't get adapter or algorithm?!?
> 
> sensors-detect says:
> 
> Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> 
> I've attached the entire sensors-detect log on the off chance it's
> interesting to someone.  Please CC me as I'm not subscribed.

The -mm tree has my experimental i2c patches included, one of which is
causing a change in sysfs which libsensors doesn't expect, thus the
error message you quoted above. If "sensors" plains stop because of
that, it probably means that you're using a relatively old version, as
newer versions keep displaying the data despite this error.

You may try "sensors -a" as a workaround, although I'm not sure if it'll
work properly on an old version.

If you want sensors to work perfectly with the current -mm tree, you
need lm-sensors SVN. You can download snapshots from:
http://dl.lm-sensors.org/lm-sensors/snapshots/

Thanks for reporting anyway, it's always nice to hear back from
testers :)

-- 
Jean Delvare

