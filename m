From: paul.aviles@palei.com (Paul Aviles)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: No rule to make target
Message-Id: <000201c4ea05$a19e51e0$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for being a pain.. a lot of this stuff is new to me and I don't want 
to give up. Using

 rpmbuild -ba lm_sensors-rh.spec

I am getting this. I does work using a regular make, but I need to have an 
rpm. Guys, thanks so much for all your help.

Happy Holidays to all!!!!!

Paul



Module.mk' @' > kernel/busses/i2c-ipmb.d
cat kernel/include/sensors.h.template > kernel/include/sensors.h
make: *** No rule to make target `linux/rhconfig.h', needed by 
`kernel/chips/vt1211.d'.  Stop.
make: *** Waiting for unfinished jobs....
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >> 
kernel/include/sensors.h
make: *** Waiting for unfinished jobs....
echo '#endif' >> kernel/include/sensors.h
make: *** Waiting for unfinished jobs....
error: Bad exit status from /var/tmp/rpm-tmp.12994 (%build)



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
