From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <20040425112458.086a0013.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> I would need you to provide the output of the following commands, so
> that I can compare the values the chip really holds with what the
> driver reports:
> 
> isadump 0x2e 0x2f 7 0x09
> isadump 0x2e 0x2f 7 0x0d
> isadump 0x2e 0x2f 7 0x0e

Don't! I got it wrong here. The correct commands are:

isadump 0x2e 0x2f 0x09 7
isadump 0x2e 0x2f 0x0d 7
isadump 0x2e 0x2f 0x0e 7

Sorry for the bogus info, I should have checked before sending.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
