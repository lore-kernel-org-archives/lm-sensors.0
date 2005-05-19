From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Tickets #1350
Message-Id: <20030801110501.5fa15456.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030801172230.6479.M9841@iijmio-mail.jp>
In-Reply-To: <20030801172230.6479.M9841@iijmio-mail.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am thankful for Alexander Amalysh and Mark M. Hoffman.
> This is the second reply of ticket #1350.
> I could solve the problem.

Remember, I'm not sure the fix is meant to be definitive, so let us know
if it causes any side effect please.

> But now, sensors-detect(cvs version) says syntax error.
> 
> # sensors-detect
> syntax error at /usr/local/sbin/sensors-detect line 2604, near ")
>   push"
> Execution of /usr/local/sbin/sensors-detect aborted due to compilation
> errors.

Stupid me, I forgot a semicolon there. I really should have tested
sensors-detect before commiting (but the change was so trivial...).
Thanks a lot for reporting this. Fixed in CVS, check it out and it
should be OK.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
