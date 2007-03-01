From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 07:46:02 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070301084602.7395fd00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jasper, please don't send HTML-only e-mails to the lm-sensors list.

Jasper Alias wrote:
> Agreed we should be able to include both base info and
> system info into the system. Maybe we can check the values in
> those fields and then let the system decide with of the two
> contains the most sensible info and select that info field to
> be used.

It might be non-trivial to determine which fields contain relevant
information and which do not. If the fields are empty it's clear they
aren't relevant, but sometimes vendors put random crap in the fields
instead, such as "None" or "System Manufacturer" or "To Be Filled By
O.E.M.". Anyway, as Hans suggested, we don't really need to find out
which fields are most relevant. We can use all four fields as the key
to identify the motherboard, if parts of the key aren't meaningful it
doesn't really matter.

BTW, as the dmidecode maintainer, I have a lot of BIOS ROM images I use
for my regression tests. I can provide the system and board
manufacturer and product strings for all of them, to complement
Rudolf's list, if you are interested.

-- 
Jean Delvare

