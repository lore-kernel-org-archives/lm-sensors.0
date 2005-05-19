From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <200406240828.i5O8SMTD041749@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Quoting myself:

>Please provide the output of the following dumps:
>
>isadump -f 0x6620
>isadump -f 0x6640

Actually you should instead do:

isadump -f 0x6620 16
isadump -f 0x6640 16

Thanks,
Jean Delvare
