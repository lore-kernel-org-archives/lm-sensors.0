From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20040418082134.1de9561b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	sensors-detect 
> Log Message:
> (mds) support detection of eeprom shadows we now know are
>       software write-protect registers.

I'm not sure we want to do that. According to a number of datasheets
Rudolf pointed me to yesterday, some EEPROMs will "not care" about what
data you write to their write-protection address. "Any write" will
write-protect the EEPROM. It's not very clear whether it means "any
write byte data" or just any write, which could include quick command 0.

This is the reason why I proposed to scan the 0x30-0x37 range with read
bytes instad of quick command 0. Of course, if we do that, we cannot
detect page protection addresses. But actually, we cannot read from them
and do not want to write to them, so what's the point detecting them?

>       prevent Vaio detection from running more than once.

Mmm, was there a bug before? I can't see what it was. Actually the fact
that I was testing the Vaio EEPROM in all cases was wanted, it was
preventing Vaio EEPROMS from being first announced as SPD EEPROMs, then
Vaio ones. I agree that the second would have had a higher confidence
value anyway, but this reduced the noise for the end user, so it's the
right thing to do IMHO. (Also, there used to be a problem with
conflicting detections implying the same driver twice; sensors-detect
would recommend to exclude the "conflicting" address when loading the
module, while this address was correct and would have worked! I believe
it's now fixed for I2C addresses (but probably not ISA) but this also
explains some places where extra checks were done just to workaround
this issue.) I also agree that this approach reveals that the underlying
detection method is not the best it could be. For now, detection
functions only answer the question "what are the chances that the chip
at address X is Y?" while most of the time the question we would like to
answer to is "if the chip at X is of type Z, which subtype Y is it the
more likely to be?" However I guess it would require too much work to
change sensors-detect in that way now, which is why I had to use tricks
to achieve the same objective.

The fact that we default to SPD EEPROMs is probably not correct, BTW. It
used to be the only EEPROM type found in PCs, but now you have eeprom on
Xeons, Vaios, network adapters and more... I think we should have a
"generic EEPROM" entry and use that if none of the other test worked.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
