From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 29 Nov 2005 17:48:36 +0000
Subject: [lm-sensors] How to support 2.6.9 kernel with w83792d driver
Message-Id: <438C8663.8080100@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7B75F@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7B75F@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
> Hi Rudolf,
> Nice to see you again, I think you have gone back to your hometown these
> days, so I did not resend that mail ;)

I'm going there regulary every weekend.

> I have one question to ask you,(I have so many questions ...)

Well why not... :)

> 
> We just received a request from our customer ASUS and they would like to
> use 792D lm-sensor driver on Redhat Enterprise Edition Workstation
> Update 2 with kernel 2.6.9. The original 792D driver Chunhao implemented
> did work on 2.6.10 kernel but it quitted working on 2.6.9 (the one
> Redhat uses for Enterprise edition). I made some tiny modification to
> original driver and it works now.


OK I once told TeCheng that I have also some backport which can be found here:
http://www.assembler.cz/download/w83792d/

If you did backport the driver please consider applying the
http://www.assembler.cz/download/w83792d/04-fix-disabled-subclients

For sure, and optionally the:
http://www.assembler.cz/download/w83792d/03-cleanups (or check what is really wrong)

Plus dont forget your recent fixes.

> My question is that should we send this patch to you? As far as I know,
> there are some changes in lm-sensor architecture as of 2.6.14 kernel.
> The patch should be applied to the ORIGINAL source Chunhao submitted
> instead of the newest one. What's your opinion on this issue? Many of
> ASUS customers might use Redhat Enterprise edition instead of free
> Fedora core so that it would be a good idea if we can figure out this
> before the real problem comes.

I can put it to that website as another version of the driver and link this page from lm-sensors
if you want.

My backport is without your recent fixes so I will fix it someday too...

I hope this helps, If anything more let me know.
Regards
Rudolf
