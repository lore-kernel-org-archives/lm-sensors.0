From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-sis630 driver (fixed?)
Message-Id: <200308012322.02060.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030801230134.6fdf60dc.khali@linux-fr.org>
In-Reply-To: <20030801230134.6fdf60dc.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Mark,

i do not know what is to do here :(
i2c-sis630 is not a pci driver and should not claim any pci devices. 
i2c-sis630 use only io ports and pci device look up used only in order to 
determine if it a right sis chip et all. I want to revert pci changes and 
commit it, if nobody has any objections.

Mark, what do you think about it? Why should be such detect method not 
accepted in 2.4.X ?

On Friday 01 August 2003 23:01, Jean Delvare wrote:
> Mark, Alexander,
>
> Is the i2c-sis630 driver considered fixed or not? Shall I close the
> tickets 1350 and 1351?
>
> (My reading of the thread makes me think there still is a discussion
> about what should be done, but I don't know what I am supposed to do
> with the tickets.)

-- 
Best regards,
Dipl.-Ing.
Alexander Malysh
