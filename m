From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: adm9240.c review
Message-Id: <20040814221209.46166172.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040812194946.721317b0.khali@linux-fr.org>
In-Reply-To: <20040812194946.721317b0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > >     Copyright (c) 1999  Frodo Looijaard <frodol@dds.nl>
> > >     and Philip Edelbrock <phil@netroedge.com>
> > > 
> > >     Copyright (c) 2003 Michiel Rook <michiel@grendelproject.nl>   
> > >     
> > 
> > Copyright is (C), not (c).
> 
> No it isn't.  Or so says the copyright lawyers at my employeer :)

Huh?

http://archives.andrew.net.au/lm-sensors/msg04630.html

There you said:

> + * Copyright (c) 2003  Jean Delvare <khali@xxxxxxxxxxxx>
                 ^- should be "(C)" to be legal.  So says the lawyers
		 who know these things.

Which is why this "conversion" is part of my chip driver porting guide
(Documentation/i2c/porting-clients).

Have lawyers changed their minds in the meantime, or am I missing
something?

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
