From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 08:12:08 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20091202091208.504f61a8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Tue, 1 Dec 2009 16:03:24 -0500 (EST), Sean Fidler wrote:
> Your instructions worked!

Wow. This is more than I hoped for :)

> I'm assuming I have to load up fancontrol manually (via a script) each time, isaset instructions need to be 
> repeated after each boot up, right? Maybe I'm missing something.

Yes, you are correct, the changes done by the isaset commands are lost
on reboot.

> I was able to set up fancontrol via the pwmconfig and the fan slowed 
> down. Hopefully, it will speed up when necessary.

You should be able to check this easily by putting fake load on the CPU
(for example with "md5sum /dev/zero").

What does the output of "sensors" look like?

> The first and last isaset lines returned the following:
> isaset -y -f 0x2e 0x55 -> Data mismatch, wrote 0x0a, read 0xff back.
                                                 ^^^^
It really said 0x55, not 0x0a, right?

> isaset -y -f 0x2e 0xaa -> Data mismatch, wrote 0xaa, read 0xff back.
> 
> These mismatches, of course, didn't effect the end result. Maybe they 
> indicate something that I'm obviously not aware of.

These warning messages were expected, sorry for not telling you in
advance.

> Your help with this issue is greatly appreciated. Thanks.

You're welcome.

Would you be able to test kernel patches? I think it would make sense
to let the smsc47m1 driver enable access to the fan speed monitoring
and control registers at least on your specific machine, and possibly
on all systems where the base I/O address is properly defined (as the
w83627hf and w83627ehf drivers are doing for example.) I can do these
changes but I don't have any chip here to test the smsc47m1 driver, so
I need someone to do the testing for me.

To test kernel patches (or more specifically to build a patched
standalone driver) you will need gcc, make, the sources of your running
kernel (usually available as package "kernel-source" or similar) and
probably some distribution-specific knowledge on the topic.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
