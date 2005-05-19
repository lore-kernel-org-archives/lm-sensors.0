From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <20040125185940.402f81c5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Maybe there should be something added to the error message that this
> can also be caused by wrong settings in sensors.conf

Well, that kind of error isn't supposed to be present (even in a
commented out state) in the default configuration file. And users are
not supposed to add random commands in there either.

> > Thanks for the report.
> 
> Thanks for helping me, even the problem was that simple and caused by
> me:) 

Let us share the guiltiness, since the default configuration file was
error-prone.

For one thing, it confirmed that I should always ask for a strace first.
Looks like it solves half of the problems with sensors and sensors -s.

I'll be closing your ticket.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
