From: fabrice@yako.via.ecp.fr (Fabrice Ollivier)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <20030722111724.GA31201@yako.via.ecp.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Can you force make to use bash as its shell (uncomment the SHELL= line
> at the beginning of the Makefile)? Does it work?
Hehe, no :)

> Or maybe its is caused by a too recent gcc version (no idea why though),
> could you try an older one? You seem to have many versions of gcc on
> your system.

It try with gcc 3.3 , 3.2 ,3.0 and 2.95 : no result.

Are you sure the bug come from that ? I had the same problem with i2c 
CVS and it have been fix (but I don't know how and i can't remember 
when, maybe one week or two, but maybe more).

-- 
Fabrice
