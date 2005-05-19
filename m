From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: ask us for one! Driver, pleaseeeee ;)
Message-Id: <20040515081802.3a8cb5d1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405112318.48023.aife@netvisao.pt>
In-Reply-To: <200405112318.48023.aife@netvisao.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> #----cut here----
> # I2C adapter drivers
> i2c-sis96x
> # modprobe unknown adapter bt878 #0 [sw] using Algorithm unavailable
> # I2C chip drivers
> # no driver for Asus ASM58 Mozart-2 yet, ask us for one!
> #----cut here----
> 
> Thx for your great work! 
> Could you work on the above driver?

There is no datasheet available. We got some information from Alex van
Kaam, everything is summarized in the doc/chips/w83781d file:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d

It should be sufficent to start writting a preliminary driver.

None of us developers has a board with such a chip AFAIK. So it's
unlikely that any of us will write the driver, although I remember Mark
M. Hoffman stating he would give it a try, a long time ago.

It's almost unpossible to write a driver for a chip when there is no
datasheet and you don't own the chip yourself. So your best chance is
probably to write the driver yourself, starting from an existing driver
(asb100 maybe) with the docs mentioned above. There is a guide here:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/new_drivers

And also in the lm_sensors package.

-- 
Jean Delvare
http://khali.linux-fr.org/
