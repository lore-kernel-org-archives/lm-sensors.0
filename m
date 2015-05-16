From: Chris Godbout <chris@mathologist.net>
Date: Sat, 16 May 2015 19:30:38 +0000
Subject: [lm-sensors] sensors-detect and my monitor
Message-Id: <loom.20150516T211122-274@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Lenovo g50-80 laptop with Arch linux installed. I went to get
lm-sensors working since I couldn't get the temperature with acpi -t on this
laptop. Anyway, I started by doing sensors-detect, which I've done on
computers in the past. I know I should have stuck with the defaults, but I
didn't. Instead, I hit yes for everything which hasn't been a problem before.

Everything was fine until I probed DPDDC-A (i2c-6). It went through a list
of sensors and part way through it my screen flickered. Afterwards, my
monitor got really bright and the colors were all washed out. Unfortunately,
I'm colorblind and have a hard time describing it more than that.
Additionally, in large blocks of the same color it's almost as if I can see
the individual pixels and some of them are actually black. This may be an
optical illusion, but when I look closely, it's almost as if they're moving.

The output of my sensors-detect is here:http://pastebin.com/zw1hy66h

I don't know where, exactly, the flicker happened. I know it was near the
end. The flicker happens whenever it probes everything under DPDDC-A. Also,
there's no change in my xorg log.

Any suggestions, even if it's where else to look for help? Any other logs
you need?

Thanks


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
