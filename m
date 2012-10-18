From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 18 Oct 2012 11:12:05 +0000
Subject: Re: [lm-sensors] quesion about i2cdetect and i2cget
Message-Id: <20121018131205.02a9554e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADt+=H2ycekqH+QzydqTx17H-wnYp-aTkRbU3D9uCPCAj_iH3A@mail.gmail.com>
In-Reply-To: <CADt+=H2ycekqH+QzydqTx17H-wnYp-aTkRbU3D9uCPCAj_iH3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 18 Oct 2012 18:18:55 +0800, Raymond Kao wrote:
> I built i2c tools from the source i2c-tools -3.1.0 and try to use it to
> access my home brew DM3730 board. When I use i2cdetect to check I2c bus,
> the error "controller timed out" happens, but if I run i2cget to retrieve
> data from the device, it can get the right result. I checked the code to
> look for the difference, and found that in i2cget.c, the code
> 
> res = i2c_smbus_write_byte(file, daddress);
> 
> has been called before read data from device, which seems to set register
> address for reading.  In i2cdetect.c, there is no instructions like this. I
> am not sure if this causes the time out error, since i2cdetect app can scan
> other devices on the bus correctly.
> 
> Can anybody can help me to understand why this happens? Thank you very much.

This question is unrelated to hardware monitoring. Please ask on the
linux-i2c list instead:
http://vger.kernel.org/vger-lists.html#linux-i2c

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
