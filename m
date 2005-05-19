From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [Soekris] Re: PC87366 with the net4801
Message-Id: <20040630225740.02ef3c60.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <91E705F1F7FF9FD061ADEF73@bingo.lan.spacehopper.org>
In-Reply-To: <91E705F1F7FF9FD061ADEF73@bingo.lan.spacehopper.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> <http://phk.freebsd.dk/soekris/env4801/> may help, though I don't
> think temperature values are processed at all. Scales for voltage
> readings are included.

Quite an interesting read, which offered me some paths to follow. Input
voltage data is very incomplete but that's still something to start
with. The guy also does some additional chip reconfiguration, some of
which I want to try.

Andrew, I updated the driver in CVS. Could you please check it out and
give it a try? You'll have to pass init=2 so that the new init sequence
is activated. Let me know if it changes the results in any way.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
