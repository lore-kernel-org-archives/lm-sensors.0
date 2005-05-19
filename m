From: m.strong@tnsa.com.au (Mark Strong)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: fan speeds and temps no reading
Message-Id: <1105652131.15001.191.camel@tooheys.tnsa.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
	here's the data

[root@bambi ~]# isaset -y -f 0x2e 0x87
Data mismatch, wrote 0x87, read 0xff back.
[root@bambi ~]# isaset -y -f 0x2e 0x87
Data mismatch, wrote 0x87, read 0xff back.
[root@bambi ~]# isaset 0x2e 0x2f 0x07 8
WARNING! Running this program can cause system crashes, data loss and
worse!
I will write value 0x08 to address 0x07 of chip with address register
0x2e
and data register 0x2f.
Continue? [Y/n]
[root@bambi ~]# isaset 0x2e 0x2f 0x30 1
WARNING! Running this program can cause system crashes, data loss and
worse!
I will write value 0x01 to address 0x30 of chip with address register
0x2e
and data register 0x2f.
Continue? [Y/n]
[root@bambi ~]# isadump 0x2e 0x2f > w83627thf-ld8.dump
WARNING! Running this program can cause system crashes, data loss and
worse!
I will probe address register 0x2e and data register 0x2f.
Continue? [Y/n]
[root@bambi ~]# isaset -y -f 0x2e 0xaa
Data mismatch, wrote 0xaa, read 0xff back.
[root@bambi ~]#


Mark.

ps Its a development server, just built, so I can afford a reboot or
two.
