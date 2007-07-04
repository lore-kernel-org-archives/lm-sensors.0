From: "Shane Huang" <shane.huang@amd.com>
Date: Wed, 04 Jul 2007 07:11:07 +0000
Subject: [lm-sensors] How to test the SMBus driver only?
Message-Id: <FFECF24D2A7F6D418B9511AF6F35860201F98E85@shacnexch2.atitech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings:

I have a question here:
After one busses driver(e.g. i2c-piix4.c) add support to a new SMBus
controller(e.g. ATI SB600):
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;hN6697fcc194db8b45559a9863947c6cbfeea363

How can I know this new SMBus controller's support has really
taken effect?

As I know, if I have a hardware monitor device chip, and it uses the
SMBus driver, then I can verify the function of SMBus driver by the
"sensors" program after load the bus and device driver. But if the
motherboard with SB600 does NOT contain such monitor chip, how can
I verify that? Is there any test tools which can verify the SMBus
controller driver only? Can "sensors-detect" do some help?


Thanks
Best Regards
Shane



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
