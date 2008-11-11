From: "=?ISO-8859-1?Q?Jochen_Vo=DF?=" <jochen.voss@googlemail.com>
Date: Tue, 11 Nov 2008 23:50:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <ef1cd66f0811111550x52d4bf1fv23c6e33c8a4b623d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
	 <Pine.LNX.4.64.0811111459300.24267@t2.domain.actdsltmp>
	 <20081111152007.ff508e26.akpm@linux-foundation.org>
In-Reply-To: <20081111152007.ff508e26.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Trent Piepho <tpiepho@freescale.com>, djwong@us.ibm.com, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

2008/11/11 Andrew Morton <akpm@linux-foundation.org>:
> yup.  I wonder why the compiler doesn't do that for itself - is there a
> case where it will generate a different result?

The test program

    #include <stdio.h>
    int
    main()
    {
        signed int x = -1;
        printf("%d %d\n", x/2, x>>1);
        return 0;
    }

says

    0 -1

so it seems to make a difference.

All the best,
Jochen
-- 
http://seehuhn.de/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
