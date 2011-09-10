From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 10 Sep 2011 17:58:04 +0000
Subject: Re: [lm-sensors] Can't read DIMM SPD info (DDR2)
Message-Id: <20110910195804.51cb1391@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.v1lposq116tawo@esprimo>
In-Reply-To: <op.v1lposq116tawo@esprimo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 10 Sep 2011 18:35:06 +0200, Michal Zatloukal wrote:
> Hi,
> I'm unable to get decode-dimms to display SPD info from my memory modules.  
> Can someone please advise on finding the problem? The eeprom module is  
> loaded. This is on both my main system (Kubuntu 10.10) and "latest"  
> (Kubuntu 11.10 daily) - linux 3.0, lm-sensors 3.3.0-4 and i2x-tools  
> 3.0.3-5). The HW is a Fujitsu Esprimo Mobile U9200 laptop (intel GM965).  
> FWIW, the memtest that ships with 'buntu 11.10 (4.20 I think) reads the  
> SPD info successfully.

Wrong mailing list, this has nothing to do with hardware monitoring.
Try linux-i2c:
http://vger.kernel.org/vger-lists.html#linux-i2c
(This is an open list, no need to subscribe.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
