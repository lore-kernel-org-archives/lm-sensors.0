From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: p4b_smbus
Message-Id: <3F47D83E.4050600@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030724161820.65ca2ba7.khali@linux-fr.org>
In-Reply-To: <20030724161820.65ca2ba7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You mean "SMP" right? :)
make -f Makefile.p4b SMP=1 works for me.
If you have a report with more info please point me to it.

Jean Delvare wrote:
> Mark,
> 
> Could you please take a look at why the p4b_smbus module doesn't compile
> properly on SMB systems?
> 
> Thanks.
> 
