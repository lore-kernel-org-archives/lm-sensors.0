From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Problmem report
Message-Id: <20030616091453.5df69e51.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EEB9F68.4040308@yahoo.fr>
In-Reply-To: <3EEB9F68.4040308@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Should be, unless Mandrake used the patched-kernel possibility (in
> > which case i2c is included in the kernel, so to say). Please make
> > sure however, using the following command:
> > rpm -qa | grep i2c
> > (and you can also try the same for "sensors", just in case)
> >
> no answer for i2c
> 
> For sensors :
> ksensors-0.7.2-4mdk
> liblm_sensors1-2.7.0-2mdk
> lm_sensors-2.7.0-2mdk

So we can assume Mandrake's kernel is i2c-patched. This will make our
job a bit harder, since you won't be able to upgrade i2c and lm_sensors
to CVS (and lm_sensors CVS won't work with i2c 2.7.0).

> > You can also check from which package do i2cdump and i2cdetect come
> > from, providing they're installed on your system.
> > 
> I do have i2cdump, i2cdetect, and i2cset.
> package , they all come form lm_sensors

Good news. At least we have some tools to work with.

The first thing I'd like you to try is an updated version of
sensors-detect. You can grab it from there:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

If possible, i'd be better if you could perform a cold reboot prior to
running the script. I'd like to make sure your hardware (I2C bus for
that matter) is peaceful and no nasty module is lurking.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
