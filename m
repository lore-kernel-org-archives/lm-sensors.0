From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Dec 2013 06:52:35 +0000
Subject: Re: [lm-sensors] MotherBoard Asus A55M-E
Message-Id: <20131204075235.469860aa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <529E3E56.3020804@yahoo.it>
In-Reply-To: <529E3E56.3020804@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 03 Dec 2013 23:20:36 +0100, Rudolf Marek wrote:
> > Trying family `ITE'...                                      Yes
> > Found unknown chip with ID 0x8603
> >      (logical device 4 has address 0x290, could be sensors)
> 
> There is a preliminary patch supporting this driver:
> 
> > http://khali.linux-fr.org/devel/linux-3/jdelvare-hwmon/hwmon-it87-01-add-it8603e-support.patch
> > Please let me know if I got anything wrong. Retesting would be
> > appreciated, just in case.
> >
> > I have also made the support available as a standalone driver which
> > builds at least down to kernel 3.0:
> > http://khali.linux-fr.org/devel/lm-sensors/drivers/it87/
> 
> Please note there is a (small) problem which will be fixed soonish. If you like 
> to try it out, apply attached patch on above patch or on the standalone driver.

Both the patch on in my queue and the standalone driver already include
the fix-up.

> You can also wait until it is fixed and released in next kernel version.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
