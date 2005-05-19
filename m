From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: Hangs with w83781d
Message-Id: <20030408135058.0efe90a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> In recent versions of lm_sensors, once I load the w83781d driver, apm
> suspend stops working (immediately resumes), and I've experienced a
> number of hangs that must be related to this.
> 
> The problem exists in 2.6.5 and 2.7.0, but does not exist in 2.6.3.
> 
> The kernel I'm using is 2.4.20 (with the ext3 and ptrace patches); the
> motherboard is an abit bx6-r2 with the most recent bios.
> 
> Gcc is 2.95.3, binutils is 2.11.92.0.12.3, make is 2.79.1.
> 
> 
> I'm currently using i2c and lm_sensors 2.7.0 with the 2.6.3 w83781d
> module, and have noticed no problems so far since downgrading w83781d.


Thanks for the report. I2C and LM Sensors drivers are being completely
rewritten these days, for future incorporation into Linux 2.5. Thus, we
don't have much time left for bughunting. If you can live with your
current configuration, just don't touch anything ;) I think it's better
now to wait for the drivers to be incorporated into the main kernel
tree, and test them again then. If the problem still occurs at this
time, please let us know and we'll investigate.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
