From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Dependency problem during compile
Message-Id: <20040214111029.30c928ae.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073609543.32040.73.camel@localhost>
In-Reply-To: <1073609543.32040.73.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Do you have any thoughts about what is wrong?

Not really, I admit.

> Was I correct in thinking that I can compile against a different
> kernel than the one running on the compile system? The target system
> is an EPIA box.

Yes, this is correct. I have done it myself a few times and it worked.
But you also want to install the target files in various places, what I
didn't do myself.

One more question, how did you install i2c before installing lm_sensors?
Is your Epia kernel i2c-patched, or did you install i2c separetely? This
changes the place where lm_sensors has to look for headers, maybe this
is a part of the problem you have.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
