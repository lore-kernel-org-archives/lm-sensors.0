From: PoWah Wong <wong_powah@yahoo.ca>
Date: Wed, 07 Nov 2007 21:54:57 +0000
Subject: [lm-sensors] how to create rpm for lm_sensors-2.10.5
Message-Id: <941005.10298.qm@web56302.mail.re3.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I use FC6 for a couple of computers, so I want to
create one rpm for lm_sensors-2.10.5 and install it
for all computers.
How to create rpm for lm_sensors-2.10.5?

This is a workaround, isn't it?
"make package" will create lm_sensors-2.10.5.tar.gz,
scp it to all computers, untar it, then do "make
user_install".



      Be smarter than spam. See how smart SpamGuard is at giving junk email the boot with the All-new Yahoo! Mail.  Click on Options in Mail and switch to New Mail today or register for free at http://mail.yahoo.ca 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
