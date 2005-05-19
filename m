From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: VID specifications
Message-Id: <3CC0D9CF.733801B6@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CBEB764.C4261708@paradyne.com>
In-Reply-To: <3CBEB764.C4261708@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Trent,
I put programmable VRM support in w83781d in CVS.
I changed VID from 2 decimal points to 3.
Please look in doc/vid and kernel/include/sensors_vid.h
and give it a try.
'set vrm 9.0' should work too.
mds


"Mark D. Studebaker" wrote:
> 
> Thanks for the great research and suggestions.
> We'll have to think of the best way to incorporate them.
>
> Trent Piepho wrote:
> >
> > I've been getting lm_sensors
