From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors messages
Message-Id: <20030917230242.6a3a648e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030916214501.3cef3d5c.khali@linux-fr.org>
In-Reply-To: <20030916214501.3cef3d5c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok, I'll see what I can do.  Can you tell me the exact part number of
> the problem chip?

I don't think there is any part number.

After reading our docs again, I have to correct what I said here:
"Some [Thinkpads] do contain special memory chips that lm_sensors can
corrupt."
This isn't the truth. They contain *EEPROMS* we can corrupt. I
misexpressed myself because EEPROMs are usually found on memory chips,
but I don't think it is the case here.

So, I believe there is no part number to be after, but instead the
reference of the faulty EEPROM. It is the Atmel 24RF08 ("an unusual, 8K
that contains a RFID (Radio Frequency ID) port for wireless access, and
elaborate access protection mechanisms", according to our docs).

I understand that it would be easier for you (or anyone) to look for a
part number, but I'm almost sure that there isn't any here.

Thank you for any help you can provide, and first for trying at least :)
This is very appreciated.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
