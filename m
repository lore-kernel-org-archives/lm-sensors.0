From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 05 Mar 2015 08:34:05 +0000
Subject: Re: [lm-sensors] Patch and Upstart file for healthd.sh
Message-Id: <20150305093405.78aae251@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150226233151.GA17731@alpha.somenet.pw>
In-Reply-To: <20150226233151.GA17731@alpha.somenet.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi vbooh,

Adding the list back...

On Thu, 5 Mar 2015 01:59:29 +0300, vbooh wrote:
> Yes, I have checked a CPU load after applying the patch, but mostly using a manual launch in a command line('perf stat', 'time' external utility). In a daemon mode in my case it really increased CPU load(from 0.1% to 4.5%), but until you said I just did not notice that, since it is not so much. My bad.
> You were right, it looks like the 'read' command goes crazy without an attached terminal. I have found a pretty dirty hack around it, it requires some additional external utilities, but they are launched just once, not every 15 seconds, all the changes are in the attached patch. Now in a daemon mode 'healthd.sh' in my case consumes 0.0% of a CPU load.

I've looked around for such hacks and found several of them, including
this one indeed. I agree it works and is probably the least ugly and
unreliable, but it's still awkward compared to just calling sleep, and
in my opinion it's not nice enough to go upstream. We may run in all
kinds of compatibility and portability issues with that kind of code.

> Yes, the 'sleep' external utility can be compiled in 'bash', it was the very first tought of mine. But in Debian this must be done separately after an installation of an additional packages and in CentOS 7 there are even not all the needed files in the repository, so I have striked out that idea.

As far as I can see, Debian ships the loadable commands as source
files, not binaries, in package bash-builtins, right?  That doesn't
seem very useful :(

I agree that the availability of the loadable builtins is limited.
However I think this is a kind of chicken and egg problem:
distributions don't care much because there aren't many users of that
feature, and application authors don't want to use it because
distributions don't support it.

I'll talk to the upstream maintainers of bash about integrating it
better in their build system, to get the ball rolling. I really think
this is the way to go in the long term.

> Anyway thank you for your work.

You're welcome :)

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
