From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 28 Feb 2015 10:00:33 +0000
Subject: Re: [lm-sensors] Patch and Upstart file for healthd.sh
Message-Id: <20150228110033.49497172@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150226233151.GA17731@alpha.somenet.pw>
In-Reply-To: <20150226233151.GA17731@alpha.somenet.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi vbooh,

On Fri, 27 Feb 2015 02:31:52 +0300, vbooh wrote:
> I want to propose a patch for healthd.sh and also an Upstart init file for it.

I didn't know people were still using that old piece of code :-D

I don't want to commit the Upstart init file, because such files depend
on the distribution. So I think it is better to let each distribution
maintain its own initialization files.

> A patch is for a decreasing of the resource consumption by healthd.sh; it replaces the external commands with the built-in Bash commands. It did not make a huge difference, but it was still useful in my case.

This is a sane goal, in fact we did similar changes to fancontrol some
times ago for the same reason. Patch committed, thanks for your
contribution. The read trick is very nice, I didn't know about it, I'll
probably do the same in fancontrol as well as the current
implementation was reported to cause problems.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
