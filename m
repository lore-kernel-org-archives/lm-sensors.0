From: monmotha@indy.rr.com (MonMotha)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Any update on a driver for the PCA9555?
Message-Id: <400C15D6.90301@indy.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CEA6A588893A0A47915874C1E8FF2307A4CBA1@rtp-msexch-01.rtp.extremenetworks.com>
In-Reply-To: <CEA6A588893A0A47915874C1E8FF2307A4CBA1@rtp-msexch-01.rtp.extremenetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>I was wondering if there was any update on a driver for the PCA9555. 
>>From the mailing-list archive is looked like someone was going to be
>>working on it.
> 
> 
> Right, MonMotha once told he would write a driver but we have no news
> since July 2003.
> 
> MonMotha, how is it going?
> 

I have something written, but I don't seem to recall even compiling it.

What happened was that our motherboard (Which actually has an SMBus header on it 
to hook dohickeys up to) seems to have the SMBus controller disabled (it doesn't 
show up in lspci or anywhere, and nothign seems to be able to identify 
anything), so we scratched our plans to use the PCA9555.

I can provide the driver to you if you like, but again, I can't guarantee that 
it will even compile (however, if it doesn't, the fixes are probably just minor 
things like syntax errors).  I think I have everything down to where it should 
be pretty easy to get working.

If you would like the file, just reply and I'll forward the source on to you.

--MonMotha


