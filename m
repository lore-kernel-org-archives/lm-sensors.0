From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 19:44:48 +0000
Subject: Re: [lm-sensors] [PATCH v2 6/7] sensord: Use sigaction() for signal
Message-Id: <20090512214448.4957ba16@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160419.GG17530@ubuntu>
In-Reply-To: <20090511160419.GG17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 18:04:19 +0200, Andre Prendel wrote:
> Replace the deprecated signal() function by sigaction().
> 
> The signal() function has some disadvantages. This patch replaces
> signal() by sigaction() to install the signal handlers.
> 
> Changes in v2:
> 
> Zero sigaction structure.

Looks good, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
