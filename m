From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: vt8231 and kernel 2.6.2 on RH 9
Message-Id: <1076668153.402ca6f9ec2a9@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040212140756.48144.qmail@web40104.mail.yahoo.com>
In-Reply-To: <20040212140756.48144.qmail@web40104.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

Quoting Weijia Tao <taoweijia@yahoo.com>:

> sensors-detect says it is vt8231, and according to the
> main board specs, it is vt8231. 
> after installing lm_sensor i can't even found vt8231.o
> anywhere.
> modprobe i2c-viapro works
> modprobe i2c-isa works
> modprobe i2c vt8231 doesn't work.
> thanks

Sorry I told you wrong. I had just plain forgotten that there were also
a vt8231 sensor chip driver.

If sensors-detect tells you that's what you need, well, that's what you
need. Unfortunately, this driver hasn't been ported to Linux 2.6 yet,
as you have noticed.

You now have two options:
* You feel fairly comfortable with C and want to port the driver
yourself. See my guide Documentation/i2c/porting-clients in the Linux
2.6 tree.
* You wait until someone else port the driver. Very variable delay, from
two weeks if you're really lucky to forever if you really aren't.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
