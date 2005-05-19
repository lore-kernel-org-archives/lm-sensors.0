From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <8jwXkGvz.1107425843.3406760.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> We are going to port w83792d.c from 2.4 to 2.6
> And after the final test to them, we will commit both w83792d.c.
> for linux-2.4 and for linux-2.6.

This is good news. That said, we don't really have to wait for you to
finish porting to 2.6 before we commit your 2.4 driver to lm_sensors
CVS. Both sides are mostly independent. I guess we can commit the 2.4
driver as soon as MDS is happy with your code (I admit I don't have
much time to review it myself).

> I'm reading Documentation/i2c/porting-clients.
> And I have one question which need your suggestion:
>
> Now I have a Fedora Core 3 release, with the kernel 2.6.9.
> If I want to port on this system, Need I download and compile
> the up-to-date linux kernel such as linux-2.6.11-rc3.tar.bz2,
> then use it as my development environment?

Yes, you should always stick to whatever the latest 2.6 tree is. That way
you are certain that your code with comply with the latest evolution of
the 2.6 i2c core.

When the driver is ready, you will have to send it to Greg KH, in the
form of a patch against the latest linux 2.6-mm version. Hopefully,
changes won't be too big between the latest standard 2.6 tree and the
2.6-mm version, so you won't have much to change at this point. You may
work directly with the latest -mm version if you want, but these are
typically less stable that the regular versions, so I wouldn't
recommend them as a development environment.

I tried to make Documentation/i2c/porting-clients as accurate as
possible, but I may have missed recent changes done to the i2c subsystem
in 2.6. If you find errors or missing information, please let me know so
that I can update the document.

Also note that the sysfs interface to hardware monitoring chips in 2.6 is
more standardized than the procfs one in 2.4 was, and you really have to
stick to that standard. See Documentation/i2c/sysfs-interface for
details. If you have questions about this or find an error in this
document, let us know as well.

Thanks,
--
Jean Delvare
