From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: LM83 test resport (was:  Adapter driver for opencores I2C fpga)
Message-Id: <20030827124933.4a4723c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B397@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B397@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Yes, it works fine, though I have modified it quite a lot. 
> > The version I got with the 2.8.0 release had four repeats
> > of essentially the same code, apart from register addresses,
> > so I merged them into a single function.
> > I then added some extra status information. I was planning to 
> > look at the latest in CVS on Monday or Tuesday to see if I had
> > duplicated any effort before offering this code back.
> 
> Heh - the latest code in CVS has exactly the same changes, almost
> word for word, as I had made. So I have junked my code and am
> using the CVS version instead. 

Although I don't like the idea of duplicated work very much, it's great
to see we came to the same point :)

> It continues to work just fine, within the limits of testing:
> we use the /proc interface to look at sensor values, but none
> of the application level stuff like sensors-detect - we made
> the boards, so we already know what chips are on them :-)

If it works for you, that's great. Let me (or us) know if you need any
additional feature, or whatever. I think the driver if almost complete,
but sometimes users need to setup things in a way we wouldn't have
thought of.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
