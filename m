From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 25 Feb 2006 15:37:54 +0000
Subject: [lm-sensors] Added hysteresis to fancontrol
Message-Id: <440079D2.30206@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060124032204.GG28986@paradise.net.nz>
In-Reply-To: <20060124032204.GG28986@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Volker Kuhlmann wrote:
>>Now after a release is good time to go on and apply it. Have you some
>>new version?
> 
> 
> Everything I have is here:
> http://volker.dnsalias.net/linux/tech/lm_sensors/

OK

> No change to /usr/sbin/fancontrol since I posted it to this list on 24
> Jan, and it works very well for me, but I added more comments just now.
> The script is a complete tidyup, the diff is longer than the file.
> 
> If you have the idea to pick'n'mix, pay attention to the sleep and
> signal handling, or you'll break the usability of the fancontrol script
> within system service scripts. The construction I have now is already in
> SUSE 10.1 and works, don't unfix it.
> 
> I haven't put the hysteresis handling into pwmconfig yet, and because I
> don't really need it myself, I'm reluctant to work on it unless I can
> feel somewhat assured that it'll make it into the official source.

Well if you want to be an anctive maintainer for this type of stuff you will
be wellcomed.

> Someone posted a patch to fancontrol on 14 Feb, the only real difference
> to my script I can see is that awk is no longer used. In my opinion I
> don't see the point, awk is a low-resource barebones program which can
> be relied upon to exist for system services (remove it and your system
> will no longer as much as boot). The expression evaluation is also
> better and less headachey in gawk than in bash.

I think I agree with you.

> The fancontrol also needs to be started by /etc/init.d/lm_sensors, I had
> added that and SUSE made some more changes to it. The current state is
> at the above URL. Works fine for me.


Ok I will check everuthing once I'm able to commit into SVN.

Thanks,
Regards
Rudolf

