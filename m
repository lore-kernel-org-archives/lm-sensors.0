From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 Jun 2010 07:44:25 +0000
Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
Message-Id: <20100627094425.446ad5e8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
In-Reply-To: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ulf,

On Sat, 26 Jun 2010 22:46:13 +0200, Ulf Granlund wrote:
> However, I have one last question. Since the processor only has two physical cores, butI get four readings, is there some way to tell which values are the ones from the realcores?

The coretemp devices are enumerated in the same order as /proc/cpuinfo
entries. On my system, the physical cores are enumerated first, and
hyper-threaded siblings are listed next, which means I can ignore the
second half of the entries. If this is the same for you, then you only
care about coretemp.0 and coretemp.1, and can ignore coretemp.2 and
coretemp.3. But better double-check with /proc/cpuinfo.

Note that I don't think the coretemp driver properly labels the
sensors. It enumerates the CPU entries linearly without any check. Not
only it is wrong because of HT (which my patch should address) but it
also gets wrong on multi-CPU systems, because it should start down from
0 for the second CPU but doesn't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
