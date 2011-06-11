From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jun 2011 13:12:53 +0000
Subject: Re: [lm-sensors] Testing results for Nuvoton W83677HG-I
Message-Id: <20110611151253.62ac8929@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD783EB.5010606@gmail.com>
In-Reply-To: <4DD783EB.5010606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, 29 May 2011 23:49:02 +0400, Arseny Klimovsky wrote:
> Jean Delvare пишет:
> > On Sun, 29 May 2011 17:47:18 +0400, Arseny Klimovsky wrote:
> >> 2. Statement "ignore temp5" does not take effect. I see line about "PECI
> >> Agent 1"
> > Maybe it's not temp5 but temp6 or more. Try "sensors -u" to find out
> > the right number.
> Thank you, Jean!
> I've tried temp5..7 and no results. But with "sensors -u" it figured out 
> to be temp8 :)
> 
> I think the configuration can now be added to wiki, I've attached the file.
> According to the message
> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-March/031775.html
> this confguration can be used for DH67CL board, possibly with very small 
> changes.

Added to the wiki:
http://www.lm-sensors.org/wiki/Configurations/Intel/DH67BL

Thanks for your contribution!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
