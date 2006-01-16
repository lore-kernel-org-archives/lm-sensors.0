From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Mon, 16 Jan 2006 02:05:23 +0000
Subject: [lm-sensors] New device: SMSC's  EMC6W201 -support?
Message-Id: <43CAFF63.30305@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060115233832.76526.qmail@web81604.mail.mud.yahoo.com>
In-Reply-To: <20060115233832.76526.qmail@web81604.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ric Johnson wrote:

>There is a PDF product brief, EMC6W201 Data Brief,  available here:
>http://www.smsc.com/main/datasheets/6w201db.pdf
>  
>
Unfortunately, this does not include a list of the registers and their 
definitions.  Without which a driver is much more difficult to write.

>I have no idea if the company will provide the eval board for software
>development at no cost during some evalution period or if one has to buy the
>eval board. I did not find a way to purchase the eval board.  I presume that
>means one has to complete a technical support form and request information:
>https://www2.smsc.com/mkt/intforms.nsf/faemail
>  
>
What would be more helpful would be a full datasheet.

 From the "Data Brief," it isn't clear if this chip is compatible with 
the EMC6D100 or EMC6D102 which *are* supported by the lm85 driver.  It's 
got too more temperature inputs...  You might try forcing the lm85 
driver to grab the emc6w201 (if you can figure out what address it's at 
using i2cdump).

:v)

