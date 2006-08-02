From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Wed, 02 Aug 2006 14:01:22 +0000
Subject: [lm-sensors] Second request to support the 'Analog Devices
Message-Id: <20060802140122.GA9326@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <449408C1.1000307@dolbeau.org>
In-Reply-To: <449408C1.1000307@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 17 Jun 2006, Romain Dolbeau wrote:
> Henrique de Moraes Holschuh wrote:
> > *If* the chip looks very much like an lm85 or an ATDT7463, *and* you get us
> > a full datasheet, we can try to do a spec-sheet-based change to lm85 and
> > carefully review it before you try.  At least it shouldn't oops the kernel
> > :-) and chances are it will actually work fine.
> 
> <http://www.analog.com/UploadedFiles/Data_Sheets/402263009ADT7476_a.pdf>
> 
> Whenever there's some code to try, I can schedule some downtime
> to test (I just can't do it too often).

Romain,

I am sorry but I have had no time to work in lm85 as of lately.  I didn't
forget your request, but I have done zero work on lm85 on the last three
months, which does not bode well for merging atdt7463 with the kludge fixes
I have locally for adm1027 fan support.

Just so you are not left hanging without any clue of what is going on, even
if the news are not good :(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

