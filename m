From: hiro_yuki_mori@yahoo.co.jp (Mori Hiroyuki)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Sensor results of P4P800
Message-Id: <20031209060416.5606.qmail@web1206.mail.yahoo.co.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Hoffman-san,

> > # echo 9.0
>/proc/sys/dev/sensors/w83627thf-isa-0290/vrm
> > 
> > After this, I read vid value.
> > 
> > # cat /proc/sys/dev/sensors/w83627thf-isa-0290/vid
> > 0.000
> > 
> > I still get 0.000. Why?
> 
> The w83627thf driver support for VID is broken. 
> I'll be
> fixing that shortly - hopefully in time for the
> 2.8.2 release.
> Please check back in about a week.
OK. I'll try again next week. Then I'll report.

> 
> > >As for the VCore 1 readings, you might need to
> divide the
> > value by 2.
> > >Never see that before though.
> > OK. I guessed so.
> 
> I think the driver is broken here as well.  Again I
> hope
> to fix this soon.
OK.

Mori Hiroyuki


__________________________________________________
Do You Yahoo!?
Yahoo! BB is Broadband by Yahoo!
http://bb.yahoo.co.jp/
