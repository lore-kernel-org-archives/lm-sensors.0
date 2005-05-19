From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: LM85
Message-Id: <3E4AECC1.5020203@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4.3.2.7.2.20030211181355.00b62100@mail.dns-host.com>
In-Reply-To: <4.3.2.7.2.20030211181355.00b62100@mail.dns-host.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This looks like a really good start.

Have you looked at doc/developers/new-drivers?
I would like the /proc names to be standard.

If you plan on continuing to work on it, I can do the initial checkin
and you can request CVS access, or send me patches...

Or if you are making changes soon I can wait.
Which would you prefer?




Margit Schubert-While wrote:
> Hi,
>     I took a shot at the LM85 found on eg. Intel D845PE MB among
>     others.
>     At the moment, this is read-only, providing values for voltages,
>     temps, fans, status in /proc/...
> 
>     There are "ifdefs" for the I2C ID and SYSCTL's, so doesn't rely
>     on changes in the normal include files.
>     "inttemp" is the LM85 temp.
>     "proctemp" is the processor temp.
>     "remtemp" is the temp at the edge of the keep-out zone.
>     The rest are obvious.
> 
>     The 2V5 reading, at first glance, looks weird, however it is correct.
>     The 845PESV has 1V5 here, although the scale muliplier is still 250.
> 
>     Register definitions are complete based on the Nat Sem specs at :
>     <http://www.national.com/pf/LM/LM85.html>
