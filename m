From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 20:31:09 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <20050731203038.0d3c33ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

> > BTW: I would rather you didn't combine lm93.h into lm93.c, but
> > that's just my personal preference.
> 
> I did it that way because I wasn't sure how to encode the dependency
> information for a header file into the Makefile.  None of the other
> chip drivers have separate header files, so I wasn't able to get any
> guidance there.

lm75 does.

-- 
Jean Delvare
