From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Sensors and grsecurity
Message-Id: <41C9AF9A.7080003@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41C993CC.4060408@edeca.net>
In-Reply-To: <41C993CC.4060408@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> I have been trying to get sensors and grsecurity playing nicely
>> however it seems that this is impossible if /dev/port restrictions are
>> enabled.
>> Unfortunately, these restrictions come along with the ones on /dev/kmem
>> and /dev/mem, so I don't really want to disable them.
>> 
>> If my W83697HF only detects on the ISA bus, is it going to be
>> impossible to read data from it without access to /dev/port?
> 
> The sensors-detect script uses /dev/port, but the driver itself
> obviously doesn't (since it belongs to kernel space). Thus there should
> be no issue (other than sensors-detect not working, but if you already
> know which devices you have, you don't need it anyway.

My apologies for the question, I realise in hindsight that it does not
make sense!  Of course the driver doesn't use /dev/port, it works fine
with the restrictions enabled.

Thanks again for your help,

David
