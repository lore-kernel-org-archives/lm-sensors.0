From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: fan speeds and temps no reading
Message-Id: <20050113215149.49cf3292.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hey,
> 	Jean,
> 		I'm doing it now, but is it supposed to do this
> 
> [root@bambi ~]# isaset -y -f 0x2e 0x87
> Data mismatch, wrote 0x87, read 0xff back.
> [root@bambi ~]# isaset -y -f 0x2e 0x87
> Data mismatch, wrote 0x87, read 0xff back.

Don't worry, mismatches are expected. Sorry, I should have told you.

Dump is OK, but the logical device is disabled, so some information seem
to be hidden. We will have to enable it.

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87
isaset 0x2e 0x2f 0x07 8
isaset 0x2e 0x2f 0x30 1
isadump 0x2e 0x2f > w83627thf-ld8.dump
isaset -y -f 0x2e 0xaa

Beware this is slightly more risky that the previous set of commands,
although I think it should be OK. Don't do it if you couldn't afford a
system reboot or just don't feel like it.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
