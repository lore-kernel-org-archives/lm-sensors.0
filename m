From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 19 Jun 2005 09:10:33 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <42B51A5A.9080101@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

It seems you did what I did not wanted.

You need to have compiled lm85 module, when you will configure the kernel you can turn on also debugging in I2C submenu.

Please run following commmands:
0) reboot
1) modprobe i2c-i801
2) modprobe lm85 force=0,0x2e
3) sensors

Does it produce anything?
Output, or in system log?


>>1) reboot the computer
> 
> 
>   1a) `modprobe i2c-dev`
true I forgot :)
> 
> 
> 
> Attached.  I should note that the diff of before and after does show
> several changed lines...

Yes but it is not a winbond chip. It did not changed it expected way.

Regards

Rudolf
