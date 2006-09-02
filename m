From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 15:36:40 +0000
Subject: [lm-sensors] Analog Devices ADT7462
Message-Id: <20060902173640.5970e233.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <461784320609011632v550711e1md80dd2f360423528@mail.google.com>
In-Reply-To: <461784320609011632v550711e1md80dd2f360423528@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juergen,

> maybe the ADT7462 is in some way compatible with the ADT7463 like 
> the ADT7475 is compatible with an ADT7463.

Did you check the datasheets? You shouldn't trust the numbers. For
example the ADM1027 and the ADT7463 are mostly compatible, but the
ADT7461 and ADT7463 are completely different chips.

The ADT7462 appears to be a rather big chip with many inputs (4
temperatures, up to 13 voltages and up to 8 fans!), way more than the
ADT7463. I would be surprised if they were compatible, but only a
careful comparison of the datasheets (which I don't have the time to
achieve) can tell for sure.

> I have tried to use the lm85 driver. (The ADT7475 is missing the Vid Inputs.)
> 
> My first attempd was to force the ADT7463 with (...)

_That_ was a subtle attempt to remind me that I could reply to your
other posts to the list about the ADT7475 ;) I'll answer later today,
be patient.

-- 
Jean Delvare

