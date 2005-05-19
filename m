From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: i2c-2.8.1, lm_sensors-2.8.1 on 2.4.23 ?
Message-Id: <20031202232003.46664b6f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY2-F97P0KlixRXmvB00001474@hotmail.com>
In-Reply-To: <BAY2-F97P0KlixRXmvB00001474@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I installed the linux-2.4.23-i2c-2.8.1.patch and tried to use
> i2c-2.8.1 and lm_sensors-2.8.1, when I try to run:
> 'prog/detect/sensors-detect' it comes back saying a mod was compiled
> for 2.4.22, that I try to have it load. I thought this patch works for
> 2.4.23 ? I had the sensors before working on 2.4.22, but I thought
> this patch was an update to get it to work on 2.4.23 but it's
> not working.
> Thank you for your time, and help in this matter.

I don't know exactly what you did, but here's what you are supposed to
do:

1* Patch you 2.4.23 kernel sources with this patch:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.23/linux-2.4.23-i2c-2.8.1.patch
2* Configure, compile and install that kernel.
3* Get lm_sensors 2.8.1 (or preferably CVS). Edit the Makefile so that
I2C_HEADERS will point to your linux tree. Compile and install.
4* Run ldconfig.

And everything should be working. As you'll have notice, you *have* to
recompile and reinstall lm_sensors for your new kernel. The patch has
been tested by enough people so we know it works OK if you follow the
instructions above.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
