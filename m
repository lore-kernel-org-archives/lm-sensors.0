From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Jan 2014 08:02:32 +0000
Subject: Re: [lm-sensors] ASUS KGPE-D16 and CentOS 6.5
Message-Id: <20140109090232.25a2706b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E4175F3D57744A468314267E51135306@W710>
In-Reply-To: <E4175F3D57744A468314267E51135306@W710>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Seth,

On Wed, 8 Jan 2014 16:35:12 -0700, Seth Bardash wrote:
> (...)
> The CentOS based machine uses a much older kernel and libsensors
> code.
> 
> (opensuse) 3.7.10-1.16-desktop versus (CentOS)
> 2.6.32-431.el6.x86_64
> 
> I downloaded the w83795 code and compiled it.
> The loaded it with:
> 
> rmmod w83795
> modprobe hwmon
> modprobe hwmon-vid
> modprobe i2c-core
> insmod ./w83795.ko 
> 
> But get an error of no hwmon found.
> I even ran modprobe i2c-piix4 first then ran the commands above
> but
> there is no entry in dmesg and sensors -s then sensors does not
> show anything.

Odds are that you need an updated i2c-piix4 driver too. Check the PCI
ID of the SMBus controller (you can check which device got the
i2c-piix4 driver attached on your openSUSE 13.1 system.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
