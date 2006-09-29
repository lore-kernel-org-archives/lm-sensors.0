From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 29 Sep 2006 14:30:47 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <451D2E17.3070502@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Please check the new version on http://assembler.cz/download/coretemp/

It has:

1) code improvements
2) support for critical temperature alarm
3) shows the TjMax temperature
4) hotplug CPU support
5) new bugs? ;)

there is also a patch for userspace - should be applied on top of the SVN HEAD.

Please test it and let me know how the output of "sensors" command looks like. I
believe this version is less dangerous to use than a first one, but of course I
cannot guarantee that. All I know is that it compiles...

Any testing is appreciated.

Thanks,

Rudolf

