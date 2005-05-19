From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ADM1025 documentation
Message-Id: <20030728175341.456aa888.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


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
