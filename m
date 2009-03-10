From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Mar 2009 11:02:29 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: Remove leading whitespaces in
Message-Id: <20090310120229.1578ce9b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310083014.GA5543@ubuntu>
In-Reply-To: <20090310083014.GA5543@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Andre,

On Tue, 10 Mar 2009 11:45:42 +0100, Andre Prendel wrote:
> Another question for you. How can I get rid of the committed patches
> in quilt? Google don't give me much information about that. Once I
> have committed the patches, I want to remove them from the series. I want
> to remove them completly from quilt without unapplying the
> changes. What's the right approach, do you know?

quilt unfortunately doesn't support this operation. My own method is
the following: once patches have been applied upstream, I remove them
manually from patches/series, and then rm -rf .pc. Then you can delete
the patch files from the patches subdirectory if you don't want to keep
a copy of them.

The alternative is to pop the patch before you commit it, apply it
manually (patch -p1 < patches/$(quilt next)), commit it, and the delete
it (quilt delete -rn).

The lack of this functionality has been discussed on the quilt-dev
mailing list some times ago. Everybody agreed if would be pretty much
needed, unfortunately implementing it in a safe and clear way is not
trivial, because it changes the logic from a stack-based one to a
FIFO-based one. If the implementation is not crystal clear and
ultra-safe it would be very easy to screw up your source tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
