From: mds@mds.gotdns.com (Mark Studebaker)
Date: Mon, 26 Sep 2005 23:10:47 +0000
Subject: [lm-sensors] question about comment in i2c.h
Message-Id: <43386395.1000004@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509221706.AA01312@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509221706.AA01312@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your research matches my recollection.
sorry I left the comment in and thanks Hideki and  Khali for researching.
mds


Jean Delvare wrote:
> Ohaio Hideki,
> 
> 
>>I want to ask about the following comment in i2c.h.
>>What does "one more for read length in block process call" mean?
>>In i2c_smbus_block_process_call and i2c_smbus_xfer_emulated,
>>block[0] is used for the read length.
> 
> 
> As strange as it may sound considering that this comment has been
> around since June 2002, my reading of the code confirms that you are
> right and this comment isn't. Digging through the CVS history, I found
> that the i2c_smbus_block_process_call used to work differently in its
> first incarnation (2002-06-18). It was originally expecing the
> underlying implementation (whether hardware or software emulated) to
> append the received bytes after the sent ones in the data buffer. This
> explains the additional byte required and the comment. It was changed
> to the current logic (received bytes overwrite sent bytes at the
> beginning of the data buffer) a few weeks after (2002-07-08), but the
> changes to union i2c_smbus_data were not reverted.
> 
> I fixed this in i2c CVS (kernel/i2c.h) and lm_sensors CVS
> (kernel/include/i2c-dev.h), and have prepared a patch for Linux 2.6
> which I will send to Greg KH later. You get credits for the discovery,
> thanks a lot for reporting.
> 
> Arigato,


