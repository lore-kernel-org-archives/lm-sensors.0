From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: 2.6.11-mm3: it87 sensor driver loads but doesn't attach as a
Message-Id: <20050315234827.763f00fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374F80.1030304@fastmail.fm>
In-Reply-To: <42374F80.1030304@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sam,

> I've been trying to get the it87 driver to work on my Gigabyte K8NF-9 
> motherboard.  Found that if I hack out this bit with #if 0:
> 
> #if 0
> #define REALLY_SLOW_IO
>                          /* We need the timeouts for at least some 
> IT87-like chips. But only
>                             if we read 'undefined' registers. */
>                          i = inb_p(address + 1);
>                          if (inb_p(address + 2) != i
>                           || inb_p(address + 3) != i
>                           || inb_p(address + 7) != i) {
>                                  err = -ENODEV;
>                                  goto ERROR1;
>                          }
> #undef REALLY_SLOW_IO
> #endif
> 
> then it loads and works perfectly.  With this in the driver loads but 
> fails silently - the attach client fails.
> 
> Any ideas?  I'm not quite sure what the code is doing here.

See this similar report:
  http://bugzilla.kernel.org/show_bug.cgi?idC35
I attached a patch to the report, which I will send to Greg if you
confirm it works OK for you.

-- 
Jean Delvare
