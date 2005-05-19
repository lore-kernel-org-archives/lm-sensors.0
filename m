From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Call for 2.9.0
Message-Id: <41CC3BD6.1070304@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed. I bumped libsensors.
Phil, at your convenience....
merry christmas.
mds

Jean Delvare wrote:
> Quoting myself:
> 
> 
>>Can we schedule a release for next week?
> 
> 
> I just verified compatibility with old kernels back to 2.4.10, and
> commited a couple trivial fixes for this. 2.4.9 is no longer supported,
> as it would require more work than is worth (most notably because
> MODULE_LICENSE doesn't exist back there).
> 
> I also reviewed the documentation and updated it where needed, most
> notably to reflect the fact that 2.4.10 is now the oldest supported
> kernel, and also to discard references to the now gone bttv
> compatibility issue.
> 
> I think we are ready for a release. Libsensors version will need a bump,
> not exactly sure if we would number it 3.0.7 or 3.1.0.
> 
> I will be mostly away from the Internet for the next few days. Feel free
> to release while I am gone unless a problem arise.
> 
> Thanks,
