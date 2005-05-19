From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: 64 bit
Message-Id: <ac921f990505051024bbe8862@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050501150050.3337.qmail@web30814.mail.mud.yahoo.com>
In-Reply-To: <20050501150050.3337.qmail@web30814.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/4/05, Mark Studebaker <mds@mds.gotdns.com> wrote:
> we don't have many reports about 64 bit
> best thing is to try it and let us know what doesn't work.
> You could start by sending us  the i2c-proc warning.
> thanks
> mds
>
Been running sensors on 2.4 based kernels for about a month now and have not 
seen any problems.  Initially, I had to remove the bit bangers from
the build, but the latest 2.9.1 release converted some bad assembler
to C and that fixed that.

Cheers...james
