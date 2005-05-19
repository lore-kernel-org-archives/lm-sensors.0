From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Fix in eeprom.c
Message-Id: <406A0A87.3010400@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329193435.7d9a587d.khali@linux-fr.org>
In-Reply-To: <20040329193435.7d9a587d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed

Greg KH wrote:
> On Tue, Mar 30, 2004 at 08:40:07PM +0200, Jean Delvare wrote:
> 
>>Greg, I would be interested in your opinion. Should we update all our
>>chip drivers to have two memory allocations instead of a single one for
>>this?
> 
> 
> Yeah, we probably should :(
> 
> thanks,
> 
> greg k-h
> 
> 
