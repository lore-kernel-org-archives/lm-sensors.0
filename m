From: brianpap22@yahoo.com (Brian Papantonio)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: 'sensors' never installed
Message-Id: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I installed i2c-2.7.0 and lm_sensors-2.7.0, and
"values" are reported in
/proc/sys/dev/sensors/as99127f-i2c-0-2d/ "properly",
but they are way off:

]# cat < temp1 temp1 temp2 temp3
60.0 50.0 33.0
60.0 50.0 27.0
60.0 50.0 112.2

those are in deg C, right? temp1 seems to be ok
assuming it is the mobo. I dunno what the hell temp2/3
are supposed to be.

I try editing /etc/sensors.conf, but no changes to
compute temp2/temp2 have any effect. i try to do
"sensors -s" but it says "command not found"--it never
got installed (I cant find it anywhere on my system).
Something tells me that getting 'sensors' installed
will be a bitch, so is there a way to "manually"
update the compute line in libsensors somewhere? it
must be stored somewhere, because I restart the
computer, and the values for temp1/2/3 never change,
so the sensors.conf file must not be being reloaded
(it is set to startup, which works).

Thanks,
Brian


==========
Asus A7V-266-E
Linux 2.4.20-8+RH_9.0

[root@x]# lsmod
Module                  Size  Used by    Not tainted
via686a                 9696   0  (unused)
w83781d                22608   1 
i2c-proc                9040   1  [via686a w83781d]
i2c-isa                 1832   0  (unused)
i2c-viapro              4912   0  (unused)
i2c-core               19012   0  [via686a w83781d
i2c-proc i2c-isa i2c-viapro]




__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
