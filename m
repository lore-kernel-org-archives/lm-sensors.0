From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Dependency problem during compile
Message-Id: <1073652201.3ffea1e971fbb@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073609543.32040.73.camel@localhost>
In-Reply-To: <1073609543.32040.73.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The kernel has been compiled and i'm using it successfully.
> 
> It still looks to me as if the dependancies are being incorrectly
> worked out by the make file.

Did you change anything in the Makefile but KERNELVERSION (wasn't
actually needed AFAICT) and LINUX?

If the above mentioned kernel is the one you are currently running, you
shouldn't have to edit the Makefile at all, it should pick the right
directory directly. Didn't that work?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
