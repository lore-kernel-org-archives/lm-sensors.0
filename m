From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 09:01:55 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080506110155.04caf685@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 04 May 2008 10:38:34 +0200, Rudolf Marek wrote:
> ICS is now part of IDT. They sent to me the datasheet for my clockchip, quite 
> fast. Please just make sure you read the chip labels correctly and I can try to 
> write them once we know 100% that the chip names matches reality. I sometimes 
> take a macro pictures of the chips instead of using magnifier.

A guy at IDT just sent me the datasheet for the ICS9LPRS477C. It is a
clock chip living at 0x69 and it uses SMBus block mode. So it's
definitely not the mysterious chip at 0x2e...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
