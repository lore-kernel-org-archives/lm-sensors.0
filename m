From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Super-I/O chips
Message-Id: <4071F465.7020308@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040403134242.2c50813d.khali@linux-fr.org>
In-Reply-To: <20040403134242.2c50813d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Note that none of the drivers suupport 0x4E so if sensors-detect does turn up
anything there, it will definitely generate mail to us, which is good.

Jean Delvare wrote:
> Hi Alex,
> 
> I noticed that MBM does search for Super-I/O (LPC) chips at addresses
> $2E and $4E. For the moment we only search at $2E. $4E looks like an
> alternate address, I'd say it would be used only if there were two
> Super-I/O chips on a given system.
> 
> I'm considering adding $4E to our detection script. Could you tell me
> whether you already found anything at this address?
> And was there a Super I/O chip at $2E too in this case?
> Maybe I will scan $4E if and only we already found something at $2E.
> 
> Thanks.
> 
