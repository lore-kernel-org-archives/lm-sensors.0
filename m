From: mds@mds.gotdns.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: website/man isadump.html
Message-Id: <420FDDE8.8090600@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050213092410.5a28015e.khali@linux-fr.org>
In-Reply-To: <20050213092410.5a28015e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

works for me w83627hf and vt1211
also verified that w/o -k, after some reads, winbond returns 00, via returns ff.
mds

Jean Delvare wrote:
>>Modified Files:
>>	isadump.html 
>>Log Message:
>>(mds) -k
> 
> 
> BTW, everyone with a Super-I/O chip is invited to test that he/she can
> now dump its logical devices by using the new -k option of isadump.
> 
> The reason why I added this is that I noticed that Winbond Super-I/O
> chips will lock themselves out after an arbitrary number of registers
> have been read. So unlocking the chip with isaset and then dumping it
> with isadump would only show the first dozen registers, and then 0xff
> everywhere.
> 
> Now that we can pass the key to isadump itself, it will repeat it after
> every row, so we should be able to dump the chip contents up to the last
> register.
> 
> Thanks,

