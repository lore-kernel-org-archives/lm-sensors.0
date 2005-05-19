From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <1063972933.3f6af0452f979@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Preben Randhol <randhol+vim@pvv.org>:

> Jean Delvare <khali@linux-fr.org> wrote on 19/09/2003 (09:58) :
> > Anyway, you're always free to edit /etc/sensors.conf and use your
> > favorite formula here, as long as it works for you.
> 
> I understand. I have one tiny problem though. I want to use this
> formula:
> 
>    compute temp1 (19.222-0.064912*@+0.017212*@*@), 
> 
> however I cannot compute this number back to @ as there is no sqrt
> function.

We introduced the exp and ln functions some months ago, so you could use them.
The exp function is written ^ while the ln function is written `. Since sqrt(x)
is x at the power 1/2, and x at the power y is exp(y*ln(x)), you can use the
forumla ^((`@)/2) for sqrt (not sure how many levels of parenthesis are needed).

> Why do one need to convert this number back? Can I only use @
> after the comma?

The first part is used when reading values from the chip, while the second is
used when writting to it. This is done each time you set a limit, so yes, this
is required.

However, if the ^((`@)/2) trick above doesn't work, you could consider using the
linear formula you were proposing the other time, instead of the more complex
2nd degree polynom, and get rid of the problem. It's unusual to have different
(well, non-reciprocal) formulae on a given line, but that's one case were we
could consider doing so.

> Thanks in advance.

You're welcome. Let us know when you come to a "definitive" formula, and we'll
consider adding it to the default config file, or somewhere in our docs.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
