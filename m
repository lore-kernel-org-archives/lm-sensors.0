From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 27 Jun 2007 15:19:56 +0000
Subject: Re: [lm-sensors] Hacking on libsensors
Message-Id: <4682801C.3050303@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070626142055.079a4d89@hyperion.delvare>
In-Reply-To: <20070626142055.079a4d89@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> My employer, Novell, has organized a "hack week". This is one week where
> every employee is free to hack on whatever he/she wants [1].
> Unsurprisingly I decided I would spend that time on libsensors. I
> posted the idea here:
> http://idea.opensuse.org/content/ideas/generic-sensors-library
> 


It sounds like an excellent plan to start working on the 3.0 branch! Let me 
know if you need any help, and/or when you want me to test this on the machines 
I have access too.

Regards,

Hans

p.s.

Some time ago we had a discussion about amongst other things some bad 
assumptions in the generic voltage printing code. I promised to fix this, but 
its still on my todo, I will happily fix this once things stabilize (I would 
like to avoid svn commit conflicts), if you feel inclined to fix it yourself 
thats fine too, here is the important part of our previous conversation on this:

 > Also print_generic_chip_in(), has some dangerous and unneeded assumptions, for
 > example:
 > -it assumes that if there is a inX_max that there will also always be a inX_min
 > -it assumes that if there is no inX_max there will also be no alarms
 >
Somewhat less "unneeded" assumption
 > -it doesn't check for inX_max_alarm without an inX_min_alarm and visa versa, I
 >   admit this would be a driver bug, as then the driver should have just a
 >   inX_alarm, but still we might want to concider this.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
