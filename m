From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 29 Jul 2006 13:29:13 +0000
Subject: [lm-sensors] Problem with W83792d
Message-Id: <20060729132913.GI25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CB36A9.9040502@hcl.in>
In-Reply-To: <44CB36A9.9040502@hcl.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nithin:

* Nithin <nithinkj at hcl.in> [2006-07-29 18:19:04 +0530]:
> 
> Hi,
> This is the output i got while issuing i2cdetect ,In this between 2c and 
> 2f nothing
> is seeing?
> 
> > [root at helinium root]# modprobe i2c-i801
> > [root at helinium root]# modprobe i2c-dev
> > [root at helinium root]# i2cdetect -y 0
> > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > I will probe file /dev/i2c-0.
> > I will probe address range 0x03-0x77.
> > Continue? [Y/n] y
> > 0 1 2 3 4 5 6 7 8 9 a b c d e f
> > 00: XX XX XX XX XX 08 XX XX XX XX XX XX XX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 30: XX XX XX 33 XX XX XX XX XX XX XX XX XX XX XX XX
> > 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> > 50: XX XX XX 53 XX XX XX XX XX XX XX XX XX XX XX XX
> > 60: XX 61 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX


Well, this shows that your I2C bus is working, at least.  But obviously
your sensor chip is not visible at 0x2f.  As Jean Delvare advised, see
if there is a newer BIOS version available.  Otherwise, you'll have to
wait for our Asus contact to reply.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


