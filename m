From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <20040625204449.64c7f39a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'll do a few fixes to the driver this evening, including more
> debugging messages, this should help us deal with the temperatures.
> I'll let you know when I have something for you to test.

OK, updated. I didn't actually add debugging messages, only changed them
a bit. They look almost fine already. Plus I fixed the fan_div bug.
Please check it out and use if possible.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
