From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <vjsJjNPg.1107938587.6808420.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

> SUCCESS! Here is the latest output:
> (...)
> Probing for `Winbond W83627EHF Super IO Sensors'
>   Success... found at address 0x0290

Great. This is half a success only though, since it confirms the address
0x290, where the ISA device was *not* properly detected.

Can you please provide the output of "isadump 0x295 0x296"? Maybe there
is yet another inaccuracy in the datasheet.

Are you 100% sure that this is a W83627EHF chip you have? ;)

Thanks,
--
Jean Delvare
