From: "Eibach, Dirk" <Eibach@gdsys.de>
Date: Thu, 03 Mar 2011 07:53:01 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <48D3D52125C49B43AE880038E2E5314BB5BE6C@SRV101.gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, rdunlap@xenotime.net, linux-doc@vger.kernel.org

Hi Jean,

> Patch applied. Two things I'd still like to comment on:

Ahh, good news :)

> Besides this, there is still more dynamic attribute handling 
> than I expected. It looks OK, but I'll propose a patch making 
> it more static.
> You'll tell me what you think.

I put the attributes in a group because I thought handling single
attributes is clumsy and error prone.
Anyway I am looking forward to your proposal.
Will this be a v5 or a separate patch?

> --
> Jean Delvare

Chhers
Dirk
------------------------------------------------------------------------------------------------
Messe-Highlights 2011. Wir freuen uns auf Ihren Besuch.                                         

CeBIT 2011 
In Hannover - 01.03. bis 05.03.2011 - Halle 12, Stand C50

ATC Global 2011 
Amsterdam - 08.03. bis 10.03.2011 - Halle 9, Stand R404
------------------------------------------------------------------------------------------------
Guntermann & Drunck GmbH Systementwicklung 
Dortmunder Str. 4a 
D-57234 Wilnsdorf - Germany 
Tel: +49 (0) 27 39 / 89 01 - 100  Fax: +49 (0) 27 39 / 89 01 - 120 
E-Mail: sales@gdsys.de - Web: www.gdsys.de
------------------------------------------------------------------------------------------------
Geschaftsfuhrer: 
Udo Guntermann - Martin Drunck - Reiner Ruelmann - Klaus Tocke
HRB 2884, Amtsgericht Siegen - WEEE-Reg.-Nr. DE30763240
USt.-Id.-Nr. DE 126575222 - Steuer-Nr. 342 / 5835 / 1041
------------------------------------------------------------------------------------------------
DQS-zertifiziert nach ISO 9001:2000
------------------------------------------------------------------------------------------------



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
