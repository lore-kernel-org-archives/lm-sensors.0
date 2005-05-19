From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: driver design question
Message-Id: <3F287292.8050501@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> * Philip Edelbrock <phil@edgedesign.us> [2003-07-29 09:50:45 -0700]:
> 
>>Jean Delvare wrote:
>>My idea of the ideal driver is that it is almost transparent to the 
>>hardware.  The less caching, the better.
> 
> Much as I try, I can't jump off the fence here.  OOH, it seems wasteful to
> keep re-reading what are almost certainly non-volatile h/w registers.  OTOH,
> what are we optimizing here? - a special purpose slow bus that has nothing
> better to do (I2C); or an insignificant amount of ISA port IO.

Don't under-estimate the delays associated with doing ISA port I/O.  It 
can take *thousands* of clock cycles to perform just one port I/O 
instruction.  The kernel even uses I/O to port 0x80 as a short timing delay.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
