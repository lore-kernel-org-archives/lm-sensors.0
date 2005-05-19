From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030627094021.1908b939.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok here are the two results snipped for ITE detection....

I guess there were similar errors (Malformed UTF-8 character) for some
other chipsets?

Anyway, I'm stumped. I was expecting your system to return UTF-8 chars
from /dev/ports, and it doesn't seem so (or why would perl say they are
malformed?) And if it returns regular chars, why are the values
different from the ones obtained with a non-UTF-8 locale?  I just don't
understand.

So from here I only see two possibilities:

1* Opening /dev/ports in binary mode solves the problem (which I doubt,
since traditionally, Unix systems don't differenciate text and binary
modes). Please grab the modified script that does this and tell me if it
works:
  http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k3

2* I just don't know what we can do. In this case, the only thing I can
propose is checking for the LANG environment variable, and generate a
warning at start is if matches *.UTF8, stating that the user should
better restart the script with a non-UTF-8 locale. We can even change
the LANG environment variable in the script, but I don't know if that
would work (I don't know if Perl "reads" it at the beginning, once for
all, or each time its value matters). Jim, would you accept doing some
more tests for us?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
