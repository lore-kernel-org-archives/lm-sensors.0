From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 19 Jun 2005 09:14:23 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <42B51B40.9080204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ooops I'm still bit sleeping :)

Rudolf Marek wrote:
> Hi,
> 
> It seems you did what I did not wanted.
> 
> You need to have compiled lm85 module, when you will configure the kernel you can turn on also debugging in I2C submenu.


you can also try:

> Please run following commmands:
> 0) reboot
> 1) modprobe i2c-i801
> 2) modprobe lm85 force_lm85b=0,0x2e
> 3) sensors


Tnx
Regards
Rudolf

