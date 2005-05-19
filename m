From: jbpn@cambridgebroadband.com (John Naylon)
Date: Thu, 19 May 2005 17:31:10 +0000
Subject: [lm-sensors] Memory leak in sensors_get_label()
Message-Id: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

  there seems to be a minor memory leak in the sensors_get_label() call 
in the lm-sensors library, version 2.9.1.  The code in question is as 
follows, from lib/access.c:

[...]

171     } else if (alt_featureptr && 
172                !strcasecmp(alt_featureptr->name, chip->labels[i].name)) {
173       if (*result)
174         free(*result);
175       if (! (*result = strdup(chip->labels[i].value)))
176         sensors_fatal_error("sensors_get_label","Allocating label text");
177     }
178 if (! (*result = strdup(featureptr->name)))
179   sensors_fatal_error("sensors_get_label","Allocating label text");
180 return 0;

  You can see that if line 175 gets executed, then the memory it allocates
is going to be leaked at line 178 where the *result pointer is overwritten.

  It seems to me that there should either be a "return 0;" statement 
between lines 176 and 177, to return with *result pointing at the copy of 
chip->labels[i].value, or else *result should not be being assigned in
this instance.  To be honest, I don't really understand what the code here
is trying to achieve, being a bit of an lm-sensors noob -- I was only
looking at it to track down the memory leak.  Hopefully you can advise
what the correct fix is.

  Clearly this isn't a problem for one-shot programs, but polling twice
a minute we are leaking about 100 bytes a time, which is over 200k per
day -- a bit of a nuisance on an embedded platform.

  Cheers,

John
-- 
Dr. John Naylon
Cambridge Broadband Ltd. // www.cambridgebroadband.com


