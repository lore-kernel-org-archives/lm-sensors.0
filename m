From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: Fw: RE: ADM1025 documentation
Message-Id: <20030729142821.37e453b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728175341.456aa888.khali@linux-fr.org>
In-Reply-To: <20030728175341.456aa888.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


These guys (and lady, for that matter) have a real support service!
That's really great :)

Begin forwarded message:

Date: Tue, 29 Jul 2003 12:53:17 +0100
From: "Burke, Mary" <Mary.Burke@analog.com>
To: <khali@linux-fr.org>
Subject: RE: ADM1025 documentation


Hi Jean

Thanks for the feedback. I will include those edits in the next revision

Thanks and Regards
Mary


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 28 July 2003 16:54
To: Burke, Mary
Cc: LM Sensors
Subject: ADM1025 documentation



Hi Mary,

While working on our Linux driver for the ADM1025 today, I noticed a
pair of errors or inconsistencies in the ADM1025 datasheet (revision C).
I thought you would want us to report so that they can be fixed in the
next revision.

1* The description of pin 16 (in the Pin Function Descriptions table,
page 4) make the reader think that only the lowest order bit of the I2C
address can be changed, while the last *two* bits can be (three possible
addresses total).

2* It isn't very clear that the reference value for VCCP is 2.25V. I
first thought it was depending on the actual VID value. I could figure
out the truth by reading table II (A/D Output Codes vs. Vin, page 9) but
I think it should be more explicit.

3* In table X (page 15), bit 6 description, typo found: "tHhe" should be
"the".

Thanks for your support! :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
