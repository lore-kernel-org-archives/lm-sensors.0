From: starless@spin.it (Marco De Vitis)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: p4b_smbus and other modules
Message-Id: <1917399904.20040224014912@spin.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <485309134.20040121132926@spin.it>
In-Reply-To: <485309134.20040121132926@spin.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, on 09/02/2004 at 19.48 you wrote:

>> The problem is that, when issuing the first command "insmod
>> p4b_smbus", lots of error lines are reported to syslog.

> You should never have two modules with the same name. This is likely to
> cause the problem you encounter. You should rename one of them so you
> are sure to load the one you want. That said, their module may work as
> well, so you could simply consider not using lm_sensors' one.

I removed lm_sensors' one, and now the system tells it's using its own
one, but I get the same errors.

I also tried adding p4b_smbus in /etc/hotplug/blacklist (yes, it seems
the right place to do it), but I still get the same identical errors.
I also rebooted, just to be sure I tried on a clean startup.

Does anyone have any other clue?

> Hope that helps and sorry for not answering before, I don't know much

No problem, I largely compensated with the delay in my answer. ;)
Sorry but I only recently found the time to do the tests while nobody
was using the machine.

-- 
Ciao,
  Marco.

.."Homogenic", Bj?rk 1997
