From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <20041124214339.248df452.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41A4C939.8050404@jonrkc.com>
In-Reply-To: <41A4C939.8050404@jonrkc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Try as I may, all I can get by redirecting this command is 
> the output
> of the bare "sensors" command.  I get a WHOLE LOT of output
> in the terminal window, but it's so much I can't select it and
> copy it here.  Can you tell me a way to provide this 
> information?

strace sensors > strace.out 2>&1

> The rest of your requests worked OK in terms of copying them,
> and here they are, in each case following your request.

OK, they confirm that your system is "sane". Version of libsensors
matches sensors' and there are no obvious library duplicates in the way.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
