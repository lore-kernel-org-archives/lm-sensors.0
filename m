From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jan 2013 08:49:12 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <20130107094912.40137a7d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Leslie,

On Sat, 5 Jan 2013 11:58:22 -0600, Leslie Rhorer wrote:
> so I downloaded the source
> code for it87 from http://khali.linux-fr.org/devel/misc/it87.  When I
> attempt to run `make`, however, it complains: "*** No rule to make target
> `modules'.  Stop."  I don't see anything wrong with the Makefile, but then I
> am far from being an expert on Makefiles.  Does anyone have a suggestion?

Builds just fine for me. Please make sure all files are still using
Unix (not DOS) line ending. Also make sure that you have installed all
packages your distribution provides for kernel building.
http://khali.linux-fr.org/devel/misc/INSTALL has suggestions on what
may be needed. I'll be happy to update that file if something is
missing and you can figure out what it is.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
