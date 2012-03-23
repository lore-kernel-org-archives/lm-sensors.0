From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 23 Mar 2012 12:41:18 +0000
Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <20120323134118.7e832c20@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
In-Reply-To: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 23 Mar 2012 10:59:20 +0100, Tomas Johansson wrote:
> > Date: Fri, 23 Mar 2012 10:05:42 +0100
> > From: khali@linux-fr.org
> > On Fri, 23 Mar 2012 10:00:09 +0100, Tomas Johansson wrote:
> > > Because, these are idle values:
> > > 
> > > BIOS:
> > > SYS 34 C
> > > CPU 32 C
> > 
> > Most likely the above are NOT idle values. The BIOS is not idle - at
> > least never as idle as Linux can be with CPU frequency and voltage
> > scaling and low C states.
> 
> I have CPU freq scaling and voltage scaling turned of, both in BIOS and in the compiled kernel. Do not know what C states.

Google does know about them, for example:
http://www.hardwaresecrets.com/article/611

You don't need to know about the implementation details though. The
bottom line is: when implemented properly, a CPU consumes way less
power and generates way less heat when idle than when used.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
